resource "grafana_folder" "Demos" {
  provider = grafana.second

  uid   = "12345"
  title = "Demos"
}

resource "grafana_folder" "Demos-2" {
  provider = grafana.second

  uid   = "123456"
  title = "Demos-2"
}
