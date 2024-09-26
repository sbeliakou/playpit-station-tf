variable "gcp_project" {
  description = "Google Cloud Platform (GCP) Project name"
  type        = string

  validation {
    condition     = length(var.gcp_project) > 0
    error_message = "The gcp_project variable must not be empty."
  }
}

variable "gcp_region" {
  description = "Google Cloud Platform (GCP) Region"
  type        = string

  validation {
    condition     = length(var.gcp_region) > 0
    error_message = "The gcp_region variable must not be empty."
  }
}

variable "gcp_zone" {
  description = "Google Cloud Platform (GCP) Zone"
  type        = string

  validation {
    condition     = length(var.gcp_zone) > 0 && can(regex(var.gcp_region, var.gcp_zone))
    error_message = "The gcp_zone variable must not be empty and must include the gcp_region value."
  }
}

variable "vpc_name" {
  description = "The Virtual Private Cloud (VPC) name intended for deploying virtual machines (VMs). This VPC is assumed to be created independently of this Terraform stack. Just provide a name of the existing VPC."
  type        = string

  validation {
    condition     = length(var.vpc_name) > 0
    error_message = "The vpc_name variable must not be empty."
  }
}

variable "subnet_name" {
  description = "Subnet name. Provide name of existing subnet"
  type        = string

  validation {
    condition     = length(var.subnet_name) > 0
    error_message = "The subnet_name variable must not be empty."
  }
}

variable "domain_name" {
  description = "Domain name, for example: if FQDN is '57-58-59-60.somwhere.com', then domain_name variable should be 'somewhere.com', and '57-58-59-60' will be picked from VM public IP automatically"
  type        = string
}

variable "instance_type" {
  description = "Instance type for provisioning"
  type        = string
  default     = "c2d-highcpu-4"
}

variable "loglevel" {
  description = "Playpit platform log level setting, magic variable for those in the know"
  default     = ""
}

variable "user_name" {
  description = "Playpit training participant name, approved by training owner"
  type        = string

  validation {
    condition     = can(regex("^[A-Z][a-z]+\\s[A-Z][a-z]+$", var.user_name))
    error_message = "The user_name must be in the format 'Firstname Lastname' with each name starting with an uppercase letter followed by lowercase letters."
  }
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