resource "grafana_folder" "Production" {
  title = "Production"
}

resource "grafana_folder" "Staging" {
  title = "Staging"
}

resource "grafana_folder" "Dev" {
  title = "Dev"
}
