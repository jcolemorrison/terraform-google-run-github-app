run "google_service_account" {
  assert {
    condition     = google_service_account.github_actions.account_id == "gha-${var.waypoint_application}"
    error_message = "incorrect account_id"
  }

  assert {
    condition     = google_service_account.github_actions.display_name == "Github Actions ${var.waypoint_application}"
    error_message = "incorrect display_name"
  }
}

run "github_repository" {
  assert {
    condition     = github_repository.application.name == var.waypoint_application
    error_message = "incorrect name"
  }

  assert {
    condition     = github_repository.application.visibility == "public"
    error_message = "incorrect visibility"
  }

  assert {
    condition     = github_repository.application.template.owner == var.github_template_owner
    error_message = "incorrect template owner"
  }

  assert {
    condition     = github_repository.application.template.repository == var.github_template_repo
    error_message = "incorrect template repository"
  }

  assert {
    condition     = github_repository.application.template.include_all_branches == false
    error_message = "incorrect template include_all_branches"
  }
}

run "github_repository_file" {
  assert {
    condition     = github_repository_file.readme.repository == github_repository.application.name
    error_message = "incorrect repository"
  }

  assert {
    condition     = github_repository_file.readme.branch == "main"
    error_message = "incorrect branch"
  }

  assert {
    condition     = github_repository_file.readme.file == "README.md"
    error_message = "incorrect file"
  }

  assert {
    condition     = github_repository_file.readme.commit_message == "Added readme file."
    error_message = "incorrect commit_message"
  }

  assert {
    condition     = github_repository_file.readme.commit_author == "Platform team"
    error_message = "incorrect commit_author"
  }

  assert {
    condition     = github_repository_file.readme.commit_email == "me@jcolemorrison.com"
    error_message = "incorrect commit_email"
  }

  assert {
    condition     = github_repository_file.readme.overwrite_on_create == true
    error_message = "incorrect overwrite_on_create"
  }
}

run "github_actions_secret" {
  assert {
    condition     = github_actions_secret.gcp_credentials.repository == github_repository.application.name
    error_message = "incorrect repository"
  }

  assert {
    condition     = github_actions_secret.gcp_credentials.secret_name == "GCP_SA_KEY"
    error_message = "incorrect secret_name"
  }

  assert {
    condition     = github_actions_secret.gcp_credentials.plaintext_value == base64decode(google_service_account_key.github_actions.private_key)
    error_message = "incorrect plaintext_value"
  }
}

run "github_actions_secret_gcp_project_id" {
  assert {
    condition     = github_actions_secret.gcp_project_id.repository == github_repository.application.name
    error_message = "incorrect repository"
  }

  assert {
    condition     = github_actions_secret.gcp_project_id.secret_name == "GCP_PROJECT_ID"
    error_message = "incorrect secret_name"
  }

  assert {
    condition     = github_actions_secret.gcp_project_id.plaintext_value == var.gcp_project_id
    error_message = "incorrect plaintext_value"
  }
}

run "github_actions_secret_gcp_image_region" {
  assert {
    condition     = github_actions_secret.gcp_image_region.repository == github_repository.application.name
    error_message = "incorrect repository"
  }

  assert {
    condition     = github_actions_secret.gcp_image_region.secret_name == "GCP_REGION"
    error_message = "incorrect secret_name"
  }

  assert {
    condition     = github_actions_secret.gcp_image_region.plaintext_value == var.default_region
    error_message = "incorrect plaintext_value"
  }
}

run "github_actions_secret_gcp_artifact_registry_repo_name" {
  assert {
    condition     = github_actions_secret.gcp_artifact_registry_repo_name.repository == github_repository.application.name
    error_message = "incorrect repository"
  }

  assert {
    condition     = github_actions_secret.gcp_artifact_registry_repo_name.secret_name == "GCP_ARTIFACT_REPO_NAME"
    error_message = "incorrect secret_name"
  }

  assert {
    condition     = github_actions_secret.gcp_artifact_registry_repo_name.plaintext_value == google_artifact_registry_repository.application.name
    error_message = "incorrect plaintext_value"
  }
}

run "github_actions_secret_tfc_organization" {
  assert {
    condition     = github_actions_secret.tfc_organization.repository == github_repository.application.name
    error_message = "incorrect repository"
  }

  assert {
    condition     = github_actions_secret.tfc_organization.secret_name == "TF_ORG_NAME"
    error_message = "incorrect secret_name"
  }

  assert {
    condition     = github_actions_secret.tfc_organization.plaintext_value == var.tfc_organization
    error_message = "incorrect plaintext_value"
  }
}

run "github_actions_secret_tfc_workspace_name" {
  assert {
    condition     = github_actions_secret.tfc_workspace_name.repository == github_repository.application.name
    error_message = "incorrect repository"
  }

  assert {
    condition     = github_actions_secret.tfc_workspace_name.secret_name == "TF_WORKSPACE_NAME"
    error_message = "incorrect secret_name"
  }

  assert {
    condition     = github_actions_secret.tfc_workspace_name.plaintext_value == var.waypoint_application
    error_message = "incorrect plaintext_value"
  }
}

run "github_actions_secret_tfc_api_token" {
  assert {
    condition     = github_actions_secret.tfc_api_token.repository == github_repository.application.name
    error_message = "incorrect repository"
  }

  assert {
    condition     = github_actions_secret.tfc_api_token.secret_name == "TF_API_TOKEN"
    error_message = "incorrect secret_name"
  }

  assert {
    condition     = github_actions_secret.tfc_api_token.plaintext_value == var.tfc_api_token
    error_message = "incorrect plaintext_value"
  }
}