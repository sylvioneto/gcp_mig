# Create VPC
resource "google_compute_network" "vpc" {
  name                    = var.vpc
  description             = "VPC managed by terraform"
  auto_create_subnetworks = false
}

# Create NAT and Routers
resource "google_compute_router" "nat_router" {
  count   = length(var.subnet_list)
  name    = "${var.subnet_list[count.index]["name"]}-nat-gw"
  region  = var.subnet_list[count.index]["region"]
  network = google_compute_network.vpc.id

  bgp {
    asn = 64514
  }
}


resource "google_compute_router_nat" "nat_gateway" {
  count                              = length(var.subnet_list)
  name                               = "${var.subnet_list[count.index]["name"]}-nat-gw"
  router                             = google_compute_router.nat_router[count.index].name
  region                             = var.subnet_list[count.index]["region"]
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

# subnets configuration
resource "google_compute_subnetwork" "subnets" {
  count                    = length(var.subnet_list)
  name                     = var.subnet_list[count.index]["name"]
  ip_cidr_range            = var.subnet_list[count.index]["cidr"]
  region                   = var.subnet_list[count.index]["region"]
  network                  = google_compute_network.vpc.name
  private_ip_google_access = true
}
