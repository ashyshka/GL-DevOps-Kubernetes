/*
resource "google_storage_bucket" "ashyshka-secrets" {
  name          = "ashyshka-secrets"
  location      = var.GOOGLE_REGION
  project       = var.GOOGLE_PROJECT
  force_destroy = true
  storage_class = "STANDARD"
  versioning {
    enabled = false
  }
  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30
    }
  }
}
*/
