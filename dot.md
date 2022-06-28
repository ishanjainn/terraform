---
aliases:
- docs/grafana-cloud/infrastructure-as-code/terraform/user-permissions/
keywords:
- Infrastructure as Code
- Quickstart
- Grafana Cloud
- Terraform
title: Managing permissions across teams in Grafana cloud instance using Terraform
weight: 120
---

# Managing users and permissions on Grafana cloud instance using Terraform

This tutorial is useful for admins and others who want to learn how to manage permissions across teams. In this tutorial, Learn how to manage permissions across teams in Grafana cloud instance using Terraform.

## Prerequisites

Before you begin, you should have the following available:

- A Grafana Cloud account, as shown in [Quickstarts]({{< relref "../../quickstart/_index.md" >}})
- [Terraform](https://www.terraform.io/downloads) installed on your machine

> **NOTE:** All of the following Terraform configuration files should be saved in the same directory.

## Terraform configuration for Grafana provider

This Terraform configuration configures the [Grafana provider](https://registry.terraform.io/providers/grafana/grafana/latest/docs) to provide necessary authentication when creating folders and dashboards in the Grafana instance.

1. Create an API key in the Grafana instance. You'll need this key to configure Terraform.

   1. Log into your Grafana Cloud instance. 
   2. Open settings(Gear icon) and select the `API Keys` option. 
   3. Click **Add API Key**. 
   4. In **Key Name**, enter a name for your API key. 
   5. In **Role**, select the `Admin` or `Editor` role to associate with this API key.

1. Create a file named `main.tf` in the Git root directory and add the following code block:

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

1. Replace the following field values:

  - `<Grafana-instance-url>` with the URL of your Grafana instance.
  - `<Grafana-API-Key>` with API key from the Grafana instance.

## Create Teams and add members

This Terraform configuration creates three teams in the Grafana instance. For this guide, we will create three teams named `Admins`, `Developers`, and `Sales` and add members to these teams. Make sure, the members being added to the teams are already added in the Cloud portal. See [Create users and teams](https://grafana.com/tutorials/create-users-and-teams/#add-users) tutorial.
> **NOTE:** Members cannot be added to Grafana Cloud instance using Grafana Terraform provider as of now and can only be added manually from the Cloud portal.

Create a file named `team.tf` and add the following:

```terraform
resource "grafana_team" "Admins" {
   provider = grafana.cloud

   name  = "Admins"
   members = [
      "staff3.name@example.com",
      "staff4.name@example.com"
   ]
}

resource "grafana_team" "Developers" {
 provider = grafana.cloud

 name  = "Developers"
 members = [
   "staff1.name@example.com",
   "staff2.name@example.com"
 ]
}

resource "grafana_team" "Sales" {
   provider = grafana.cloud

   name  = "Sales"
   members = [
      "staff5.name@example.com",
      "staff6.name@example.com"
   ]
}
```

## Managing folder permissions across teams

This Terraform configuration creates a folder named `SLO` in the Grafana instance using [grafana_folder (Resource)](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/folder). 
It also adds  `Admin` permissions for `Admins` team, `Edit` permissions for `Developers` team, and `View` permissions for `Sales` team across the `SLO` folder

Create a file named `folder.tf` and add the following:

   ```terraform
   resource "grafana_folder" "SLO" {
     provider = grafana.cloud
   
     title = "SLO"
   }
   
   resource "grafana_folder_permission" "SLO" {
     provider = grafana.cloud
   
     folder_uid = grafana_folder.SLO.uid
     permissions {
       team_id    = grafana_team.Administrators.id
       permission = "Admin"
     }
     permissions {
       team_id    = grafana_team.Developers.id
       permission = "Edit"
     }
     permissions {
       team_id    = grafana_team.Sales.id
       permission = "View"
     }
   }
   ```

## Managing dashboard Permissions across teams

This Terraform configuration creates a dashboard inside the folder created above in your Grafana instance using [grafana_dashboard (Resource)](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/dashboard).
It also adds `Admin` permissions for `Admins` team, `Edit` permissions for `Developers` team, and `View` permissions for `Sales` team across the dashboard we are adding.

1. Create a file named `dashbaord.tf` and add the following:

   ```terraform
   resource "grafana_dashboard" "Availability" {
     provider = grafana.cloud
   
     config_json = file("<file-name>.json")
     folder      = grafana_folder.SLO.id
   }
   
   resource "grafana_dashboard_permission" "Availability" {
     provider = grafana.cloud
   
     dashboard_id = grafana_dashboard.Availability.dashboard_id
   
     permissions {
       team_id    = grafana_team.Administrators.id
       permission = "Admin"
     }
     permissions {
       team_id    = grafana_team.Developers.id
       permission = "Edit"
     }
     permissions {
       team_id    = grafana_team.Sales.id
       permission = "View"
     }
   }
   ```

1. Replace the following field value:

   - `<file-name>` with the name of the JSON file that has the source code for the dashboard.

   The dashboard is represented by its JSON source code and referenced in the `config_json` parameter.

## Managing data source permissions across teams

>**NOTE:** Only Grafna cloud Pro and Enterprise users can add data source permissions

This Terraform configuration adds a data source and `Edit` permissions for the `Admins` team and `Query` permissions for the `Developers` and `Sales` team across the configured datasource
For this guide we are using the InfluxDB data source. The required arguments for [grafana_data_source (Resource)](https://registry.terraform.io/providers/grafana/grafana/latest/docs/resources/data_source) vary depending on the type of data source you select.

1. Create a file named `datasource.tf` and add the following:

   ```terraform
   resource "grafana_data_source" "<data-source-name>" {
      provider = grafana.second
       
      type          = "influxdb"
      name          = "<data-source-name>"
      url           = "<data-source-url>"
      username      = "<username>"
      password      = "<password>"
      database_name = "<db-name>"
   }
   
   resource "grafana_data_source_permission" "<data-source-name>" {
    provider = grafana.cloud
   
    datasource_id = grafana_data_source.influxdb.id
    permissions {
      team_id    = grafana_team.admins.id
      permission = "Edit"
    }
    permissions {
      team_id    = grafana_team.developers.id
      permission = "Query"
    }
    permissions {
      team_id    = grafana_team.sales.id
      permission = "Query"
    }
   }
   ```

1. Replace the following field values:

    - `<data-source-name>` with the name of the data source to be added in Grafana.
    - `<data-source-url>` with URL of your data source.
    - `<username>` with the username for authenticating with your data source.
    - `<password>` with password for authenticating with your data source.
    - `<db-name>` with name of your database.

## Validation

- `Admins`, `Developers`, and `Sales` teams are created in the Grafana instance.

- `SLO` folder is created in the Grafana instance with `Admin` permissions for `Admins` team, `Edit` permissions for `Developers` team, and `View` permissions for `Sales` team across the folder

- A new dashboard in the Grafana instance. In the following image a dashboard named `InfluxDB Metrics` was created inside the `SLO` folder with `Admin` permissions for `Admins` team, `Edit` permissions for `Developers` team, and `View` permissions for `Sales` team across the dashboard

- A new data source (InfluxDB in this example) is visible in the grafana instance with `Edit` permissions for the `Admins` team and `Query` permissions for the `Developers` and `Sales` team across the data source

## Conclusion

In this guide, you created permissions for teams across resources like folders, dashboards and data sources.

To learn more about managing Grafana Cloud using Terraform, see [Grafana provider's documentation](https://registry.terraform.io/providers/grafana/grafana/latest/docs).
