# pagerduty-terraform-quickstart

An example quick start Terraform project to provision a PagerDuty environment.  
This project covers most of the functionality from the [PagerDuty Provider](https://www.terraform.io/docs/providers/pagerduty/index.html), but is intended for learning/development purposes.

## Summary Video (TL;DR)

[![Watch the video](https://i.ytimg.com/vi/osFY5_t-E8Q/maxresdefault.jpg)](https://youtu.be/c9M5B-Ri3Nc)

## Prerequisites

- PagerDuty:
  - Access to a domain: https://www.pagerduty.com/sign-up/
  - Access to a REST API Token from target domain: https://support.pagerduty.com/docs/generating-api-keys
  - Incident priority enabled within target domain: https://support.pagerduty.com/docs/incident-priority
  - (Optional) `rulesets.tf` require [Event Intelligence](https://support.pagerduty.com/docs/event-intelligence) to be enabled on the domain - [Contact our team](https://www.pagerduty.com/contact-us/) for access
- Terraform:
  - [CLI](https://learn.hashicorp.com/terraform/getting-started/install) - minimum version of v0.13 required
  - [tfswitch](https://medium.com/@warrensbox/how-to-manage-different-terraform-versions-for-each-project-51cca80ccece) - if you need to switch Terraform versions back and forth - i.e. compatibility existing with older projects.

## Installation

1. Clone repo (via SSH) into appropriate location and enter directory.

    ```bash
    $ git clone git@github.com:giranm/pagerduty-terraform-quickstart.git
    ```

    ```bash
    $ cd pagerduty-terraform-quickstart
    ```

    > NB - if you cannot clone via SSH, try using HTTPS instead via:
    ```bash
    $ git clone https://github.com/giranm/pagerduty-terraform-quickstart.git
    ```

2. Initialise Terraform Workspace

    ```bash
    $ terraform init
    ```

A successful output should look something like:

```
Initializing the backend...

Initializing provider plugins...
- Finding pagerduty/pagerduty versions matching "1.9.6"...
- Installing pagerduty/pagerduty v1.9.6...
- Installed pagerduty/pagerduty v1.9.6 (signed by a HashiCorp partner, key ID 027C6DD1F0707B45)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

## Usage

Once a PagerDuty REST API token has been generated within the appropriate domain, the repo can be used to provision resources using Terraform.  
The token can be passed through the command line or as an environment variable; we _do not_ recommend checking this into the code.

```bash
$ terraform apply -var="PAGERDUTY_TOKEN=TOKEN_HERE"
```

_or_

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

Once the resources have been provisioned, `terraform.tfstate` will keep the current state of the deployment on the local disk. If you wish to have this securely managed, kindly consider using a [remote backend provider](https://www.terraform.io/docs/backends/index.html).