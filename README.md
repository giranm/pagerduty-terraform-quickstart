# pagerduty-terraform-quickstart
An example quick start Terraform project to provision a PagerDuty environment.  
This project covers most of the functionality from the [PagerDuty Provider](https://www.terraform.io/docs/providers/pagerduty/index.html), but is intended for learning/development purposes.

## TL;DR
TBD

## Prerequisites
* PagerDuty:
  * Access to a domain: https://www.pagerduty.com/sign-up/
  * Access to a REST API Token from target domain: https://support.pagerduty.com/docs/generating-api-keys
  * Incident priority enabled within target domain: https://support.pagerduty.com/docs/incident-priority
  * (Optional) `rulesets.tf` require [Event Intelligence](https://support.pagerduty.com/docs/event-intelligence) to be enabled on the domain - [Contact our team](https://www.pagerduty.com/contact-us/) for access
* Terraform CLI: https://learn.hashicorp.com/terraform/getting-started/install

## Installation

1. Clone repo into appropriate location and enter directory.
```bash
$ git clone git@github.com:giranm/pagerduty-terraform-quickstart.git
```
```bash
$ cd pagerduty-terraform-quickstart
```

2. Initialise Terraform (Local State)
```bash
$ terraform init
```

A successful output should look something like:
```
Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "pagerduty" (terraform-providers/pagerduty) 1.7.3...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.pagerduty: version = "~> 1.7"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Once initialized, `terraform.tfstate` will keep the current state of the deployment on the local disk.  
If you wish to have this securely managed, kindly consider using a [remote backend provider](https://www.terraform.io/docs/backends/index.html).  

## Usage
Once a PagerDuty REST API token has been generated within the appropriate domain, the repo can be used to provision resources using Terraform.  
The token can be passed through the command line or as an environment variable; we *do not* recommend checking this into the code.

```bash
$ terraform apply -var="PAGERDUTY_TOKEN=TOKEN_HERE"
```

*or*

```bash
$ export TF_VAR_PAGERDUTY_TOKEN=TOKEN_HERE
$ terraform apply
```

Terraform `apply` will formulate an appropriate plan depending on the order of resources to be provisioned/updated.  
```bash
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # pagerduty_addon.google_suite_dashboard will be created
  + resource "pagerduty_addon" "google_suite_dashboard" {
      + id   = (known after apply)
      + name = "Google G-Suite Dashboard"
      + src  = "https://www.google.com/appsstatus#hl=en-GB&v=status"
    }

  # pagerduty_business_service.example_application will be created
  + resource "pagerduty_business_service" "example_application" {
      + description      = "Example application represented by a business service"
      + html_url         = (known after apply)
      + id               = (known after apply)
      + name             = "Example Application"
      + point_of_contact = "Operations"
      + self             = (known after apply)
      + summary          = (known after apply)
      + type             = "business_service"
    }

  (... omitted for brevity)

Plan: 62 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: 
```

When you've reviewed the suggested changes, enter `yes` to provision/update the resources.  
```bash
  Enter a value: yes

pagerduty_team.support: Creating...
pagerduty_team.operations: Creating...
pagerduty_team.it_management: Creating...

  (... omitted for brevity)

pagerduty_team.it_management: Creation complete after 1s [id=PDZPP6T]
pagerduty_team.support: Creation complete after 2s [id=PA01OU3]
pagerduty_team.operations: Creation complete after 2s [id=PWQDNED]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

## Details
TBD
