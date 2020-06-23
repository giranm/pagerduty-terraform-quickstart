/* 
  PagerDuty Team Membership (see teams.tf and users.tf)
  Ref: https://www.terraform.io/docs/providers/pagerduty/r/team_membership.html 
*/

/* 
  Support
*/
resource "pagerduty_team_membership" "catelyn_stark" {
  user_id = pagerduty_user.catelyn_stark.id
  team_id = pagerduty_team.support.id
}

resource "pagerduty_team_membership" "robb_stark" {
  user_id = pagerduty_user.robb_stark.id
  team_id = pagerduty_team.support.id
}

resource "pagerduty_team_membership" "arya_stark" {
  user_id = pagerduty_user.arya_stark.id
  team_id = pagerduty_team.support.id
}

resource "pagerduty_team_membership" "sansa_stark" {
  user_id = pagerduty_user.sansa_stark.id
  team_id = pagerduty_team.support.id
}

resource "pagerduty_team_membership" "eddard_stark" {
  user_id = pagerduty_user.eddard_stark.id
  team_id = pagerduty_team.support.id
}

/* 
  Operations
*/
resource "pagerduty_team_membership" "cersei_lannister" {
  user_id = pagerduty_user.cersei_lannister.id
  team_id = pagerduty_team.operations.id
}

resource "pagerduty_team_membership" "jamie_lannister" {
  user_id = pagerduty_user.jamie_lannister.id
  team_id = pagerduty_team.operations.id
}

resource "pagerduty_team_membership" "tyrion_lannister" {
  user_id = pagerduty_user.tyrion_lannister.id
  team_id = pagerduty_team.operations.id
}

resource "pagerduty_team_membership" "lancel_lannister" {
  user_id = pagerduty_user.lancel_lannister.id
  team_id = pagerduty_team.operations.id
}

resource "pagerduty_team_membership" "tywin_lannister" {
  user_id = pagerduty_user.tywin_lannister.id
  team_id = pagerduty_team.operations.id
}

/* 
  IT Management
*/
resource "pagerduty_team_membership" "daenerys_targaryen" {
  user_id = pagerduty_user.daenerys_targaryen.id
  team_id = pagerduty_team.it_management.id
}

resource "pagerduty_team_membership" "davos_seaworth" {
  user_id = pagerduty_user.davos_seaworth.id
  team_id = pagerduty_team.it_management.id
}

/* 
  Executive Stakeholders
*/
resource "pagerduty_team_membership" "tormund_giantsbane" {
  user_id = pagerduty_user.tormund_giantsbane.id
  team_id = pagerduty_team.executive.id
}

resource "pagerduty_team_membership" "grey_worm" {
  user_id = pagerduty_user.grey_worm.id
  team_id = pagerduty_team.executive.id
}