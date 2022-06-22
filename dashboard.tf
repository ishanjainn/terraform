# Using a JSON file
resource "grafana_dashboard" "influxdb" {
  provider = grafana.second

  config_json = file("sample-dashboard.json")
  folder      = grafana_folder.Demos.id
}