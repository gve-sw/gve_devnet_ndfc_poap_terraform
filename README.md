# gve_devnet_ndfc_poap_terraform
This PoV features explores the power of terraform in simplyfying the process of POAP(Power-on Auto Provisioning) in Nexus Dashboard Fabric Controller


## Contacts
* Hye young Kim


## Solution Components
* Nexus Dashboard Fabric Controller
* Terraform


## Installation/Configuration

This is as a template, project owner to update

Add any steps needed to install the project so that someone can reproduce the project

1. Fill in the ndfc settings in main.tf.

    ```
    data "http" "example" {
    url = ""

    request_headers = {
        Accept = "application/json"
        X-Nd-Username = ""
        X-Nd-Apikey = ""
    }
    insecure = true
    method = "GET"
    }

    provider "dcnm" {
        username = ""
        password = ""
        url      = ""
        insecure = true
        platform = "nd"
    }
    ```


2. Initialize Terraform. The [init command](https://developer.hashicorp.com/terraform/cli/commands/init) performs several different initialization steps in order to prepare the current working directory for use with Terraform. 
    ```
    terraform init
    ```


3. (Optional) Create a Terraform execution plan. The terraform [plan command](https://developer.hashicorp.com/terraform/cli/commands/plan) creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. 
    ```
    terraform plan
    ```


4. Apply the terraform changes. The terraform [apply command](https://developer.hashicorp.com/terraform/cli/commands/apply) executes the actions proposed in the Terraform plan. When running the command below, an execution plan is created as part of the process. Approve the plan when prompted. 
    ```
    terraform apply
    ```


### LICENSE

Provided under Cisco Sample Code License, for details see [LICENSE](LICENSE.md)

### CODE_OF_CONDUCT

Our code of conduct is available [here](CODE_OF_CONDUCT.md)

### CONTRIBUTING

See our contributing guidelines [here](CONTRIBUTING.md)

#### DISCLAIMER:
<b>Please note:</b> This script is meant for demo purposes only. All tools/ scripts in this repo are released for use "AS IS" without any warranties of any kind, including, but not limited to their installation, use, or performance. Any use of these scripts and tools is at your own risk. There is no guarantee that they have been through thorough testing in a comparable environment and we are not responsible for any damage or data loss incurred with their use.
You are responsible for reviewing and testing any scripts you run thoroughly before use in any non-testing environment.