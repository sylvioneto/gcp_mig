resource "google_compute_global_forwarding_rule" "http_lb" {
  provider    = google-beta
  name        = "${var.mig_name}-fwd-rule"
  port_range  = "80"
  target      = google_compute_target_http_proxy.http_proxy.id
}

resource "google_compute_target_http_proxy" "http_proxy" {
  provider = google-beta
  name     = "${var.mig_name}-forwarding-rule-proxy"
  url_map  = google_compute_url_map.http_map.id
}

resource "google_compute_url_map" "http_map" {
  provider        = google-beta
  name            = "${var.mig_name}-map"
  default_service = google_compute_backend_service.http_backend.id
}

resource "google_compute_backend_service" "http_backend" {
  name          = "${var.mig_name}-backend-service"
  health_checks = [google_compute_http_health_check.http_hc.id]
  backend {
    group = google_compute_region_instance_group_manager.instance_group[0].instance_group
  }
  backend {
    group = google_compute_region_instance_group_manager.instance_group[1].instance_group
  }
}

resource "google_compute_http_health_check" "http_hc" {
  name               = "${var.mig_name}-health-check"
  request_path       = "/"
  check_interval_sec = 30
  timeout_sec        = 5
}
