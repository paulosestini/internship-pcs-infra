resource "google_sql_database_instance" "internship_database" {
  name             = "main-instance"
  database_version = "POSTGRES_14"
  region           = "us-central1"
  root_password    = var.db_root_password

  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    disk_autoresize   = false
    disk_size         = 10
  }
}
