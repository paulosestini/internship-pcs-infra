resource "google_cloud_run_service" "positions_internship_service" {
  name     = "positions-internship-service"
  location = var.region

  template {
    spec {
      service_account_name = var.positions_service_account_name
      containers {
        image = "gcr.io/${var.project}/${var.positions_service_repo}:master"
        env {
          name  = "ENABLE_GRAPHIQL"
          value = true
        }
        env {
          name = "DB_PASSWORD"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "POSITIONS_DB_PASSWORD"
            }
          }
        }
        env {
          name = "DB_USERNAME"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "POSITIONS_DB_USER"
            }
          }
        }
        env {
          name = "DB_URL"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "POSITIONS_DB_URL"
            }
          }
        }
        env {
          name = "AUTH_CRYPTO_SECRET"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "AUTH_CRYPTO_SECRET"
            }
          }
        }
      }
    }
    metadata {
      annotations = {
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.internship_database.connection_name
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  timeouts {
    update = "5m"
    delete = "5m"
  }

  lifecycle {
    ignore_changes = [
      template.0.metadata.0.annotations["client.knative.dev/user-image"],
      template.0.metadata.0.annotations["run.googleapis.com/client-name"],
      template.0.metadata.0.annotations["run.googleapis.com/client-version"],
      traffic["latest_revision"],
      traffic["revision_name"]
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "positions_noauth" {
  location = google_cloud_run_service.positions_internship_service.location
  project  = google_cloud_run_service.positions_internship_service.project
  service  = google_cloud_run_service.positions_internship_service.name

  policy_data = data.google_iam_policy.noauth.policy_data

  depends_on = [
    google_cloud_run_service.positions_internship_service
  ]
}
