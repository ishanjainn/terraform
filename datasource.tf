resource "grafana_data_source" "influxdb" {
  provider = grafana.second

  type          = "influxdb"
  name          = "influxdb"
  url           = "https://influxdb.test.com"
  username      = "username"
  password      = "password"
  database_name = "test"
}