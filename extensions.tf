/* 
  PagerDuty Service Extensions
  Ref: https://www.terraform.io/docs/providers/pagerduty/r/extension.html
  
  NB: You can only define 1 entry for "extension_objects" per extension
  i.e. multiple extensions for the same service requires multiple "pagerduty_extension" stanzas
*/

/* 
  Website Extension
*/
resource "pagerduty_extension" "example_application_website_webhook_1" {
  name                = "Invoke Webhook - Website"
  endpoint_url        = var.webhook_url
  extension_schema    = data.pagerduty_extension_schema.custom_incident_action.id
  extension_objects   = [pagerduty_service.example_application_website.id]
}

/* 
  Database Extension
*/
resource "pagerduty_extension" "example_application_database_webhook_1" {
  name                = "Invoke Webhook - Database"
  endpoint_url        = var.webhook_url
  extension_schema    = data.pagerduty_extension_schema.custom_incident_action.id
  extension_objects   = [pagerduty_service.example_application_database.id]
}