resource "google_cloud_run_service" "curricula_internship_service" {
  name     = "curricula-internship-service"
  location = var.region

  template {
    spec {
      service_account_name = var.curricula_service_account_name
      containers {
        image = var.curricula_service_image
        env {
          name  = "ENABLE_GRAPHIQL"
          value = true
        }
        env {
          name = "DB_PASSWORD"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "CURRICULA_DB_PASSWORD"
            }
          }
        }
        env {
          name = "DB_USERNAME"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "CURRICULA_DB_USER"
            }
          }
        }
        env {
          name = "DB_URL"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "CURRICULA_DB_URL"
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
}

resource "google_cloud_run_service_iam_policy" "curricula_noauth" {
  location = google_cloud_run_service.curricula_internship_service.location
  project  = google_cloud_run_service.curricula_internship_service.project
  service  = google_cloud_run_service.curricula_internship_service.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
