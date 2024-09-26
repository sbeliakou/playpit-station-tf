output "vm_public_ip" {
  value = google_compute_instance.vm_instance_public.network_interface.0.access_config.0.nat_ip
}

output "playpit_instance" {
  value = {
    url = format("https://%s", local.public_fqdn)
    login = local.basic_auth_login
    password = local.basic_auth_password
  }
}