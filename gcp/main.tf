provider "google" {
  credentials = file(var.gcp_credentials_file)
  project     = var.gcp_project
  region      = var.gcp_region
}

resource "random_id" "instance_id" {
  byte_length = 4
}

resource "google_compute_instance" "vm_instance_public" {
  name     = "playpit-vm${random_id.instance_id.hex}"
  hostname = "playpit-vm${random_id.instance_id.hex}.gcp.playpit.net"

  machine_type = var.instance_type
  zone         = var.gcp_zone
  tags         = ["ssh", "http-server", "https-server"]

  enable_display = false
  labels         = {}

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
    initialize_params {
      # image = "ubuntu-os-pro-cloud/ubuntu-pro-2204-lts"
      image                 = "https://www.googleapis.com/compute/v1/projects/ubuntu-os-pro-cloud/global/images/ubuntu-pro-2204-jammy-v20240110"
      size                  = 20
      resource_manager_tags = {}
    }
  }

  metadata = {
    BASICAUTH_LOGIN    = "${lower(join("", regex("^(.).* (.*)$", var.user_name)))}"
    BASICAUTH_PASSWORD = var.basic_auth_password
  }

  metadata_startup_script = templatefile("user-data.sh.tpl", {
    BASICAUTH = "${lower(join("", regex("^(.).* (.*)$", var.user_name)))}:${var.basic_auth_password}"
    DOMAIN_NAME= var.domain_name
    USER_NAME = var.user_name
    LOGLEVEL  = var.loglevel
    TRAINING  = var.training
    USESSL    = "yes"
  })

  network_interface {
    network     = var.vpc_name
    subnetwork  = var.subnet_name
    queue_count = 0
    access_config {}
  }
} 