output "region_to_service_endpoints" {
  value = zipmap(var.deployment_regions, [for service in google_cloud_run_v2_service.default : service.uri])
  description = "Map of deployment regions to the public URI of the Cloud Run service in that region"
}