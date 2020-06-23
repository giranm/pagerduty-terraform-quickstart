/* 
  PagerDuty DataSources Definition
*/

/* 
  Integration Vendors
  - https://developer.pagerduty.com/api-reference/reference/REST/openapiv3.json/paths/~1vendors/get
  - https://www.terraform.io/docs/providers/pagerduty/d/vendor.html
*/
data "pagerduty_vendor" "new_relic" {
  name    = "New Relic"
}

data "pagerduty_vendor" "splunk" {
  name    = "Splunk"
}

/* 
  Priorities - This needs to be enabled in the domain these files are run against.
  - https://support.pagerduty.com/docs/incident-priority
  - https://www.terraform.io/docs/providers/pagerduty/d/priority.html
*/
data "pagerduty_priority" "p1" {
  name    = "P1"
}

data "pagerduty_priority" "p2" {
  name    = "P2"
}

data "pagerduty_priority" "p3" {
  name    = "P3"
}

data "pagerduty_priority" "p4" {
  name    = "P4"
}

data "pagerduty_priority" "p5" {
  name    = "P5"
}

/* 
  Extensions
  - https://developer.pagerduty.com/api-reference/reference/REST/openapiv3.json/paths/~1extension_schemas/get
  - https://www.terraform.io/docs/providers/pagerduty/d/extension_schema.html
*/
data "pagerduty_extension_schema" "custom_incident_action" {
  name    = "Custom Incident Action"
}