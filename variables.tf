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
variable "positions_service_account_name" {}

variable "curricula_service_account_name" {}

variable "auth_service_account_name" {}

# Triggers
variable "positions_service_repo_owner" {}
variable "positions_service_repo" {}

variable "curricula_service_repo_owner" {}
variable "curricula_service_repo" {}

variable "auth_service_repo_owner" {}
variable "auth_service_repo" {}

# Database
variable "db_root_password" {}