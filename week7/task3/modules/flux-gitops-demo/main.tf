provider "github" {
  owner = var.github_owner
  token = var.github_token
}

resource "github_repository_file" "ns" {
  repository          = var.repository_name
  branch              = "main"
  file                = "${var.target_path}/demo/ns.yaml"
  content             = file("${path.module}/manifests/ns.yaml")
  overwrite_on_create = true
}

resource "github_repository_file" "kbot_gr" {
  repository          = var.repository_name
  branch              = "main"
  file                = "${var.target_path}/demo/kbot-gr.yaml"
  content             = file("${path.module}/manifests/kbot-gr.yaml")
  overwrite_on_create = true
}

resource "github_repository_file" "kbot_hr" {
  repository          = var.repository_name
  branch              = "main"
  file                = "${var.target_path}/demo/kbot-hr.yaml"
  content             = file("${path.module}/manifests/kbot-hr.yaml")
  overwrite_on_create = true
}
