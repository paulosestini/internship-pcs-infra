resource "google_sql_database_instance" "internship_database" {
  name             = "main-instance"
  database_version = "POSTGRES_14"
  region           = "us-central1"
  root_password    = var.db_root_password

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    disk_autoresize   = false
    disk_size         = 10
  }
}
