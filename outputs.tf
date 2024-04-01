output "region_to_service_endpoints" {
  value       = zipmap(var.deployment_regions, [for service in google_cloud_run_v2_service.default : service.uri])
  description = "Map of deployment regions to the public URI of the Cloud Run service in that region"
}

output "github_repository_url" {
  value       = github_repository.application.html_url
  description = "The URL of the GitHub repository"
}