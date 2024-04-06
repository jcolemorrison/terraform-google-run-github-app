run "tfc_organization" {
  assert {
    condition     = var.tfc_organization != ""
    error_message = "incorrect default value"
  }
}

run "tfc_api_token" {
  assert {
    condition     = var.tfc_api_token != ""
    error_message = "incorrect default value"
  }
}

run "gcp_project_id" {
  assert {
    condition     = var.gcp_project_id != ""
    error_message = "incorrect default value"
  }
}

run "default_region" {
  assert {
    condition     = var.default_region == "us-west1"
    error_message = "incorrect default value"
  }
}

run "deployment_regions" {
  assert {
    condition     = length(var.deployment_regions) == 2
    error_message = "incorrect default value"
  }
}

run "app_service_account_email" {
  assert {
    condition     = var.app_service_account_email != ""
    error_message = "incorrect default value"
  }
}

run "github_token" {
  assert {
    condition     = var.github_token != ""
    error_message = "incorrect default value"
  }
}

run "github_template_owner" {
  assert {
    condition     = var.github_template_owner != ""
    error_message = "incorrect default value"
  }
}

run "github_template_repo" {
  assert {
    condition     = var.github_template_repo != ""
    error_message = "incorrect default value"
  }
}

run "redis_read_endpoints" {
  assert {
    condition     = length(var.redis_read_endpoints) == 2
    error_message = "expected 2 redis read endpoints"
  }
}

run "waypoint_application" {
  assert {
    condition     = !contains(["-", "_"], var.waypoint_application)
    error_message = "incorrect validation condition"
  }
}

run "application_image_uri" {
  assert {
    condition     = var.application_image_uri == "nicholasjackson/fake-service"
    error_message = "incorrect default value"
  }
}

run "application_image_tag" {
  assert {
    condition     = var.application_image_tag == "v0.26.0"
    error_message = "incorrect default value"
  }
}

run "regional_vpc_connector_ids" {
  assert {
    condition     = length(var.regional_vpc_connector_ids) == 2
    error_message = "expected 2 regional VPC ids"
  }
}