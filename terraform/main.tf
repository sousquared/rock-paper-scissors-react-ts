variable "project" {
  default = "aitech-good-s15191"
}

variable "region" {
  default = "asia-northeast1"
}

locals {
  bucket_name = "rock-paper-scissors-app"
}

provider "google" {
  project = "${var.project}"
}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}


resource "tls_private_key" "acme_account_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = "${tls_private_key.acme_account_key.private_key_pem}"
  email_address   = "sousquared@gmail.com"
}

module "storage" {
  source   = "./modules/storage"
  name     = "${local.bucket_name}"
  location = "${var.region}"
}

module "cdn" {
  source                = "./modules/cdn"
  name                  = "${local.bucket_name}-cdn"
  bucket_name           = "${module.storage.name}"
  acme_account_key_pem  = "${acme_registration.reg.account_key_pem}"
  dns_name              = "s15191.dev"
  certificate_name_base = "cert"
  project               = "${var.project}"
}

module "cdn_dns" {
  source            = "./modules/dns"
  managed_zone_name = "s15191-dev"
  record_dns_name   = "${module.cdn.domain}."
  rrdatas           = "${module.cdn.address}"
}
