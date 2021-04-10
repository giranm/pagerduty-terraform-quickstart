terraform {
  required_version = ">= 0.13.0"
  required_providers {
    pagerduty = {
      source = "PagerDuty/pagerduty"
      version = "1.9.6"
    }
  }
}