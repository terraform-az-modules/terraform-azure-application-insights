##-----------------------------------------------------------------------------
## Naming convention
##-----------------------------------------------------------------------------
variable "custom_name" {
  type        = string
  default     = null
  description = "Override default naming convention"
}

variable "resource_position_prefix" {
  type        = bool
  default     = true
  description = <<EOT
Controls the placement of the resource type keyword (e.g., "vnet", "ddospp") in the resource name.

- If true, the keyword is prepended: "vnet-core-dev".
- If false, the keyword is appended: "core-dev-vnet".

This helps maintain naming consistency based on organizational preferences.
EOT
}

##-----------------------------------------------------------------------------
## Labels
##-----------------------------------------------------------------------------
variable "name" {
  type        = string
  default     = "core"
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "managedby" {
  type        = string
  default     = "terraform-az-modules"
  description = "ManagedBy, eg 'terraform-az-modules'."
}

variable "extra_tags" {
  type        = map(string)
  default     = null
  description = "Variable to pass extra tags."
}

variable "repository" {
  type        = string
  default     = "https://github.com/terraform-az-modules/terraform-azure-azure-application-insights"
  description = "Terraform current module repo"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid Git repo link."
  }
}

variable "location" {
  type        = string
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "deployment_mode" {
  type        = string
  default     = "terraform"
  description = "Specifies how the infrastructure/resource is deployed"
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment", "location"]
  description = "The order of labels used to construct resource names or tags. If not specified, defaults to ['name', 'environment', 'location']."
}

##-----------------------------------------------------------------------------
## Global Variables
##-----------------------------------------------------------------------------
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the network security group."
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "application_type" {
  type        = string
  default     = "web"
  description = "(Required) Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Values are case sensitive. Unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created."
}

variable "retention_in_days" {
  type        = number
  default     = 90
  description = "Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90."
}

variable "sampling_percentage" {
  type        = number
  default     = 100
  description = "Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry."
}

variable "daily_data_cap_in_gb" {
  type        = number
  default     = 30
  description = "Specifies the Application Insights component daily data volume cap in GB."
}

variable "daily_data_cap_notifications_disabled" {
  type        = bool
  default     = false
  description = "Specifies if a notification email will be sent when the daily data volume cap is met. Defaults to false."
}

variable "disable_ip_masking" {
  type        = bool
  default     = false
  description = "By default the real client IP is masked as 0.0.0.0 in the logs. Use this to disable masking and log the real client IP. Defaults to false."
}

variable "workspace_id" {
  type        = string
  default     = null
  description = "(Optional) Specifies the ID of a Log Analytics workspace resource. Changing this forces a new resource to be created."
}

variable "local_authentication_disabled" {
  type        = bool
  default     = false
  description = "(Optional) Disable non-Azure AD based authentication. Defaults to false."
}

variable "internet_ingestion_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should the Application Insights component support ingestion over the public internet? Defaults to false."
}

variable "internet_query_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should the Application Insights component support querying over the public internet? Defaults to false."
}

variable "force_customer_storage_for_profiler" {
  type        = bool
  default     = false
  description = "Should the Application Insights component force users to create their own storage account for profiling? Defaults to false."
}

variable "web_test_enable" {
  type        = bool
  default     = true
  description = "Enables or disables creation of web availability tests."
}

variable "list_of_test_urls" {
  type        = list(string)
  default     = ["https://www.google.com", "https://www.github.com"]
  description = "List of URLs to use in the availability tests. Example: [\"https://test1.example.com\", \"https://test2.example.com/app\"]"
}

variable "kind" {
  type        = string
  default     = "ping"
  description = "Specifies the type of web test. Examples: 'ping' or 'multistep'. Leave empty for default."
}

variable "frequency" {
  type        = number
  default     = 300
  description = "Interval in seconds between test runs for this WebTest. Default is 300."
}

variable "timeout" {
  type        = number
  default     = 60
  description = "Seconds until this WebTest will timeout and fail. Default is 30."
}

variable "monitored_enabled" {
  type        = bool
  default     = true
  description = "Indicates whether the availability test is enabled."
}

variable "retry_enabled" {
  type        = bool
  default     = true
  description = "Allow for retries should this WebTest fail."
}

variable "description" {
  type        = string
  default     = ""
  description = "Purpose or user-defined descriptive text for this WebTest."
}

variable "geo_locations" {
  type        = list(string)
  default     = ["us-ca-sjc-azr", "us-tx-sn1-azr", "us-il-ch1-azr", "us-va-ash-azr", "us-fl-mia-edge"]
  description = "Specifies a list of locations to physically run the tests from, to give global coverage."
}

variable "header" {
  type        = string
  default     = "<WebTest Name=\"WebTest1\" Id=\"%s\" Enabled=\"True\" CssProjectStructure=\"\" CssIteration=\"\" Timeout=\"0\" WorkItemIds=\"\" xmlns=\"http://microsoft.com/schemas/VisualStudio/TeamTest/2010\" Description=\"%s\" CredentialUserName=\"\" CredentialPassword=\"\" PreAuthenticate=\"True\" Proxy=\"default\" StopOnError=\"False\" RecordedResultFile=\"\" ResultsLocale=\"\"><Items>"
  description = "The XML header template for web test configuration."
}

variable "footer" {
  type        = string
  default     = "</Items></WebTest>"
  description = "The XML footer template for web test configuration."
}

variable "test_body" {
  type        = string
  default     = "<Request Method=\"GET\" Guid=\"%s\" Version=\"1.1\" Url=\"%s\" ThinkTime=\"0\" Timeout=\"300\" ParseDependentRequests=\"PARSEDEPS\" FollowRedirects=\"True\" RecordResult=\"True\" Cache=\"True\" ResponseTimeGoal=\"0\" Encoding=\"utf-8\" ExpectedHttpStatusCode=\"200\" ExpectedResponseUrl=\"\" ReportingName=\"\" IgnoreHttpStatusCode=\"False\" />"
  description = "WebTest XML request body. If overridden, make sure to retain all the string format() parameters needed for the configuration."
}

variable "parse_deps" {
  type        = bool
  default     = false
  description = "Retrieve resources linked to by the test URL as part of the web test. Valid values are true or false. Default is false."
}

variable "diagnostic_setting_enable" {
  type        = bool
  default     = true
  description = "Enables or disables creation of diagnostic settings for Application Insights."
}

variable "log_analytics_workspace_id" {
  type        = string
  default     = null
  description = "The ID of the Log Analytics workspace to send diagnostics data to."
}

variable "log_analytics_destination_type" {
  type        = string
  default     = "AzureDiagnostics"
  description = "Possible values are AzureDiagnostics and Dedicated. Default is AzureDiagnostics. When set to Dedicated, logs sent to a Log Analytics workspace will go into resource-specific tables instead of the legacy AzureDiagnostics table."
}

variable "log_category" {
  type        = string
  default     = null
  description = "The name of a Diagnostic Log Category or Category Group for this resource."
}

variable "metric_category" {
  type        = string
  default     = "AllMetrics"
  description = "The category for enabled metrics"
}

variable "log_category_group" {
  type        = string
  default     = "AllLogs"
  description = "The category group for enabled logs"
}

variable "storage_account_id" {
  type        = string
  default     = null
  description = "The ID of the Storage Account where diagnostics logs should be sent."
}

variable "eventhub_name" {
  type        = string
  default     = null
  description = "Specifies the name of the Event Hub where diagnostics data should be sent."
}

variable "eventhub_authorization_rule_id" {
  type        = string
  default     = null
  description = "Specifies the ID of an Event Hub Namespace Authorization Rule used to send diagnostics data."
}
