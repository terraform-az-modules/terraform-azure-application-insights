<!-- BEGIN_TF_DOCS -->

# Terraform Azure Application Insights

This directory contains an example usage of the **terraform-azure-application-insights**. It demonstrates how to use the module with default settings or with custom configurations.

---

## 📋 Requirements

| Name      | Version   |
|-----------|-----------|
| Terraform | >= 1.6.6  |
| Azurerm   | >= 4.31.0 |

---

## 🔌 Providers

None specified in this example.

---

## 📦 Modules

| Name                  | Source                                             | Version |
|-----------------------|----------------------------------------------------|---------|
| resource_group        | terraform-az-modules/resource-group/azure          | 1.0.0   |
| log-analytics         | terraform-az-modules/log-analytics/azure           | 1.0.0   |
| application-insights  | ../..                                              | n/a     |

---

## 🏗️ Resources

No resources are directly created in this example.

---

## 🔧 Inputs

No input variables are defined in this example.

---

## 📤 Outputs

| Name                   | Description                                                        |
|------------------------|--------------------------------------------------------------------|
| app_insights_id        | The ID of the Application Insights component                       |
| app_insights_app_id    | The App ID associated with the Application Insights component      |
| instrumentation_key    | The Instrumentation Key for this Application Insights component    |
| connection_string      | The Connection String for this Application Insights component      |


<!-- END_TF_DOCS -->
