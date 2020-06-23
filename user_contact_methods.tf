/* 
  PagerDuty User Contact Methods
  Ref: https://www.terraform.io/docs/providers/pagerduty/r/user_contact_method.html
*/

/* 
  Single User Example: Support Responder Catelyn Stark
  Phone, SMS, and email notification methods

  NB. Users need to download the mobile app and sign-in if they want to configure push notifications.
*/
resource "pagerduty_user_contact_method" "catelyn_stark_phone" {
  user_id      = pagerduty_user.catelyn_stark.id
  type         = "phone_contact_method"
  country_code = "+1"
  address      = "2345678910"
  label        = "Work"
}

resource "pagerduty_user_contact_method" "catelyn_stark_sms" {
  user_id      = pagerduty_user.catelyn_stark.id
  type         = "sms_contact_method"
  country_code = "+1"
  address      = "2345678910"
  label        = "Work"
}

resource "pagerduty_user_contact_method" "catelyn_stark_email" {
  user_id     = pagerduty_user.catelyn_stark.id
  type        = "email_contact_method"
  address     = "catelyn_stark_work@example.com"
  label       = "Work"
}