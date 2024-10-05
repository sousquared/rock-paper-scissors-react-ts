# Cloud DNS のゾーンは作成済みとする。

resource "google_dns_record_set" "dns" {
  name         = "${var.record_dns_name}"
  managed_zone = "${var.managed_zone_name}"
  type         = "A"
  ttl          = 300

  rrdatas = ["${var.rrdatas}"]
}
