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
variable "template_service_image" {
  default = "gcr.io/cloudrun/hello"
}
variable "template_service_account_name" {}

variable "positions_service_image" {
  default = "gcr.io/cloudrun/hello"
}
variable "positions_service_account_name" {}

variable "curricula_service_image" {
  default = "gcr.io/cloudrun/hello"
}
variable "curricula_service_account_name" {}

# Triggers
variable "template_service_repo_owner" {}
variable "template_service_repo" {}

variable "positions_service_repo_owner" {}
variable "positions_service_repo" {}

variable "curricula_service_repo_owner" {}
variable "curricula_service_repo" {}

# Database
variable "db_root_password" {}