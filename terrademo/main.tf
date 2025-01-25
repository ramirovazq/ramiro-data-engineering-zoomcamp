terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.17.0"
    }
  }
}

provider "google" {
  project = "utility-cathode-448702-g7"
  region  = "us-central1"
}


resource "google_storage_bucket" "demo-bucket" {
  name          = "utility-cathode-448702-g7-terra-bucket"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "Delete"
    }
  }
}