variable "myip" {
  default = "127.0.0.1/32"
}

variable "region" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "ec2_sshkey_name" {
  type = string
}

variable "instance_type" {
  type = string
  default = "c5d.xlarge"
}

variable "spot_price" {
  type = string
  default = "0.16"
}

variable "loglevel" {
  default = ""
}

variable "user_name" {
  type = string
}

variable "basic_auth_password" {
  type = string
}

variable "vpc_name" {
  description = "vpc name"
  type = string
}

variable "domain_name" {
  type = string
}

variable "create_ec2" {
  default = true
}

variable "training" {
  type = string
}