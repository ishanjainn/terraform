# Using a JSON file
resource "grafana_dashboard" "influxdb" {
  provider = grafana.second

  for_each    = fileset(path.module, "dashboards/*.json")
  config_json = file("${path.module}/${each.key}")
  folder      = grafana_folder.Demos.id
}