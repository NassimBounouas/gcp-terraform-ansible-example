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
  url = "https://ipv4.icanhazip.com"
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

resource "google_compute_firewall" "allow_http" {
  name = "firewall-rule-allow-http"
  network = google_compute_network.vpc_network.name

  target_tags = ["allow-http"]

  allow {
    protocol = "tcp"
    ports = ["80"]
  }
}

resource "google_compute_instance" "vm_instance_1" {
  name         = "terraform-instance-1"
  machine_type = "f1-micro"
  tags	       = ["allow-http", "dev"]

  zone    = var.zone_1_region_1

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
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
  tags	       = ["allow-http", "dev"]

  zone    = var.zone_1_region_2

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }

}

resource "google_compute_project_metadata_item" "ssh-keys" {
  key   = "ssh-keys"
  value = "${var.user}:${file(var.public_key_file)}"
}
