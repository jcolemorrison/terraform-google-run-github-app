# Specify the required providers and their versions
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.17.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.2.1"
    }
  }
}

# Configure the Google Cloud provider
provider "google" {
  project = var.gcp_project_id
  region  = var.default_region
}

provider "github" {
  token = var.github_token
}
