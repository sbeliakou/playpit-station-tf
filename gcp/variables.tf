variable "gcp_credentials_file" {
  type    = string
  default = "~/.config/gcloud/application_default_credentials.json"
}

variable "gcp_project" {
  type = string
}

variable "gcp_region" {
  type = string
}

variable "gcp_zone" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "e2-medium"
}

variable "loglevel" {
  default = ""
}

variable "vpc_name" {
  description = "default vpc name"
  type        = string
}

variable "subnet_name" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "user_name" {
  type = string
}

variable "basic_auth_password" {
  type = string
}

variable "training" {
  type = string
}