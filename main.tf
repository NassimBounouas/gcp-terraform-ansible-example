terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  
  credentials = file(var.credentials_file)

  project = var.project 
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

data "http" "icanhazip" {
  url = "http://icanhazip.com"
}

resource "google_compute_firewall" "allow_ssh" {
  name = "firewall-rule-allow-ssh"
  network = google_compute_network.vpc_network.name

  source_ranges = ["${chomp(data.http.icanhazip.body)}"]

  allow {
    protocol = "tcp"
    ports = ["22"]
  }
}

resource "google_compute_instance" "vm_instance_1" {
  name         = "terraform-instance-1"
  machine_type = "f1-micro"
  tags	       = ["web", "dev"]

  zone    = var.zone_1_region_1

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_instance" "vm_instance_2" {
  name         = "terraform-instance-2"
  machine_type = "f1-micro"
  tags	       = ["web", "dev"]

  zone    = var.zone_1_region_2

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}