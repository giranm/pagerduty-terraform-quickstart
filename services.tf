/* 
  PagerDuty Services, Integrations, Dependencies, and Maintenance Windows
  - https://www.terraform.io/docs/providers/pagerduty/r/business_service.html
  - https://www.terraform.io/docs/providers/pagerduty/r/service.html
  - https://www.terraform.io/docs/providers/pagerduty/r/service_dependency.html
  - https://www.terraform.io/docs/providers/pagerduty/r/service_integration.html
  - https://www.terraform.io/docs/providers/pagerduty/r/maintenance_window.html
*/

/* 
  Business Service (e.g. higher-level business application)
*/
resource "pagerduty_business_service" "example_application" {
  name             = "Example Application"
  description      = "Example application represented by a business service"
  point_of_contact = "Operations"
}

/* 
  Technical Services (e.g. lower-level microservices)
*/
resource "pagerduty_service" "example_application_website" {
  name                    = "Website"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.support.id
  alert_creation          = "create_alerts_and_incidents"
  incident_urgency_rule {
    type    = "constant"
    urgency = "severity_based"
  }
}

resource "pagerduty_service" "example_application_database" {
  name                    = "Database"
  auto_resolve_timeout    = 14400
  acknowledgement_timeout = 600
  escalation_policy       = pagerduty_escalation_policy.operations.id
  alert_creation          = "create_alerts_and_incidents"
  incident_urgency_rule {
    type    = "constant"
    urgency = "severity_based"
  }
}

/* 
  Service Dependencies
*/
resource "pagerduty_service_dependency" "example_application_website" {
  dependency {
    dependent_service {
      id    = pagerduty_business_service.example_application.id
      type  = "business_service"
    }
    supporting_service {
      id    = pagerduty_service.example_application_website.id
      type  = "service"
    }
  }
}

resource "pagerduty_service_dependency" "example_application_database" {
  dependency {
    dependent_service {
      id    = pagerduty_business_service.example_application.id
      type  = "business_service"
    }
    supporting_service {
      id    = pagerduty_service.example_application_database.id
      type  = "service"
    }
  }
}

/* 
  Technical Service Integrations (e.g. 3rd-party integration per technical service)
*/
resource "pagerduty_service_integration" "example_application_website_new_relic" {
  name    = "New Relic Integration"
  vendor  = data.pagerduty_vendor.new_relic.id
  service = pagerduty_service.example_application_website.id
}

resource "pagerduty_service_integration" "example_application_database_splunk" {
  name    = "Splunk Integration"
  vendor  = data.pagerduty_vendor.splunk.id
  service = pagerduty_service.example_application_database.id
}

/* 
  Technical Service Maintenance Window (e.g. disable creation of incidents during Christmas)
*/
resource "pagerduty_maintenance_window" "christmas_downtime" {
  start_time  = format("%s-12-24T17:00:00-00:00", formatdate("YYYY", timestamp()))
  end_time    = format("%s-12-26T09:00:00-00:00", formatdate("YYYY", timestamp()))
  services    = [
                pagerduty_service.example_application_website.id,
                pagerduty_service.example_application_database.id
              ]
}