/* 
  PagerDuty Response Plays
  Ref: https://registry.terraform.io/providers/PagerDuty/pagerduty/latest/docs/resources/response_play 
*/

/* 
  Major Incident (P1/P2) Response Play
*/
resource "pagerduty_response_play" "major_incident_response_play" {

  # Summary
  name        = "Major Incident Response"
  from        = pagerduty_user.davos_seaworth.email
  description = "Response play for Major Incident (P1/P2)"

  # What should happen when this play runs?
  conference_number = "+1-555-555-5555,,1234#"
  conference_url = "https://myconference.bridge.com/123-456-678"

  responder {
    type = "escalation_policy_reference"
    id   = pagerduty_escalation_policy.support.id
  }

  responder {
    type = "escalation_policy_reference"
    id   = pagerduty_escalation_policy.operations.id
  }

  subscriber {
    type = "team_reference"
    id   = pagerduty_team.it_management.id
  }

  subscriber {
    type = "team_reference"
    id   = pagerduty_team.executive.id
  }

  subscribers_message = "Major incident identified - teams have been mobilised"

  # Who can run this play on demand?
  runnability = "responders"
}