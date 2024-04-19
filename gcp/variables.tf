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
  description = "The Virtual Private Cloud (VPC) name intended for deploying virtual machines (VMs). This VPC is assumed to be created independently of this Terraform stack. Just provide a name of the existing VPC."
  type        = string
}

variable "subnet_name" {
  description = "Subnet name. Provide name of existing subnet"
  type        = string
}

variable "domain_name" {
  description = "Domain name, for example: if FQDN is '57-58-59-60.somwhere.com', then domain_name variable should be 'somewhere.com', and '57-58-59-60' will be picked from VM public IP automatically"
  type        = string
}

variable "instance_type" {
  description = "Instance type for provisioning"
  type        = string
  default     = "e2-medium"
}

variable "loglevel" {
  description = "Playpit platform log level setting, magic variable for those in the know"
  default     = ""
}

variable "user_name" {
  description = "Playpit training participant name, approved by training owner"
  type        = string
}

variable "basic_auth_password" {
  description = "Password for basic authentication. Must be minimum 8 characters, at least one uppercase letter, one lowercase letter, one number and one special character"
  type        = string
}

variable "training" {
  description = "Playpit platform training configuration"
  type        = string

  validation {
    condition     = can(regex("^(docker|k8s)$", var.training))
    error_message = "Must be 'docker' or 'k8s'."
  }
}