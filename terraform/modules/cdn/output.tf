output "address" {
  value = "${google_compute_global_address.cdn.address}"
}

output "domain" {
  value = "${var.dns_name}"
}
