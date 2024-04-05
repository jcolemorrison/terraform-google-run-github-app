run "google_compute_backend_service" {
  assert {
    condition     = google_compute_backend_service.default_service.name == "${var.waypoint_application}"
    error_message = "incorrect name"
  }

  assert {
    condition     = google_compute_backend_service.default_service.protocol == "HTTPS"
    error_message = "incorrect protocol"
  }

  assert {
    condition     = google_compute_backend_service.default_service.enable_cdn == false
    error_message = "incorrect enable_cdn"
  }

  assert {
    condition     = google_compute_backend_service.default_service.load_balancing_scheme == "EXTERNAL_MANAGED"
    error_message = "incorrect load_balancing_scheme"
  }
}