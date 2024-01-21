variable "GOOGLE_PROJECT" {
  type        = string
  description = "GCP project name"
}

variable "GOOGLE_REGION" {
  type        = string
  description = "GCP region to use"
}

variable "GOOGLE_ZONE" {
  type        = string
  description = "GCP zone to use"
}

variable "GKE_MACHINE_TYPE" {
  type        = string
  description = "Machine type"
}

variable "GKE_NUM_NODES" {
  type        = number
  description = "GKE nodes number"
}

variable "GKE_CLUSTER_NAME" {
  type        = string
  description = "GKE cluster name"
}

variable "GKE_POOL_NAME" {
  type        = string
  description = "GKE pool name"
}

variable "GITHUB_OWNER" {
  type        = string
  description = "GitHub owner repository to use"
}

variable "GITHUB_TOKEN" {
  type        = string
  description = "GitHub personal access token"
}

variable "FLUX_GITHUB_REPO" {
  type        = string
  default     = "flux-gitops"
  description = "Flux GitOps repository"
}

variable "FLUX_GITHUB_TARGET_PATH" {
  type        = string
  default     = "clusters"
  description = "Flux manifests subdirectory"
}
