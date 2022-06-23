---
keywords:
- Infrastructure as Code
- Quickstart
- Grafana Cloud
- Terraform
- GitHub Actions
  title: Creating and managing dashboards using Terraform and GitHub Actions
  weight: 100
---

# Creating and managing dashboards using Terraform and GitHub Actions
Learn how to create and manage multiple dashboards represented as Json source code for Grafana Cloud stack using [Terraform](https://www.terraform.io/) and [GitHub Actions](https://github.com/features/actions).

# Prerequisites
Before you begin, you should have the following available:
* A Grafana Cloud account, as shown in [Quickstarts]({{< relref "../../quickstart/_index.md" >}})
* [GitHub](https://github.com/) repository

## Adding Dashboards to GitHub repository
> **NOTE:** For this guide, we are adding dashboards for ElasticSearch, InfluxDB and AWS EC2. You can use different Dashboards according to your configured Datasources

1. In the Git root directory, Create a folder named `dashboards`
2. In the `dashboards` folder create three sub-folders named `elasticsearch`, `influxdb` and `aws`
3. Add a sample dashboard represented as code in the `elasticsearch` folder. An example dashboard's Json source code is below

`elasticsearch-metrics.json`
```json
{
  "id": null,
  "uid": "elasticxyz",
  "title": "ElasticSearch metrics",
  "tags": [],
  "style": "dark",
  "timezone": "browser",
  "editable": true,
  "hideControls": false,
  "graphTooltip": 1,
  "panels": [
    {
      "id": 14,
      "gridPos": {
        "h": 10,
        "w": 24,
        "x": 0,
        "y": 0
      },
      "type": "graph",
      "title": "CPU",
      "datasource": {
        "type": "elasticsearch",
        "uid": "yvKcQK37z"
      },
      "thresholds": [],
      "pluginVersion": "9.0.1-b253e87pre",
      "links": [],
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": false,
        "total": false,
        "values": false
      },
      "aliasColors": {
        "Max nodes.process.cpu.percent": "#890F02",
        "nodes.process.cpu.percent": "#890F02"
      },
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "editable": true,
      "error": false,
      "fill": 5,
      "fillGradient": 0,
      "grid": {},
      "hiddenSeries": false,
      "lines": true,
      "linewidth": 2,
      "nullPointMode": "connected",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pointradius": 5,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "{{field}}",
          "bucketAggs": [
            {
              "field": "@timestamp",
              "id": "2",
              "settings": {
                "interval": "auto",
                "min_doc_count": 0,
                "trimEdges": 0
              },
              "type": "date_histogram"
            }
          ],
          "dsType": "elasticsearch",
          "metrics": [
            {
              "field": "nodes.process.cpu.percent",
              "id": "1",
              "meta": {},
              "settings": {},
              "type": "max"
            }
          ],
          "query": "cluster_name:$Cluster",
          "refId": "A",
          "timeField": "@timestamp"
        }
      ],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "tooltip": {
        "msResolution": true,
        "shared": true,
        "sort": 0,
        "value_type": "cumulative"
      },
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "percent",
          "label": "",
          "logBase": 1,
          "max": null,
          "min": "0",
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    }
  ],
  "time": {
    "from": "now-6h",
    "to": "now"
  },
  "timepicker": {
    "time_options": [],
    "refresh_intervals": []
  },
  "templating": {
    "list": []
  },
  "annotations": {
    "list": []
  },
  "refresh": "5s",
  "schemaVersion": 17,
  "version": 0,
  "links": []
}
```
4. Add a sample dashboard represented as code in the `influxdb` folder. An example dashboard's Json source code is below

`air-sensors.json`
```json
{
  "id": null,
  "uid": "airxyz",
  "title": "Air Sensors",
  "tags": [],
  "style": "dark",
  "timezone": "browser",
  "editable": true,
  "hideControls": false,
  "graphTooltip": 1,
  "panels": [
    {
      "datasource": {
        "type": "influxdb",
        "uid": "xLNPLcX7z"
      },
      "description": "Air sensor sample data from InfluxDB https://docs.influxdata.com/influxdb/cloud/reference/sample-data/#air-sensor-sample-data",
      "fieldConfig": {
        "defaults": {
          "color": {
            "mode": "palette-classic"
          },
          "custom": {
            "axisLabel": "",
            "axisPlacement": "auto",
            "barAlignment": 0,
            "drawStyle": "line",
            "fillOpacity": 0,
            "gradientMode": "none",
            "hideFrom": {
              "legend": false,
              "tooltip": false,
              "viz": false
            },
            "lineInterpolation": "linear",
            "lineStyle": {
              "fill": "solid"
            },
            "lineWidth": 1,
            "pointSize": 5,
            "scaleDistribution": {
              "type": "linear"
            },
            "showPoints": "auto",
            "spanNulls": false,
            "stacking": {
              "group": "A",
              "mode": "none"
            },
            "thresholdsStyle": {
              "mode": "off"
            }
          },
          "mappings": [],
          "thresholds": {
            "mode": "absolute",
            "steps": [
              {
                "color": "green",
                "value": null
              },
              {
                "color": "red",
                "value": 80
              }
            ]
          }
        },
        "overrides": [
          {
            "__systemRef": "hideSeriesFrom",
            "matcher": {
              "id": "byNames",
              "options": {
                "mode": "exclude",
                "names": [
                  "co TLM0102"
                ],
                "prefix": "All except:",
                "readOnly": true
              }
            },
            "properties": [
              {
                "id": "custom.hideFrom",
                "value": {
                  "legend": false,
                  "tooltip": false,
                  "viz": true
                }
              }
            ]
          }
        ]
      },
      "gridPos": {
        "h": 11,
        "w": 24,
        "x": 0,
        "y": 0
      },
      "id": 2,
      "options": {
        "legend": {
          "calcs": [],
          "displayMode": "list",
          "placement": "bottom"
        },
        "tooltip": {
          "mode": "single",
          "sort": "none"
        }
      },
      "targets": [
        {
          "datasource": {
            "type": "influxdb",
            "uid": "xLNPLcX7z"
          },
          "query": "import \"influxdata/influxdb/sample\"\r\nsample.data(set: \"airSensor\")\r\n\t|> range(start: v.timeRangeStart, stop: v.timeRangeStop)\r\n  |> filter(fn: (r) => r[\"_measurement\"] == \"airSensors\")\r\n  |> filter(fn: (r) => r[\"_field\"] == \"temperature\" or r[\"_field\"] == \"humidity\" or r[\"_field\"] == \"co\")\r\n",
          "refId": "A"
        }
      ],
      "title": "Air Sensors",
      "type": "timeseries"
    }
  ],
  "time": {
    "from": "now-6h",
    "to": "now"
  },
  "timepicker": {
    "time_options": [],
    "refresh_intervals": []
  },
  "templating": {
    "list": []
  },
  "annotations": {
    "list": []
  },
  "refresh": "5s",
  "schemaVersion": 17,
  "version": 0,
  "links": []
}
```

5. Add a sample dashboard represented as code in the `aws` folder. An example dashboard's Json source code is below

`ec2-metrics.json`
```json
{
  "id": null,
  "uid": "ec2xyz",
  "title": "EC2 CPU utilization",
  "tags": [],
  "style": "dark",
  "timezone": "browser",
  "editable": true,
  "hideControls": false,
  "graphTooltip": 1,
  "panels": [
    {
      "collapsed": false,
      "datasource": {
        "uid": "$datasource"
      },
      "gridPos": {
        "h": 1,
        "w": 24,
        "x": 0,
        "y": 0
      },
      "id": 14,
      "panels": [],
      "title": "Overview",
      "type": "row"
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": {
        "uid": "$datasource"
      },
      "fieldConfig": {
        "defaults": {
          "links": []
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 24,
        "x": 0,
        "y": 1
      },
      "hiddenSeries": false,
      "id": 2,
      "legend": {
        "alignAsTable": true,
        "avg": true,
        "current": false,
        "max": false,
        "min": false,
        "rightSide": true,
        "show": true,
        "sort": "avg",
        "sortDesc": true,
        "total": false,
        "values": true
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "connected",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "9.0.1-b253e87pre",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "alias": "",
          "dimensions": {
            "InstanceId": "*"
          },
          "expression": "",
          "id": "",
          "matchExact": true,
          "metricEditorMode": 0,
          "metricName": "CPUUtilization",
          "metricQueryType": 0,
          "namespace": "AWS/EC2",
          "period": "$period",
          "refId": "B",
          "region": "$region",
          "statistic": "Maximum"
        }
      ],
      "thresholds": [],
      "timeRegions": [],
      "title": "CPU utilization per instance [max %]",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "mode": "time",
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "percent",
          "label": "",
          "logBase": 1,
          "max": "100",
          "min": "0",
          "show": true
        },
        {
          "format": "short",
          "logBase": 1,
          "show": true
        }
      ],
      "yaxis": {
        "align": false
      }
    }
  ],
  "time": {
    "from": "now-6h",
    "to": "now"
  },
  "timepicker": {
    "time_options": [],
    "refresh_intervals": []
  },
  "templating": {
    "list": []
  },
  "annotations": {
    "list": []
  },
  "refresh": "5s",
  "schemaVersion": 17,
  "version": 0,
  "links": []
}
```

## Grafana Terraform provider Configuration
1. Create an API key in the Grafana instance. You'll need this key to configure Terraform
    1. Log into your Grafana Cloud instance
    2. Open settings(Gear icon) and select the `API Keys` option
    3. Click **Add API Key**.
    5. In **Key Name**, enter a name for your API key.
    6. In **Role**, select the `Admin` or `Editor` role to associate with this API key
2. Create a file named `main.tf` in the Git root directory and Copy the following code block and paste it in the file.

```terraform
terraform {
   required_providers {
      grafana = {
         source  = "grafana/grafana"
         version = "1.24.0"
      }
   }
}

provider "grafana" {
   alias = "cloud"

   url   = "<Grafana-instance-url>"
   auth  = "<Grafana-API-Key>"
}
```

2. Replace the following field values (using mono-space here to get the values to be commented in):
    1. `<Grafana-instance-url>` with the URL of your Grafana instance
    2. `<Grafana-API-Key>` with API key from the Grafana instance

This Terraform configuration configures the [Grafana provider](https://registry.terraform.io/providers/grafana/grafana/latest/docs) to provide necessary authentication when creating folders and dashboards in the Grafana instance


## Folders Terraform configuration
1. Create a file named `folders.tf` in the Git root directory and Copy the following code block and paste it in the file.

```terraform
resource "grafana_folder" "ElasticSearch" {
   provider = grafana.cloud

   title = "ElasticSearch"
}

resource "grafana_folder" "InfluxDB" {
   provider = grafana.cloud

   title = "InfluxDB"
}

resource "grafana_folder" "AWS" {
   provider = grafana.cloud

   title = "AWS"
}
```

This Terraform configuration creates three folders named `ElasticSearch`, `InfluxDB` and `AWS` in the Grafana instance using [grafana_folder (Resource)](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/folder).

## Dashboards Terraform configuration
1. Create a file named `dashboards.tf` in the Git root directory and Copy the following code block and paste it in the file.

```terraform
resource "grafana_dashboard" "elasticsearch" {
   provider = grafana.cloud

   for_each    = fileset("${path.module}/dashboards/elasticsearch", "*.json")
   config_json = file("${path.module}/dashboards/elasticsearch/${each.key}")
   folder      = grafana_folder.ElasticSearch.id
}

resource "grafana_dashboard" "influxdb" {
   provider = grafana.cloud

   for_each    = fileset("${path.module}/dashboards/influxdb", "*.json")
   config_json = file("${path.module}/dashboards/influxdb/${each.key}")
   folder      = grafana_folder.InfluxDB.id
}

resource "grafana_dashboard" "aws" {
   provider = grafana.cloud

   for_each    = fileset("${path.module}/dashboards/aws", "*.json")
   config_json = file("${path.module}/dashboards/aws/${each.key}")
   folder      = grafana_folder.AWS.id
}
```
This Terraform configuration iterates through the Json files in three folders(`elasticsearch`, `influxdb` and `aws`) in the GitHub repository and add them to the respective folders
in the Grafana instance using [grafana_dashboard (Resource)](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard).
For example the Dashboard represented as Json source code in the `elasticsearch` folder in the GitHub repository will be created in the `ElasticSearch` folder in the Grafana Instance

## GitHub Workflow for managing dashboards using Terraform
1. In the Git root directory, Create a folder named `.github`
2. In the `.github` folder create a sub-folder named `workflows`
3. Create a file named `terraform.yml` in the `workflows` directory and Copy the following code block and paste it in the file

```yaml
name: Terraform

on:
  push:
    branches:
    - "main"
  pull_request:

jobs:
  terraform:
    runs-on: ubuntu-latest
    
    steps:
    # Checkout the repository to the GitHub Actions runner
    - name: Checkout
      uses: actions/checkout@v3

    # Install the latest version of Terraform CLI
    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v1

    # Initialize a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, etc.
    - name: Terraform Init
      run: terraform init

    # Checks that all Terraform configuration files adhere to a canonical format
    - name: Terraform Format
      run: terraform fmt -check

    # Previews the changes that Terraform will make 
    - name: Plan Terraform
      id: plan
      continue-on-error: true
      run: terraform plan -input=false -no-color    

    # Post the preview (terraform plan) from the previous step as a GitHub pull request comment
    - name: Post Plan to GitHub PR
      if: github.ref != 'refs/heads/main'
      uses: mshick/add-pr-comment@v1
      with:
        repo-token: ${{ secrets.GITHUB_TOKEN }}
        repo-token-user-login: 'github-actions[bot]'
        message: |
          Applying:
          
          ```
          ${{ steps.plan.outputs.stdout }}
          ```
    
    # Applies the terraform configuration files when the branch is `main`
    - name: Apply Terraform
      if: github.ref == 'refs/heads/main'
      id: apply
      continue-on-error: true
      run: |
        terraform apply -auto-approve
```

This GitHub workflow runs only on a Pull Request or when changes are pushed to the `main` branch. The workflow consists of the following steps
1. The GitHub repository is checkout on the GitHub runner using the [actions/checkout@v3](https://github.com/actions/checkout) action
2. The Terraform CLI is installed on the GitHub runner using the [hashicorp/setup-terraform@v1](https://github.com/hashicorp/setup-terraform) action
3. `terraform init` is run as a bash command in the GitHub runner to initialize a working directory containing Terraform configuration files
4. `terraform fmt -check` is run as a bash command in the GitHub runner to check if the Terraform configuration files are properly formatted. If they Terraform configuration files are not properly formatted, the workflow will fail at this step.
5. `terraform plan` is run as a bash command in the GitHub runner to preview the changes that Terraform will make
6. Using [mshick/add-pr-comment@v1](https://github.com/mshick/add-pr-comment) action, The preview from Terraform plan is posted as a comment on the Pull Request. This helps in reviewing the changes that Terraform will make before the Pull Request is merged.
7. `terraform appy -auto-approve` is run as a bash command in the GitHub runner to apply the Terraform configuration files. `-auto-approve` flag is added to the command to skip interactive approval of plan before applying and make the workflow automated.
   This step is run only when changes are committed to `main` branch. When a Pull Request is merged, the merge action creates a commit to the `main` branch which triggers the `terraform apply -auto-approve` step to execute

## Managing Terraform state

If you are not using a [Terraform backend](https://www.terraform.io/language/settings/backends/configuration) to store the `.tfstate` file, Add the following code block to the end of the GitHub workflow file to make sure the Terraform state file is stored in Git.

```yaml
- name: commit the terraform state
  if: github.ref == 'refs/heads/main'
  uses: stefanzweifel/git-auto-commit-action@v4
  with:
    commit_message: Updating Terraform state
    file_pattern: terraform.tfstate
```
When we run `terraform apply`,Terraform automatically manages and updates the `terraform.tfstate` file to store state about your infrastructure and configuration.
This step uses the [stefanzweifel/git-auto-commit-action@v4](https://github.com/stefanzweifel/git-auto-commit-action) action to auto-commit the `terraform.tfstate` file for changes made by the running the `terraform apply` step.

> **NOTE:** Storing Terraform state file (terraform.tfstate) should not be stored in Git to avoid leakage of sensitive data.
> The preferred way to store Terraform state file is to use a remote backend like AWS S3 with proper RBAC. See [more about Terraform State](https://www.terraform.io/language/state)

## Validation
Once the GitHub workflow run is successful, you should see the following:
1. `ElasticSearch`, `InfluxDB` and `AWS` folders are created in the Grafana instance
2. Dashboard represented as Json source code from `elasticsearch` folder in GitHub are added under the `ElasticSearch` folder in the Grafana instance
3. Dashboard represented as Json source code from `influxdb` folder in GitHub are added under the `InfluxDB` folder in the Grafana instance
4. Dashboard represented as Json source code from `aws` folder in GitHub are added under the `AWS` folder in the Grafana instance

## Conclusion
In this guide, you created a GitHub workflow using Terraform to manage dashboards represented Json source code. Using this workflow, The dashboards in the Grafana instance will always be insync with the Json source code files for Dashboards in GitHub

To learn more about managing Grafana Cloud using Terraform, see [Grafana provider's documentation](https://registry.terraform.io/providers/grafana/grafana/latest/docs).
