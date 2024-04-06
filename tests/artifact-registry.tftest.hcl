run "artifact_registry_repository" {
  assert {
    condition     = google_artifact_registry_repository.application.location == var.default_region
    error_message = "incorrect location"
  }

  assert {
    condition     = google_artifact_registry_repository.application.repository_id == var.waypoint_application
    error_message = "incorrect repository_id"
  }

  assert {
    condition     = google_artifact_registry_repository.application.description == "Repository for ${var.waypoint_application} application images."
    error_message = "incorrect description"
  }

  assert {
    condition     = google_artifact_registry_repository.application.format == "DOCKER"
    error_message = "incorrect format"
  }
}

run "artifact_registry_repository_iam_member" {
  assert {
    condition     = google_artifact_registry_repository_iam_member.github_writer.project == var.gcp_project_id
    error_message = "incorrect project"
  }

  assert {
    condition     = google_artifact_registry_repository_iam_member.github_writer.location == var.default_region
    error_message = "incorrect location"
  }

  assert {
    condition     = google_artifact_registry_repository_iam_member.github_writer.repository == google_artifact_registry_repository.application.id
    error_message = "incorrect repository id"
  }

  assert {
    condition     = google_artifact_registry_repository_iam_member.github_writer.role == "roles/artifactregistry.writer"
    error_message = "incorrect role"
  }

  assert {
    condition     = google_artifact_registry_repository_iam_member.github_writer.member == "serviceAccount:${google_service_account.github_actions.email}"
    error_message = "incorrect member"
  }
}

run "artifact_registry_repository_iam_member_service_writer" {
  assert {
    condition     = google_artifact_registry_repository_iam_member.service_writer.project == var.gcp_project_id
    error_message = "incorrect project"
  }

  assert {
    condition     = google_artifact_registry_repository_iam_member.service_writer.location == var.default_region
    error_message = "incorrect location"
  }

  assert {
    condition     = google_artifact_registry_repository_iam_member.service_writer.repository == google_artifact_registry_repository.application.id
    error_message = "incorrect repository id"
  }

  assert {
    condition     = google_artifact_registry_repository_iam_member.service_writer.role == "roles/artifactregistry.writer"
    error_message = "incorrect role"
  }

  assert {
    condition     = google_artifact_registry_repository_iam_member.service_writer.member == "serviceAccount:${var.app_service_account_email}"
    error_message = "incorrect member"
  }
}