# storages for terraform tfstate file
terraform {
# state for GKE
/*
  backend "gcs" {
    bucket = "ashyshka-storage"
    prefix = "terraform/gke-state"
  }
*/

# state for local kind
  backend "gcs" {
    bucket = "ashyshka-storage"
    prefix = "terraform/kind-state"
  }
}
