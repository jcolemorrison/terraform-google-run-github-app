variable "tfc_organization" {
  description = "Terraform Cloud Organization name"
  type        = string
}

variable "tfc_api_token" {
  description = "Terraform Cloud API token for github actions"
  type        = string
  sensitive   = true
}

variable "gcp_project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "default_region" {
  description = "default region for the project deployment"
  type        = string
  default     = "us-west1"
}

variable "deployment_regions" {
  description = "regions to deploy"
  type        = list(string)
  default     = ["us-west1", "us-east1"]
}

variable "app_service_account_email" {
  description = "Email of the GCP service account with permissions from the services and core projects."
  type        = string
}

variable "github_token" {
  description = "Valid access token for Github with public_repo and delete_repo permissions"
  type        = string
  sensitive   = true
}

variable "github_template_owner" {
  description = "The name of the owner ororganization in Github that will contain the template repo."
  type        = string
}

variable "github_template_repo" {
  description = "The name of the repository in Github that contains the template repo."
  type        = string
}

variable "redis_read_endpoints" {
  description = "The list of Redis read endpoints."
  type        = map(string)
}

variable "waypoint_application" {
  type        = string
  description = "Name of the Waypoint application or no-code module workspace."

  validation {
    condition     = !contains(["-", "_"], var.waypoint_application)
    error_message = "waypoint_application must not contain dashes or underscores."
  }
}

variable "application_image_uri" {
  description = "The artifact registry URI of the application image to deploy."
  type        = string
  default     = "nicholasjackson/fake-service"
}

variable "application_image_tag" {
  description = "The artifact registry tag of the application image to deploy."
  type        = string
  default     = "v0.26.0"
}

variable "application_image_env_variables" {
  description = "The environment variables to set in the application image."
  type        = list(map(string))
  default     = []
}

variable "regional_vpc_connector_ids" {
  description = "A map of regional VPC connector IDs."
  type        = map(string)
}