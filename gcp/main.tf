/**
 * # Playpit Compute Instance on GCP
 *
 * ## Description
 * This Terraform code provisions an Playpit environment on a Google Cloud Platform (GCP) Compute Engine instance. 
 * 
 * ### Provision details:
 * 
 * - Creates a GCP Compute Engine instance with the specified configuration.
 * - Sets instance name, hostname, and other attributes.
 * - Configures metadata, including labels, machine type, access rules, and tags.
 * - Defines instance-specific metadata, such as login credentials, startup script, etc.
 * - Configures scheduling options for preemptible instances.
 * - Defines boot disk details, including auto-delete, image, size, and mode.
 * - Configures network interface details, such as network, subnetwork, and access configuration.
 * - The startup script installs the Playpit stack, configures SSL with Let's Encrypt and sets Basic AUTH by the provided settings (username/password)
 * 
 * The code incorporates dynamic values through Terraform variables (`variables.tf` and `override.tf`).
 * 
 * To define your stack configuration, the following steps should be done:
 * 
 * 1. Create a new file `override.tf` from current `variables.tf`, or update `terraform.tfvars` file
 * 2. Define your settings corresponding to your GCP project, training specification and set up the proper Student's name, define a password for Basic AUTH
 * 3. Create GCP compute instance with `make up` command
 * 4. Destroy compute instance with `make down` command
 * 
 * The current configuration doesn't cover:
 *
 * - Network and subnet creation - the existing names should be provided in `override.tf` or `terraform.tfvars` file
 */

resource "random_id" "instance_id" {
  byte_length = 4
}

resource "random_string" "password" {
  length           = 16
  special          = true
  lower            = true
  upper            = true
  override_special = "*-_=+"
}

locals {
  instance_name = "playpit-vm${random_id.instance_id.hex}"
  public_fqdn   = format("%s.%s", replace(google_compute_instance.vm_instance_public.network_interface.0.access_config.0.nat_ip, ".", "-"), var.domain_name)

  basic_auth_password = var.basic_auth_password != "" ? var.basic_auth_password : random_string.password.result
  basic_auth_login    = lower(join("", regex("^(.).* (.*)$", var.user_name)))
}

data "google_compute_subnetwork" "this" {
  name = basename(var.gcp_subnet_name)
}

resource "google_compute_firewall" "playpit_ingress" {
  name    = format("%s-playpit-https", basename(data.google_compute_subnetwork.this.network))
  network = data.google_compute_subnetwork.this.network

  allow {
    protocol = "tcp"
    ports = [
      "80",
      "443"
    ]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "vm_instance_public" {
  name     = local.instance_name
  hostname = "${local.instance_name}.gcp.playpit.net"

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  machine_type = var.gcp_instance_type
  zone         = var.gcp_zone

  tags = [
    format("%s-playpit-https", basename(data.google_compute_subnetwork.this.network))
  ]

  metadata = {
    BASICAUTH_LOGIN    = local.basic_auth_login
    BASICAUTH_PASSWORD = local.basic_auth_password
    startup-script = templatefile("user-data.sh.tpl", {
      BASICAUTH   = "${local.basic_auth_login}:${local.basic_auth_password}"
      DOMAIN_NAME = var.domain_name
      USER_NAME   = var.user_name
      LOGLEVEL    = var.loglevel
      TRAINING    = var.training
      SSL         = var.domain_name == "" ? "no" : "yes"
    })
  }

  resource_policies = []

  scheduling {
    provisioning_model = "SPOT"
    preemptible        = true
    automatic_restart  = false

    instance_termination_action = "STOP"
    min_node_cpus               = 0
    on_host_maintenance         = "TERMINATE"
  }

  boot_disk {
    auto_delete = true
    device_name = local.instance_name

    initialize_params {
      image = "https://www.googleapis.com/compute/v1/projects/ubuntu-os-pro-cloud/global/images/ubuntu-pro-2204-jammy-v20240110"
      size  = 20
    }

    mode = "READ_WRITE"
  }

  network_interface {
    network     = data.google_compute_subnetwork.this.network
    subnetwork  = var.gcp_subnet_name
    stack_type  = "IPV4_ONLY"
    queue_count = 0
    access_config {}
  }
} 