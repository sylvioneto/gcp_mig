resource "google_compute_instance_template" "template" {
  count = length(var.subnet_list)

  name_prefix             = "${var.mig_name}-${var.subnet_list[count.index]["name"]}-"
  instance_description    = "Instance created from ${var.mig_name} template"
  machine_type            = var.machine_type
  metadata_startup_script = var.startup_script
  region                  = var.subnet_list[count.index]["region"]
  tags                    = ["allow-iap-ssh", "allow-http"]
  labels                  = var.resource_labels

  scheduling {
    automatic_restart = false
    preemptible       = var.preemptible
  }

  disk {
    source_image = var.image
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = var.vpc
    subnetwork = var.subnet_list[count.index]["name"]
  }

  shielded_instance_config {
    enable_secure_boot = true
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [google_compute_subnetwork.subnets]
}


resource "google_compute_region_instance_group_manager" "instance_group" {
  count              = length(var.subnet_list)
  name               = "${var.mig_name}-${var.subnet_list[count.index]["name"]}-group"
  region             = var.subnet_list[count.index]["region"]
  base_instance_name = var.mig_name
  target_size        = 1

  version {
    instance_template = google_compute_instance_template.template[count.index].id
    name              = var.mig_name
  }

  named_port {
    name = "http"
    port = 80
  }

  named_port {
    name = "https"
    port = 443
  }
}
