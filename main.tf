##-----------------------------------------------------------------------------
# Standard Tagging Module – Applies standard tags to all resources for traceability
##-----------------------------------------------------------------------------
module "labels" {
  source          = "terraform-az-modules/tags/azure"
  version         = "1.0.0"
  name            = var.custom_name == null ? var.name : var.custom_name
  location        = var.location
  environment     = var.environment
  managedby       = var.managedby
  label_order     = var.label_order
  repository      = var.repository
  deployment_mode = var.deployment_mode
  extra_tags      = var.extra_tags
}

resource "random_uuid" "parent" {}

resource "random_uuid" "test_guids" {
  count   = var.enabled && var.web_test_enable ? length(var.list_of_test_urls) : 0
  keepers = { url = var.list_of_test_urls[count.index] }
}

resource "azurerm_application_insights" "application_insights" {
  count                                 = var.enabled ? 1 : 0
  name                                  = var.resource_position_prefix ? format("appi-%s", local.name) : format("%s-appi", local.name)
  location                              = var.location
  resource_group_name                   = var.resource_group_name
  application_type                      = var.application_type
  retention_in_days                     = var.retention_in_days
  sampling_percentage                   = var.sampling_percentage
  daily_data_cap_in_gb                  = var.daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = var.daily_data_cap_notifications_disabled
  disable_ip_masking                    = var.disable_ip_masking
  workspace_id                          = var.workspace_id
  local_authentication_disabled         = var.local_authentication_disabled
  internet_ingestion_enabled            = var.internet_ingestion_enabled
  internet_query_enabled                = var.internet_query_enabled
  force_customer_storage_for_profiler   = var.force_customer_storage_for_profiler
  tags                                  = module.labels.tags
}

resource "azurerm_application_insights_web_test" "main" {
  count                   = var.enabled && var.web_test_enable ? length(var.list_of_test_urls) : 0
  name                    = element(var.web_test_name, count.index)
  location                = azurerm_application_insights.application_insights[0].location
  resource_group_name     = var.resource_group_name
  application_insights_id = azurerm_application_insights.application_insights[0].id
  kind                    = var.kind
  frequency               = var.frequency
  timeout                 = var.timeout
  enabled                 = var.monitored_enabled
  retry_enabled           = var.retry_enabled
  geo_locations           = var.geo_locations
  description             = var.description
  configuration = format("%s%s%s",
    format(var.header, random_uuid.parent.result, var.description),
    format(replace(var.test_body, "PARSEDEPS", var.parse_deps), random_uuid.test_guids[count.index].result, var.list_of_test_urls[count.index]), var.footer
  )
}

resource "azurerm_monitor_diagnostic_setting" "main" {
  count                          = var.enabled && var.diagnostic_setting_enable ? 1 : 0
  name                           = var.resource_position_prefix ? format("appi-diag-setting-%s", local.name) : format("%s-appi-diag-setting", local.name)
  target_resource_id             = azurerm_application_insights.application_insights[0].id
  storage_account_id             = var.storage_account_id
  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_destination_type
  enabled_metric {
    category = "AllMetrics"
  }
  enabled_log {
    category       = var.category
    category_group = "AllLogs"
  }
  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}