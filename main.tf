terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "1.24.0"
    }
  }
}

provider "grafana" {
  alias = "second"

  url  = "https://ishanawsterraformdem.grafana.net/"
  auth = "eyJrIjoiMG9VS2lzVGRsZVBkRW8xQlB2aDlrZnVycE80WTJNY0MiLCJuIjoieW8iLCJpZCI6MX0="
}
