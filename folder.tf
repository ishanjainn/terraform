resource "grafana_folder" "ElasticSearch" {
  provider = grafana.second

  title = "ElasticSearch"
}

resource "grafana_folder" "InfluxDB" {
  provider = grafana.second

  title = "InfluxDB"
}

resource "grafana_folder" "AWS" {
  provider = grafana.second

  title = "AWS"
}
