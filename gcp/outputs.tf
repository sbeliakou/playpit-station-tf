output "vm_public_ip" {
  value = google_compute_instance.vm_instance_public.network_interface.0.access_config.0.nat_ip
}

output "service_endpoint" {
  value = format("https://%s", local.public_fqdn)
}