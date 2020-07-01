/* 
  PagerDuty Team Definition
  Ref: https://www.terraform.io/docs/providers/pagerduty/r/team.html
*/

resource "pagerduty_team" "support" {
  name        = "Support"
  description = "Daytime Support Team" 
}

resource "pagerduty_team" "operations" {
  name        = "Operations"
  description = "24x7 Operations Team" 
}

resource "pagerduty_team" "it_management" {
  name        = "IT Management"
  description = "IT Management"  
}

resource "pagerduty_team" "executive" {
  name        = "Executive Stakeholders"
  description = "Executive Stakeholders"  
}