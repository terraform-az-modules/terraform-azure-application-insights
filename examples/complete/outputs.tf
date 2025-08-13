##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "app_insights_id" {
  value       = module.application-insights.app_insights_id
  description = "The ID of the Application Insights component."
}

output "app_insights_app_id" {
  value       = module.application-insights.app_insights_app_id
  description = "The App ID associated with this Application Insights component."
}

output "instrumentation_key" {
  value       = module.application-insights.instrumentation_key
  description = "The Instrumentation Key for this Application Insights component. (Sensitive)"
  sensitive   = true
}

output "connection_string" {
  value       = module.application-insights.connection_string
  description = "The Connection String for this Application Insights component. (Sensitive)"
  sensitive   = true
}
