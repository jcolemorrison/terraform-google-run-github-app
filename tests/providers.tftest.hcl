run "google_provider" {
  assert {
    condition     = google.project == var.gcp_project_id
    error_message = "incorrect project"
  }

  assert {
    condition     = google.region == var.default_region
    error_message = "incorrect region"
  }
}

run "github_provider" {
  assert {
    condition     = github.token == var.github_token
    error_message = "incorrect token"
  }
}