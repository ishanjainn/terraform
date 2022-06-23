resource "grafana_dashboard" "elasticsearch" {
  provider = grafana.second

  for_each    = fileset("${path.module}/dashboards/elasticsearch", "*.json")
  config_json = file("${path.module}/dashboards/elasticsearch/${each.key}")
  folder      = grafana_folder.Elasticsearch.id
}

resource "grafana_dashboard" "influxdb" {
  provider = grafana.second

  for_each    = fileset("${path.module}/dashboards/influxdb", "*.json")
  config_json = file("${path.module}/dashboards/influxdb/${each.key}")
  folder      = grafana_folder.Influxdb.id
}

resource "grafana_dashboard" "aws" {
  provider = grafana.second

  for_each    = fileset("${path.module}/dashboards/aws", "*.json")
  config_json = file("${path.module}/dashboards/aws/${each.key}")
  folder      = grafana_folder.Aws.id
}
