provider "google" {
  project = var.project
  region  = var.region
}

# Compute.
module "compute_servers" {
  source = "github.com/lgfa29/iac-modulo-compute-gcp?ref=nomad-gcp"
  count  = var.server_count

  project        = var.project
  instance_name  = "nomad-server-${count.index + 1}"
  instance_image = "ubuntu-2004-lts"
  machine_type   = var.server_instance_type
  network        = module.network.vpc_id
  subnetwork     = module.network.subnets_id[0].id
  zone           = var.zone
  labels         = {}
  tags           = ["server"]
}

module "compute_clients" {
  source = "github.com/lgfa29/iac-modulo-compute-gcp?ref=nomad-gcp"
  count  = var.client_count

  project        = var.project
  instance_name  = "nomad-client-${count.index + 1}"
  instance_image = "ubuntu-2004-lts"
  machine_type   = var.client_instance_type
  network        = module.network.vpc_id
  subnetwork     = module.network.subnets_id[0].id
  zone           = var.zone
  labels         = {}
  tags           = ["client"]
}

# Network.
module "network" {
  source = "github.com/lgfa29/iac-modulo-rede-gcp?ref=nomad-gcp"

  vpc_name = "nomad"
  project  = var.project

  subnetworks = [{
    name          = "private"
    ip_cidr_range = "192.168.10.0/24"
    region        = var.region
  }]

  firewall_allow = [{
    protocol = "tcp"
    port     = [22, 8080, 4646, 4647, 4648, 8500, 8600, 8301, 8302, 8300]
  }]
}

resource "google_compute_router" "default" {
  name    = "nomad-router"
  region  = var.region
  network = module.network.vpc_id
}

resource "google_compute_router_nat" "default" {
  name                               = "nomad-nat-router"
  region                             = google_compute_router.default.region
  router                             = google_compute_router.default.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
