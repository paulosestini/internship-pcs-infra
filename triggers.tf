resource "google_cloudbuild_trigger" "template-service-trigger" {
  name     = "template-service-trigger"
  location = "global"

  github {
    owner = var.repo_owner
    name  = var.template_service_repo
    push {
      branch = "^master$"
    }
  }

  filename = "cloudbuild.yaml"
}
