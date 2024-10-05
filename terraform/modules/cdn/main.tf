resource "google_compute_backend_bucket" "cdn" {
  name        = "${var.name}-backet"
  bucket_name = "${var.bucket_name}"
  enable_cdn  = true
}

resource "google_compute_url_map" "cdn" {
  name            = "${var.name}"
  default_service = "${google_compute_backend_bucket.cdn.self_link}"
}

resource "acme_certificate" "cdn" {
  account_key_pem    = "${var.acme_account_key_pem}"
  common_name        = "${var.dns_name}"
  min_days_remaining = 30

  dns_challenge {
    provider = "gcloud"

    config = {
      GCE_PROJECT = "${var.project}"
    }
  }
}

resource "google_compute_ssl_certificate" "cdn" {
  name_prefix = "${var.certificate_name_base}--"
  private_key = "${acme_certificate.cdn.private_key_pem}"
  certificate = "${acme_certificate.cdn.certificate_pem}"
}

resource "google_compute_target_https_proxy" "cdn" {
  name             = "${var.name}-target-proxy"
  url_map          = "${google_compute_url_map.cdn.self_link}"
  ssl_certificates = ["${google_compute_ssl_certificate.cdn.self_link}"]
}

resource "google_compute_global_address" "cdn" {
  name = "${var.name}-ip"
}

resource "google_compute_global_forwarding_rule" "cdn" {
  name       = "${var.name}-https"
  target     = "${google_compute_target_https_proxy.cdn.self_link}"
  port_range = "443-443"
  ip_address = "${google_compute_global_address.cdn.address}"
}
