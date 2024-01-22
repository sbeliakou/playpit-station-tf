/**
 * # Playpit EC2 Instance on AWS
 *
 * ## Description
 * This Terraform code provisions an Playpit environment on an AWS EC2 instance. 
 * 
 * ### Provision details:
 * 
 * - Creates an EC2 instance with the specified configuration.
 * - Sets instance name, hostname, and other attributes.
 * - Configures metadata, instance type, security rules and tags.
 * - Defines instance-specific metadata, such as login credentials, startup script, etc.
 * - Configures scheduling options for preemptible instances.
 * - Defines boot disk details, including auto-delete, image, size, and mode.
 * - Configures network interface details, such as network, subnetwork, and access configuration.
 * - The user-data script installs the Playpit stack, configures SSL with Let's Encrypt and sets Basic AUTH by the provided settings (username/password)
 * - EC2 SPOT instance utilizes Instance storage for the best price trade-off
 * 
 * The code incorporates dynamic values through Terraform variables (`variables.tf` and `override.tf`).
 * 
 * To define your stack configuration, the following steps should be done:
 * 
 * 1. Create a new file `override.tf` from current `variables.tf`
 * 2. Define your settings corresponding to your AWS account, training specification and set up the proper Student's name, define a password for Basic AUTH
 * 3. Create EC2 instance with `make up` command
 * 4. Destroy EC2 instance with `make down` command
 * 
 * The current configuration doesn't cover:
 *
 * - VPC and subnet creation - the existing names should be provided in `override.tf` file
 * - VPC is to be chosen by the provided "tag:Name", and the subnet is chosen by Availability Zone - improve this code for more flexibility if needed
 * - Security group enables https access from your public IP Address - "var.my_ip" is provided from Makefile
 *
 */

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
  filter {
    name   = "availability-zone"
    values = [var.availability_zone]
  }
}

resource "aws_security_group" "playpit_station_access" {
  name        = "playpit-station-access"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = data.aws_vpc.this.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.myip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.myip]
  }
}

resource "random_id" "instance_id" {
  byte_length = 4
}

locals {
  instance_name    = "playpit-vm${random_id.instance_id.hex}-${var.training}"
  basic_auth_login = lower(join("", regex("^(.).* (.*)$", var.user_name)))
  public_fqdn      = format("%s.%s", replace(aws_spot_instance_request.instance.public_ip, ".", "-"), var.domain_name)
}

resource "aws_spot_instance_request" "instance" {
  ami = data.aws_ami.ubuntu.id

  spot_price           = var.spot_price
  spot_type            = "one-time"
  wait_for_fulfillment = true
  # block_duration_minutes = [60]

  instance_type = var.instance_type
  key_name      = var.ec2_sshkey_name

  vpc_security_group_ids = [
    aws_security_group.playpit_station_access.id
  ]

  subnet_id                   = data.aws_subnets.public.ids[0]
  associate_public_ip_address = true

  ephemeral_block_device {
    device_name  = "sdb"
    virtual_name = "ephemeral0"
  }

  user_data_replace_on_change = true
  user_data = base64encode(templatefile("user-data.sh.tpl", {
    BASICAUTH   = "${local.basic_auth_login}:${var.basic_auth_password}"
    DOMAIN_NAME = var.domain_name
    USER_NAME   = var.user_name
    LOGLEVEL    = var.loglevel
    TRAINING    = var.training
    USESSL      = "yes"
  }))

  tags = {
    Name = local.instance_name
    Training = var.training
    Student = var.user_name
  }
}