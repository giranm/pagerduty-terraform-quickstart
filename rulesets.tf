/* 
  PagerDuty Rulesets Definition
  - https://support.pagerduty.com/docs/rulesets
  - https://www.terraform.io/docs/providers/pagerduty/r/ruleset.html
  - https://www.terraform.io/docs/providers/pagerduty/r/ruleset_rule.html
*/

/* 
  Rulesets: 
  
  These are usually managed per team basis but can be done globally.
  It should be noted that the rules within the rulesets obey a top down approach
  
  i.e. the first rule is executed and will stop processing if there is a match, else 
  the remaining rules are processed in descending order (see position index 1, 2, ... , N)
*/

resource "pagerduty_ruleset" "support_ruleset" {
  name = "Support: Ingest All Events"
  team { 
    id = pagerduty_team.support.id
  }
}

resource "pagerduty_ruleset" "global_ruleset" {
  name = "Global: Ingest All Events"
}

/* 
  Support Ruleset Rule Example 1:

  IF there is an incoming event with the support_ruleset routing key
  AND the current time is between 09:00 - 17:00 London, Monday to Friday
  AND payload.component = website 
  AND payload.severity = warning
  THEN route alert to website service
  AND create incident
  AND update incident severity
  AND update incident priority
  AND update incident note
*/

resource "pagerduty_ruleset_rule" "example_application_website_warning_1" {
  ruleset   = pagerduty_ruleset.support_ruleset.id
  position  = 1
  time_frame {
    scheduled_weekly {
      weekdays    = [1, 2, 3, 4, 5]
      timezone    = "Europe/London"
      start_time  = "32400000"
      duration    = "28800000"
    }
  }
  conditions {
    subconditions {
      operator = "contains"
      parameter {
        path  = "payload.component"
        value = "website"
      }
    }
    operator = "and"
    subconditions {
      operator = "contains"
      parameter {
        path  = "payload.severity"
        value = "warning"
      }
    }
  }
  actions {
    route {
      value = pagerduty_service.example_application_website.id
    }
    severity {
      value = "warning"
    }
    priority {
      value = data.pagerduty_priority.p3.id
    }
    annotate {
      value = "Routed via global rule: example_application_website_warning_1"
    }
  }
}

/* 
  Support Ruleset Rule Example 2:

  IF there is an incoming event with the support_ruleset routing key
  AND payload.component = website 
  AND payload.severity = warning
  AND the event has not matched the previous ruleset rule (out of hours)
  THEN suppress alert (i.e. do not create incident)
*/

resource "pagerduty_ruleset_rule" "example_application_website_warning_2" {
  ruleset   = pagerduty_ruleset.support_ruleset.id
  position  = 2
  conditions {
    subconditions {
      operator = "contains"
      parameter {
        path  = "payload.component"
        value = "website"
      }
    }
    operator = "and"
    subconditions {
      operator = "contains"
      parameter {
        path  = "payload.severity"
        value = "warning"
      }
    }
  }
  actions {
    suppress {
      value = true
    }
  }
}

/* 
  Global Ruleset Rule Example 3:

  IF there is an incoming event with the global_ruleset routing key
  AND payload.component matches Google RE2 Regex `(?i)database`
  AND payload.severity=critical
  THEN route alert to database service
  AND create incident
  AND extract (.*) from payload.component to dedup_key
  AND update incident severity
  AND update incident priority
  AND update incident note
*/
resource "pagerduty_ruleset_rule" "example_application_database_critical" {
  ruleset   = pagerduty_ruleset.global_ruleset.id
  conditions {
    subconditions {
      operator = "matches"
      parameter {
        value = "(?i)database"
        path  = "payload.component"
      }
    }
    operator = "and"
    subconditions {
      operator = "contains"
      parameter {
        path  = "payload.severity"
        value = "critical"
      }
    }
  }
  actions {
    route {
      value = pagerduty_service.example_application_database.id
    }
    severity {
      value = "critical"
    }
    priority {
      value = data.pagerduty_priority.p1.id
    }
    annotate {
      value = "Routed via global rule: example_application_database_critical"
    }
    extractions {
      source  = "payload.component"
      regex   = "(.*)"
      target  = "dedup_key"
    }
  }
}