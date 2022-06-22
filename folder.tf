resource "grafana_folder" "Demos" {
  provider = grafana.second

  uid   = "12345"
  title = "Demos"
}

resource "grafana_folder" "Demos-3" {
  provider = grafana.second

  uid   = "123457"
  title = "Demos-3"
}
