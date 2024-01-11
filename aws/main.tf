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

resource "aws_spot_instance_request" "instance" {
  count = var.create_ec2 ? 1 : 0
  ami   = data.aws_ami.ubuntu.id

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
    BASICAUTH   = "${lower(join("", regex("^(.).* (.*)$", var.user_name)))}:${var.basic_auth_password}"
    DOMAIN_NAME = var.domain_name
    USER_NAME   = var.user_name
    LOGLEVEL    = var.loglevel
    TRAINING    = var.training
    USESSL      = "yes"
  }))
}