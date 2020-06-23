/* 
  PagerDuty Escalation Policies (see users.tf and schedules.tf)
  Ref: https://www.terraform.io/docs/providers/pagerduty/r/escalation_policy.html
*/

/* 
  Support: 3 level escalation path
*/
resource "pagerduty_escalation_policy" "support" {
  name      = "Support (EP)"
  num_loops = 3
  teams     = [pagerduty_team.support.id]
  rule {
    escalation_delay_in_minutes = 5
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.support_level_1.id
    }
  }
  rule {
    escalation_delay_in_minutes = 15
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.support_level_2.id
    }
  }
  rule {
    escalation_delay_in_minutes = 30
    target {
      type = "user"
      id   = pagerduty_user.eddard_stark.id
    }
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.it_management.id
    }
  }
}

/* 
  Operations: 3 level escalation path
*/
resource "pagerduty_escalation_policy" "operations" {
  name      = "Operations (EP)"
  num_loops = 3
  teams     = [pagerduty_team.operations.id]
  rule {
    escalation_delay_in_minutes = 15
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.operations_level_1.id
    }
  }
  rule {
    escalation_delay_in_minutes = 30
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.operations_level_2.id
    }
  }
  rule {
    escalation_delay_in_minutes = 60
    target {
      type = "user"
      id   = pagerduty_user.tywin_lannister.id
    }
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.it_management.id
    }
  }
}

/* 
  IT Management: Singular escalation path
*/
resource "pagerduty_escalation_policy" "it_management" {
  name      = "IT Management (EP)"
  teams     = [pagerduty_team.it_management.id]
  rule {
    escalation_delay_in_minutes = 15
    target {
      type = "schedule_reference"
      id   = pagerduty_schedule.it_management.id
    }
  }
}