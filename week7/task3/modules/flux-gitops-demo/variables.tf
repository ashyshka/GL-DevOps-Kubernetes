variable "github_owner" {
  type        = string
  description = "The GitHub owner"
}

variable "github_token" {
  type        = string
  description = "GitHub personal access token"
}

variable "repository_name" {
  type        = string
  description = "GitHub repository name to store Flux manifests"
}

variable "target_path" {
  type        = string
  description = "Flux manifests subdirectory"
}
