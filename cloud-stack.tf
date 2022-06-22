terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "1.24.0"
    }
  }
#   backend "s3" {
#     bucket = "terraform-ishan"
#     region = "ap-south-1"
#   }
}

# Declaring the first provider to be only used for creating the cloud-stack
provider "grafana" {
  alias = "first"

  cloud_api_key = "eyJrIjoiMGEwYTI3OWM1MmY5MzE5OWQxNzkwYTkyOTNjZWJjMDc1N2Y3MjJmNCIsIm4iOiJJc2hhbiIsImlkIjo2NTI5OTJ9"
}

resource "grafana_cloud_stack" "ishanterraformde" {
  provider = grafana.first

  name        = "ishanloterraformdem"
  slug        = "ishanloterraformdem"
  region_slug = "us" # Example “us”,”eu” etc
}

# Creating an API key in Grafana instance to be used for creating resources in Grafana instance
resource "grafana_api_key" "terraform" {
  provider = grafana.first

  cloud_stack_slug = grafana_cloud_stack.ishanterraformde.slug
  name             = "terraform"
  role             = "Admin"
}

# Declaring the second provider to be used for creating resources in Grafana
provider "grafana" {
  alias = "second"

  url  = grafana_cloud_stack.ishanterraformde.url
  auth = grafana_api_key.terraform.key
}
