resource "google_cloud_run_service" "auth_internship_service" {
  name     = "auth-internship-service"
  location = var.region

  template {
    spec {
      service_account_name = var.auth_service_account_name
      containers {
        image = "gcr.io/${var.project}/${var.auth_service_repo}:master"
        env {
          name  = "ENABLE_GRAPHIQL"
          value = true
        }
        env {
          name = "DB_PASSWORD"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "AUTH_DB_PASSWORD"
            }
          }
        }
        env {
          name = "DB_USERNAME"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "AUTH_DB_USER"
            }
          }
        }
        env {
          name = "DB_URL"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "AUTH_DB_URL"
            }
          }
        }
        env {
          name = "OAUTH_CLIENT_ID"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "OAUTH_CLIENT_ID"
            }
          }
        }
        env {
          name = "OAUTH_CLIENT_SECRET"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "OAUTH_CLIENT_SECRET"
            }
          }
        }
        env {
          name = "OAUTH_URL"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "OAUTH_URL"
            }
          }
        }        
        env {
          name = "OAUTH_REDIRECT_URI"
          value_from {
            secret_key_ref {
              key  = "latest"
              name = "OAUTH_REDIRECT_URI"
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
}

resource "google_cloud_run_service_iam_policy" "auth_noauth" {
  location = google_cloud_run_service.auth_internship_service.location
  project  = google_cloud_run_service.auth_internship_service.project
  service  = google_cloud_run_service.auth_internship_service.name

  policy_data = data.google_iam_policy.noauth.policy_data

  depends_on = [
    google_cloud_run_service.auth_internship_service
  ]
}