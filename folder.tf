resource "grafana_folder" "Demos" {
  provider = grafana.second

  uid   = "12345"
  title = "Demos"
}