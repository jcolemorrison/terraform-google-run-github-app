locals {
  run_env_vars = {
    for region in var.deployment_regions : region => var.application_image_uri == "nicholasjackson/fake-service" ? [
      {
        name  = "MESSAGE"
        value = "Hello from the ${var.waypoint_application} app in the ${region} region"
      },
      {
        name  = "NAME"
        value = "${var.waypoint_application}"
      },
      {
        name  = "LISTEN_ADDR"
        value = "0.0.0.0:8080"
      }
      ] : concat(var.application_image_env_variables, [{
        name  = "REDIS_HOST"
        value = "${var.redis_read_endpoints[region]}:6379"
    }])
  }
}

# Create Default Cloud Run service
resource "google_cloud_run_v2_service" "default" {
  count    = length(var.deployment_regions)
  name     = format("${var.waypoint_application}-%s", var.deployment_regions[count.index])
  location = var.deployment_regions[count.index]

  template {
    containers {
      image = "${var.application_image_uri}:${var.application_image_tag}"

      dynamic "env" {
        for_each = local.run_env_vars[var.deployment_regions[count.index]]
        content {
          name  = env.value.name
          value = env.value.value
        }
      }
    }

    vpc_access {
      connector = var.regional_vpc_connector_ids[var.deployment_regions[count.index]]
      egress    = "ALL_TRAFFIC"
    }

    service_account = var.service_account_email
  }
}

# Create a Network Endpoint Group for each Cloud Run service
resource "google_compute_region_network_endpoint_group" "default_serverless_endpoints" {
  count  = length(var.deployment_regions)
  name   = format("send-%s-%d", var.deployment_regions[count.index], count.index + 1)
  region = var.deployment_regions[count.index]

  cloud_run {
    service = google_cloud_run_v2_service.default[count.index].name
  }
}

# Create a backend service
resource "google_compute_backend_service" "default_service" {
  name                  = "default-service"
  protocol              = "HTTPS"
  enable_cdn            = false
  load_balancing_scheme = "EXTERNAL_MANAGED"

  dynamic "backend" {
    for_each = google_compute_region_network_endpoint_group.default_serverless_endpoints
    content {
      group = backend.value.id
    }
  }
}

# Grant public access to each Cloud Run service
resource "google_cloud_run_v2_service_iam_member" "public_access" {
  count    = length(var.deployment_regions)
  project  = var.gcp_project_id
  location = var.deployment_regions[count.index]
  name     = google_cloud_run_v2_service.default[count.index].name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
