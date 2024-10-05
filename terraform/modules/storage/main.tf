resource "google_storage_bucket" "storage" {
  name          = "${var.name}"
  storage_class = "REGIONAL"
  location      = "${var.location}"
}

# resource "google_storage_bucket_iam_member" "bucket" {
#   bucket = google_storage_bucket.storage.name
#   role   = "roles/storage.objectViewer"
#   member = "allUsers"
# }
