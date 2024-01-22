variable "myip" {
  description = "Home public IP"
  default     = "127.0.0.1/32"
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "availability_zone" {
  description = "AWS Availability Zone"
  type        = string
}

variable "ec2_sshkey_name" {
  description = "EC2 ssh key name"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "c5d.xlarge"
}

variable "spot_price" {
  description = "Max Price for SPOT offerings"
  type        = string
  default     = "0.16"
}

variable "loglevel" {
  description = "Playpit platform log level configuration"
  default     = ""
}

variable "user_name" {
  description = "Playpit platform student name"
  type        = string
}

variable "basic_auth_password" {
  description = "Password for basic authentication"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "training" {
  description = "Playpit platform training configuration"
  type        = string
}