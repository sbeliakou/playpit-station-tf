variable "gcp_credentials_file" {
  description = "Path to the Google Cloud Platform (GCP) Credentials file"
  type        = string
  default     = "~/.config/gcloud/application_default_credentials.json"
}

variable "gcp_project" {
  description = "Google Cloud Platform (GCP) Project name"
  type        = string
}

variable "gcp_region" {
  description = "Google Cloud Platform (GCP) Region"
  type        = string
}

variable "gcp_zone" {
  description = "Google Cloud Platform (GCP) Zone"
  type        = string
}

variable "vpc_name" {
  description = "Virtual Private Cloud (VPC) name for deploying VM"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "instance_type" {
  description = "Instance type for provisioning"
  type        = string
  default     = "e2-medium"
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

variable "training" {
  description = "Playpit platform training configuration"
  type        = string
}