resource "grafana_dashboard" "production" {
  for_each    = fileset("${path.module}/dashboards/production", "*.json")
  config_json = file("${path.module}/dashboards/production/${each.key}")
  folder      = grafana_folder.Production.id
}

resource "grafana_dashboard" "staging" {
  for_each    = fileset("${path.module}/dashboards/staging", "*.json")
  config_json = file("${path.module}/dashboards/staging/${each.key}")
  folder      = grafana_folder.Staging.id
}

resource "grafana_dashboard" "dev" {
  for_each    = fileset("${path.module}/dashboards/dev", "*.json")
  config_json = file("${path.module}/dashboards/dev/${each.key}")
  folder      = grafana_folder.Dev.id
}
