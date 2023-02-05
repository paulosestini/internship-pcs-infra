# Google Cloud
variable "project" {}
variable "credentials_file" {}
variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "us-central1-c"
}

# Services
variable "template_service_image" {}
variable "template_service_account_name" {}

# Triggers
variable "repo_owner" {}
variable "template_service_repo" {}

# Database
variable "db_root_password" {}