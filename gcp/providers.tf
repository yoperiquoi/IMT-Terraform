terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.6.0"
    }
  }
}

variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "zone" {
  description = "zone"
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone = var.zone
  credentials = file("tuto-terraform-yperiquoi-d7f404f2b934.json")
}

resource "google_compute_network" "myvpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "mysubnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.myvpc.name
  ip_cidr_range = "10.10.0.0/24"
}