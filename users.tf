/* 
  PagerDuty User Definition
  Ref: https://www.terraform.io/docs/providers/pagerduty/r/user.html
*/

/* 
  Support
*/
resource "pagerduty_user" "catelyn_stark" {
  name  = "Catelyn Stark"
  email = "catelyn_stark@example.com"
  role  = "limited_user"
}

resource "pagerduty_user" "robb_stark" {
  name  = "Robb Stark"
  email = "robb_stark@example.com"
  role  = "limited_user"
}

resource "pagerduty_user" "arya_stark" {
  name  = "Arya Stark"
  email = "arya_stark@example.com"
  role  = "limited_user"
}

resource "pagerduty_user" "sansa_stark" {
  name  = "Sansa Stark"
  email = "sansa_stark@example.com"
  role  = "limited_user"
}

resource "pagerduty_user" "eddard_stark" {
  name  = "Ned Stark"
  email = "eddard_stark@example.com"
  role  = "user"
}

/* 
  Operations
*/
resource "pagerduty_user" "cersei_lannister" {
  name  = "Cersei Lannister"
  email = "cersei_lannister@example.com"
  role  = "limited_user"
}

resource "pagerduty_user" "jamie_lannister" {
  name  = "Jaime Lannister"
  email = "jamie_lannister@example.com"
  role  = "limited_user"
}

resource "pagerduty_user" "tyrion_lannister" {
  name  = "Tyrion Lannister"
  email = "tyrion_lannister@example.com"
  role  = "limited_user"
}

resource "pagerduty_user" "lancel_lannister" {
  name  = "Lancel Lannister"
  email = "lancel_lannister@example.com"
  role  = "limited_user"
}

resource "pagerduty_user" "tywin_lannister" {
  name  = "Tywin Lannister"
  email = "tywin_lannister@example.com"
  role  = "user"
}

/* 
  IT Management
*/
resource "pagerduty_user" "daenerys_targaryen" {
  name  = "Daenerys Targaryen"
  email = "daenerys_targaryen@example.com"
  role  = "admin"
}

resource "pagerduty_user" "davos_seaworth" {
  name  = "Davos Seaworth"
  email = "davos_seaworth@example.com"
  role  = "admin"
}

/* 
  Executive Stakeholders
*/
resource "pagerduty_user" "tormund_giantsbane" {
  name  = "Tormund Giantsbane"
  email = "tormund_giantsbane@example.com"
  role  = "restricted_access"
}

resource "pagerduty_user" "grey_worm" {
  name  = "Grey Worm"
  email = "grey_worm@example.com"
  role  = "restricted_access"
}