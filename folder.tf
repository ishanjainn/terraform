resource "grafana_folder" "Elasticsearch" {
  provider = grafana.second

  title = "Elasticsearch"
}

resource "grafana_folder" "InfluxDB" {
  provider = grafana.second

  title = "InfluxDB"
}

resource "grafana_folder" "AWS" {
  provider = grafana.second

  title = "AWS"
}
