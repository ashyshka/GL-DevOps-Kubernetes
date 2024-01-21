# used in tasks
# week 7/task 2
/*
module "gke_cluster" {
  source         = "github.com/ashyshka/tf-google-gke-cluster"
  GOOGLE_PROJECT = var.GOOGLE_PROJECT
  GOOGLE_REGION  = var.GOOGLE_REGION
  //  GOOGLE_ZONE    = var.GOOGLE_ZONE
  GKE_NUM_NODES = 1
}
*/

#used in tasks
# week 7/task3
module "kind_cluster" {
  source = "github.com/ashyshka/tf-kind-cluster?ref=cert_auth"
}

module "tls_private_key" {
  source    = "github.com/ashyshka/tf-hashicorp-tls-keys"
  algorithm = "RSA"
}

module "github_repository" {
  source                   = "github.com/ashyshka/tf-github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux"
}

module "flux_bootstrap" {
  source            = "github.com/ashyshka/tf-fluxcd-flux-bootstrap?ref=kind_auth"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key       = module.tls_private_key.private_key_pem
  config_host       = module.kind_cluster.endpoint
  config_client_key = module.kind_cluster.client_key
  config_ca         = module.kind_cluster.ca
  config_crt        = module.kind_cluster.crt
#  config_path       = module.kind_cluster.kubeconfig
  github_token      = var.GITHUB_TOKEN
}
