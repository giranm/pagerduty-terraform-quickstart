/* 
  PagerDuty User Notification Rules
  Ref: https://www.terraform.io/docs/providers/pagerduty/r/user_notification_rule.html
*/

/* 
  Single User Example: Support Responder Catelyn Stark
  Various rules depending on incident urgency - high often requires immediate attention.
*/
resource "pagerduty_user_notification_rule" "catelyn_stark_phone_high_urgency" {
  user_id                 = pagerduty_user.catelyn_stark.id
  start_delay_in_minutes  = 1
  urgency                 = "high"
  contact_method = {
    type = "phone_contact_method"
    id   = pagerduty_user_contact_method.catelyn_stark_phone.id
  }
}

resource "pagerduty_user_notification_rule" "catelyn_stark_sms_high_urgency" {
  user_id                = pagerduty_user.catelyn_stark.id
  start_delay_in_minutes = 1
  urgency                = "high"
  contact_method = {
    type = "sms_contact_method"
    id   = pagerduty_user_contact_method.catelyn_stark_sms.id
  }
}

resource "pagerduty_user_notification_rule" "catelyn_stark_email_low_urgency" {
  user_id                = pagerduty_user.catelyn_stark.id
  start_delay_in_minutes = 5
  urgency                = "low"
  contact_method = {
    type = "email_contact_method"
    id   = pagerduty_user_contact_method.catelyn_stark_email.id
  }
}