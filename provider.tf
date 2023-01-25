terraform {
  required_providers {
    scaleway = {
      source = "scaleway/scaleway"
    }

    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
  }
  required_version = ">= 0.13"
}


provider "scaleway" {
  access_key = var.access_key
  secret_key = var.secret_key

  zone   = var.zone
  region = var.region

  project_id = var.project_id
}