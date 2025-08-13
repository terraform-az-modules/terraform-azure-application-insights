##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "app_insights_id" {
  value       = try(azurerm_application_insights.application_insights[0].id, null)
  description = "The ID of the Application Insights component."
}

output "app_insights_app_id" {
  value       = try(azurerm_application_insights.application_insights[0].app_id, null)
  description = "The App ID associated with this Application Insights component."
}

output "instrumentation_key" {
  value       = try(azurerm_application_insights.application_insights[0].instrumentation_key, null)
  description = "The Instrumentation Key for this Application Insights component. (Sensitive)"
  sensitive   = true
}

output "connection_string" {
  value       = try(azurerm_application_insights.application_insights[0].connection_string, null)
  description = "The Connection String for this Application Insights component. (Sensitive)"
  sensitive   = true
}
