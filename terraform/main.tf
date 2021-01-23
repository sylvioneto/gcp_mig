data "google_project" "project" {}

provider "google" {
  project = var.project_id
  region  = var.region
}
