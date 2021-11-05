# gcp-terraform-ansible-example

A simple example of terraform and ansible usage in Google Cloud Platform context

## Terraform

Terraform is an open-source sofware tool designed to handle Infrastructure as Code (IaC) created by HashiCorp ([https://www.hashicorp.com/](https://www.hashicorp.com/)). The infrastructure is described using HashiCorp Configuration Language (HCL). [Learn more on Terraform documentation](https://www.terraform.io/docs/index.html)

## Ansible

Ansible is an open-source software tool designed to manage configuration and application-deployment (Kind of Infrastructure as Code). Ansible was written by Michael DeHaan and acquired by Red Hat in 2015. I can configure Unix systems as well as Microsoft Windows. YAML is used to describe system configuration.

Ansible is agentless and temporarily connects remotely via SSH or Windows Remote Management to do its tasks. [Learn more on Ansible documentation](https://docs.ansible.com/ansible/latest/)

## Terraform or Ansible ?

Terraform and Ansible are complimentary tools. Terraform helps in the definition and the creation of the infrastructure, Ansible configures and deploys software on the infrastructure created using Terraform (or not).

It's possible to run Ansible from Terraform using a `local-exec` provisioner ([See more on the documentation](https://www.terraform.io/docs/language/resources/provisioners/local-exec.html)). Nonetheless our goal is to discover both tools so we will run them separately.

## What are we doing ?

Using Terraform this example will lead you to deploy two [Compute Engines](https://cloud.google.com/compute) (virtual machines) on Google Cloud Platform.

One will be located in the region us-central zone us-central1-c (Council Bluffs, Iowa, North America) and the second one in the region europe-west zone europe-west1-b (St. Ghislain, Belgium, Europe). More on : [Google Cloud Regions and Zones](https://cloud.google.com/compute/docs/regions-zones).

Those virtual machines will host the same ssh key and will share a same VPC (but within different sub-networks). See [GCP VCP Documentation](https://cloud.google.com/vpc/docs/vpc).


A firewall rule with be deployed to only authorize SSH connections from the terraform host IP (not really a good idea is a real usage, were are doing it as a technical example).

Another firewall rule will authorize connections on the port 80 (HTTP Protocol) to machines tagged with `allow-http`.

The second step will be the Ansible execution to install the latest version Apache Server Web, replace the default apache page by our custom page then change an information on this page to differentiate the two machines.

## Terraform : structure explanation

The terraform folder contains the following files :

- `main.tf` : The main definition which contains the description of the two virtual machines, firewall rules and project-scoped ssh key.
- `outputs.tf` : Defines the final output of the terraform execution
- `terraform.tfvars.tpl` : A file to complete (it contains our variable), to rename as `terraform.tfvars` and to place in the (see below) credential folder.

A folder credentials is ignored thanks to the .gitignore file to let you store your credentials (GCP key, SSH keys, terraform.tfvars) and avoid a commit accident.

## Ansible : structure explanation

The ansible folder contains the following files :

- `playbook.yml` : The Ansible playbook (see documentation) we will run to executes tasks.
- `hosts.tpl` : A file to complete and rename as `hosts` which contains the ansible username (see Terraform ssh key configuration), the path 
- `ansible.cfg` : A ini config which indicates that hosts are in the `hosts` file.
- the `www` folder

## Credits

### HTML template

The HTML template used to differentiate VM1 and VM2 is based on Tobias Ahlin work : [https://tobiasahlin.com/moving-letters/](https://tobiasahlin.com/moving-letters/)
