# Checks for Service status in initial deployment regions

check "check_cr_state_west" {
  data "http" "live_service_west" {
    url = google_cloud_run_v2_service.default[0].uri
  }

  assert {
    condition = data.http.live_service_west.status_code == 200
    error_message = format("Provisioned Cloud Run should return a 200 status code, instead of `%s`",
      data.http.live_service_west.status_code
    )
  }
}

check "check_cr_state_east" {
  data "http" "live_service_east" {
    url = google_cloud_run_v2_service.default[1].uri
  }

  assert {
    condition = data.http.live_service_east.status_code == 200
    error_message = format("Provisioned Cloud Run should return a 200 status code, instead of `%s`",
      data.http.live_service_east.status_code
    )
  }
}