run "region_to_service_endpoints" {
  assert {
    condition     = length(output.region_to_service_endpoints) == 2
    error_message = "expected 2 region to service endpoints"
  }
}

run "github_repository_url" {
  assert {
    condition     = output.github_repository_url == github_repository.application.html_url
    error_message = "incorrect value"
  }
}