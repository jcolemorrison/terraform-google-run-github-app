# Create artifact registry repository for application images
resource "google_artifact_registry_repository" "application" {
  location      = var.default_region
  repository_id = var.waypoint_application
  description   = "Repository for ${var.waypoint_application} application images."
  format        = "DOCKER"
}

# Grant the service account the ability to write to the artifact registry
resource "google_artifact_registry_repository_iam_member" "github_writer" {
  project    = var.gcp_project_id
  location   = var.default_region
  repository = google_artifact_registry_repository.application.name
  role       = "roles/artifactregistry.admin"
  member     = "serviceAccount:${google_service_account.github_actions.email}"
}

# Grant the Cloud Run service account the ability to pull from artifact registry
resource "google_artifact_registry_repository_iam_member" "service_writer" {
  project    = var.gcp_project_id
  location   = var.default_region
  repository = google_artifact_registry_repository.application.name
  role       = "roles/artifactregistry.admin"
  member     = "serviceAccount:${var.app_service_account_email}"
}