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
    
    database_flags {
      name  = "max_connections"
      value = 100
    }
  }
}

resource "google_sql_database" "positions_db" {
  name     = "positions"
  instance = google_sql_database_instance.internship_database.name
}

resource "google_sql_database" "curricula_db" {
  name     = "curricula"
  instance = google_sql_database_instance.internship_database.name
}

resource "google_sql_database" "auth_db" {
  name     = "auth"
  instance = google_sql_database_instance.internship_database.name
}
