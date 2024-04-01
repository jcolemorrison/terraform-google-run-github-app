# Create a service account used to give access to github action workflow
resource "google_service_account" "github_actions" {
  account_id   = "gha-${var.waypoint_application}"
  display_name = "Github Actions ${var.waypoint_application}"
}

# Create a key for the service account
resource "google_service_account_key" "github_actions" {
  service_account_id = google_service_account.github_actions.name
}

# Create base repository for application
resource "github_repository" "application" {
  name       = var.waypoint_application
  visibility = "public"

  template {
    owner                = var.github_template_owner
    repository           = var.github_template_repo
    include_all_branches = false
  }
}

# Create a README.md file in the repository
resource "github_repository_file" "readme" {
  repository = github_repository.application.name
  branch     = "main"
  file       = "README.md"
  content = templatefile("${path.module}/templates/README.md", {
    application_name = var.waypoint_application,
  })
  commit_message      = "Added readme file."
  commit_author       = "Platform team"
  commit_email        = "me@jcolemorrison.com"
  overwrite_on_create = true
}

# Create github action secret for the GCP credentials
resource "github_actions_secret" "gcp_credentials" {
  repository      = github_repository.application.name
  secret_name     = "GCP_SA_KEY"
  plaintext_value = base64decode(google_service_account_key.github_actions.private_key)
}

resource "github_actions_secret" "gcp_project_id" {
  repository      = github_repository.application.name
  secret_name     = "GCP_PROJECT_ID"
  plaintext_value = var.gcp_project_id
}

resource "github_actions_secret" "gcp_image_region" {
  repository      = github_repository.application.name
  secret_name     = "GCP_REGION"
  plaintext_value = var.default_region
}

resource "github_actions_secret" "gcp_artifact_registry_repo_name" {
  repository      = github_repository.application.name
  secret_name     = "GCP_ARTIFACT_REPO_NAME"
  plaintext_value = google_artifact_registry_repository.application.name
}

resource "github_actions_secret" "tfc_organization" {
  repository      = github_repository.application.name
  secret_name     = "TF_ORG_NAME"
  plaintext_value = var.tfc_organization
}

resource "github_actions_secret" "tfc_workspace_name" {
  repository      = github_repository.application.name
  secret_name     = "TF_WORKSPACE_NAME"
  plaintext_value = var.waypoint_application
}

resource "github_actions_secret" "tfc_api_token" {
  repository      = github_repository.application.name
  secret_name     = "TF_API_TOKEN"
  plaintext_value = var.tfc_api_token
}