resource "grafana_folder" "Production" {
  provider = grafana.second

  title = "Production"
}

resource "grafana_folder" "Staging" {
  provider = grafana.second

  title = "Staging"
}

resource "grafana_folder" "Dev" {
  provider = grafana.second

  title = "Dev"
}
