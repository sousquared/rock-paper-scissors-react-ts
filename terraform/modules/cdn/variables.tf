# このファイルはCDNモジュールの変数を定義します。
# CDNの設定に必要な各種パラメータを外部から受け取るために使用されます。

# 以下の変数は、CDNの構成、SSL証明書の生成、DNSの設定などに使用されます。
# これにより、モジュールの再利用性と柔軟性が向上します。

variable "name" {}

variable "bucket_name" {}

variable "acme_account_key_pem" {}

variable "dns_name" {}

variable "certificate_name_base" {}

variable "project" {}
