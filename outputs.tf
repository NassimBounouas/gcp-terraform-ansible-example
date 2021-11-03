output "private_ip_vm_1" {
  value = google_compute_instance.vm_instance_1.network_interface.0.network_ip
}

output "private_ip_vm_2" {
  value = google_compute_instance.vm_instance_2.network_interface.0.network_ip
}

output "public_ip_vm_1" {
  value = google_compute_instance.vm_instance_1.network_interface.0.access_config[0].nat_ip
}

output "public_ip_vm_2" {
  value = google_compute_instance.vm_instance_2.network_interface.0.access_config[0].nat_ip
}
