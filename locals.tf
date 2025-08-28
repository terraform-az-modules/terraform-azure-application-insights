##-----------------------------------------------------------------------------
## Locals
##-----------------------------------------------------------------------------
locals {
  name           = var.custom_name != null ? var.custom_name : module.labels.id
  web_test_names = [for url in var.list_of_test_urls : split(".", replace(replace(replace(url, "https://", ""), "http://", ""), "www.", ""))[0]]
}