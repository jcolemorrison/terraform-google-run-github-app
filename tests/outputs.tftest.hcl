run "region_to_service_endpoints" {
  assert {
    condition     = output.region_to_service_endpoints.value == zipmap(var.deployment_regions, [for service in google_cloud_run_v2_service.default : service.uri])
    error_message = "incorrect value"
  }

  assert {
    condition     = output.region_to_service_endpoints.description == "Map of deployment regions to the public URI of the Cloud Run service in that region"
    error_message = "incorrect description"
  }
}

run "github_repository_url" {
  assert {
    condition     = output.github_repository_url.value == github_repository.application.html_url
    error_message = "incorrect value"
  }

  assert {
    condition     = output.github_repository_url.description == "The URL of the GitHub repository"
    error_message = "incorrect description"
  }
}