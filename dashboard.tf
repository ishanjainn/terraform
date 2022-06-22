# Using a JSON file
resource "grafana_dashboard" "influxdb" {
  provider = grafana.second

  config_json = file("dashboards/sample-dashboard.json")
  folder      = grafana_folder.Demos.id
}