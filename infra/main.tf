terraform {
  backend "gcs" {
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.4.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.20.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
