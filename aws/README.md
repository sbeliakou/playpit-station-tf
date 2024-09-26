# Playpit EC2 Instance on AWS

## Description
This Terraform code provisions an Playpit environment on an AWS EC2 instance.

### Provision details:

- Creates an EC2 instance with the specified configuration.
- Sets instance name, hostname, and other attributes.
- Configures metadata, instance type, security rules and tags.
- Defines instance-specific metadata, such as login credentials, startup script, etc.
- Configures scheduling options for preemptible instances.
- Defines boot disk details, including auto-delete, image, size, and mode.
- Configures network interface details, such as network, subnetwork, and access configuration.
- The user-data script installs the Playpit stack, configures SSL with Let's Encrypt and sets Basic AUTH by the provided settings (username/password)
- EC2 SPOT instance utilizes Instance storage for the best price trade-off

The code incorporates dynamic values through Terraform variables (`variables.tf` and `override.tf`).

To define your stack configuration, the following steps should be done:

1. Create a new file `override.tf` from current `variables.tf` 
2. Define your settings corresponding to your AWS account, training specification and set up the proper Student's name, define a password for Basic AUTH
3. Create EC2 instance with `make up` command
4. Destroy EC2 instance with `make down` command

The current configuration doesn't cover:

- VPC and subnet creation - the existing names should be provided in `override.tf` file
- VPC is to be chosen by the provided "tag:Name", and the subnet is chosen by Availability Zone - improve this code for more flexibility if needed
- Security group enables https access from your public IP Address - "var.my\_ip" is provided from Makefile

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.6.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.playpit_station_access](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/security_group) | resource |
| [aws_spot_instance_request.instance](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/resources/spot_instance_request) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/data-sources/ami) | data source |
| [aws_subnets.public](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/data-sources/subnets) | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/5.31.0/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | n/a | `string` | `""` | no |
| <a name="input_basic_auth_password"></a> [basic\_auth\_password](#input\_basic\_auth\_password) | n/a | `string` | `""` | no |
| <a name="input_create_ec2"></a> [create\_ec2](#input\_create\_ec2) | n/a | `bool` | `true` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | `""` | no |
| <a name="input_ec2_sshkey_name"></a> [ec2\_sshkey\_name](#input\_ec2\_sshkey\_name) | n/a | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 Instance Type | `string` | `"c5d.xlarge"` | no |
| <a name="input_loglevel"></a> [loglevel](#input\_loglevel) | n/a | `string` | `""` | no |
| <a name="input_myip"></a> [myip](#input\_myip) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `""` | no |
| <a name="input_spot_price"></a> [spot\_price](#input\_spot\_price) | Max Price for SPOT offerings | `string` | `""` | no |
| <a name="input_training"></a> [training](#input\_training) | n/a | `string` | `""` | no |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | n/a | `string` | `""` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | vpc name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami_id"></a> [ami\_id](#output\_ami\_id) | n/a |
| <a name="output_ec2_public_ip"></a> [ec2\_public\_ip](#output\_ec2\_public\_ip) | n/a |
| <a name="output_service_endpoint"></a> [service\_endpoint](#output\_service\_endpoint) | n/a |
