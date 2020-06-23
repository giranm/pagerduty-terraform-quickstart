/* 
  PagerDuty Add-On Screen Definitions
  - https://support.pagerduty.com/docs/extensions-add-ons#add-ons
  - https://www.terraform.io/docs/providers/pagerduty/r/addon.html
*/

/* 
  Add-On Example: Google Suite Dashboard embedded in iFrame
*/
resource "pagerduty_addon" "google_suite_dashboard" {
  name = "Google G-Suite Dashboard"
  src  = "https://www.google.com/appsstatus#hl=en-GB&v=status"
}