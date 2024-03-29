resource "google_cloudbuild_trigger" "positions-service-trigger" {
  name     = "positions-service-trigger"
  location = "global"

  github {
    owner = var.positions_service_repo_owner
    name  = var.positions_service_repo
    push {
      branch = "^master$"
    }
  }

  filename = "cloudbuild.yaml"
}

resource "google_cloudbuild_trigger" "curricula-service-trigger" {
  name     = "curricula-service-trigger"
  location = "global"

  github {
    owner = var.curricula_service_repo_owner
    name  = var.curricula_service_repo
    push {
      branch = "^master$"
    }
  }

  filename = "cloudbuild.yaml"
}


resource "google_cloudbuild_trigger" "auth-service-trigger" {
  name     = "auth-service-trigger"
  location = "global"

  github {
    owner = var.auth_service_repo_owner
    name  = var.auth_service_repo
    push {
      branch = "^master$"
    }
  }

  filename = "cloudbuild.yaml"
}
