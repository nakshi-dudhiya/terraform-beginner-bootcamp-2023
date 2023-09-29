# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilizr semantic versioning for its tagging.
[semver.org](https://semver.org/)


The general format:

 **MAJOR.MINOR.PATCH**, eg `1.0.1`:

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So, we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distributions

This project is built against ubuntu.
Please consider checking your Linux Distribution and change according to your distribution needs

[How to check OS version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example:

```
gitpod /workspace/terraform-beginner-bootcamp-2023 (3-refactor-terraform-cli) $ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues, we noticed that bash scripts steps were a considerable amount code. Son we decided to create a bash script to install the Terraform CLI.

This bash script is located here : [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) Tidy
- This allow us an easier to debug and execute manually Terraform CLI install

#### Shebang Considerations

A Shebang (prounounced as Sha-bang) tells the bash script what program that will interpret the script. eg. `#!/bin/bash`

Recommended Format : `#!/usr/bin/bash`

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

When ececuting the bash script we can use the `./` shorthand notation to execute the bash script.

eg . `./bin/install_terraform_cli`

If we are using a script in gitpod.yml,  we need to point the script to a program to interpret it.

eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permissions for the fix to be executable at the user mode.

``` sh
chmod u+x ./bin/install_terraform_cli
```
Alternatively: 

```sh
chmod 774 ./bin/install_terraform_cli
```
https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks


### Working with Env Vars

 We can list out all Environment Variable (Env Vars) using the `env` command.

 We can filter specific env vars using grep eg. `env | grep AWS_`

 #### Setting and Unsetting Env Vars

 In the terminal, we can set using `export GREETING='HELLO WORLD'`

 In the terminal, we can unset using `unset GREETING`

 We can set an env var temporarily when just running a command.

 Eg:
 ```sh
 GREETING='HELLO WORLD' ./bin/print_message
 ```

Within a bash script, we can set env without writing export.
Eg:

```sh
#!/usr/bin/bash
GREETING='Hello World'

echo $GREETING
```
#### PRINTING Env Vars

We can print an env var using echo eg. `echo $GREETING`

#### Scoping Env Vars

When you open up new bash terminals in VSCOde, it will not be aware of env vars that you have set in another window.

If you want Env Vars to persist across all future bash terminals that are open, you need to set vars in your bash profile. eg. `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars in gitpod by storing them in Gitpod Secrets Storage.

```
gp env GREETING='Hello World'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml` but this can oly contain non-sensitive env vars.


### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```

If it is successfull, you should see a JSON payload return as follows:

```json
gitpod /workspace/terraform-beginner-bootcamp-2023 (7-refactor-aws-cli-script) $ aws sts get-caller-identity
{
    "UserId": "AIDAUSERTESTTEST12345",
    "Account": "999998888877",
    "Arn": "arn:aws:iam::999998888877:user/Ncodes"
}
```
We will need to generate AWS CLI credits from IAM User in order to use the AWS CLI.

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which located at registry. [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow to create resources in terraform.

- **Modules** are a way to make large amount of terraform code modular, portable and sharable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/)

## Terraform Console

We can see a list of all the terraform commands using `terraform` command.

#### Terraform Init

At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we will use. 

#### Terraform Plan

`terraform plan`

This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be executed by terraform.
Apply should prompt us yes or no.

To automatically approve an apply, use the command `terraform apply --auto-approve`

#### Terraform Destroy

The `terraform destroy` is used to destroy the resources.
You can also use the auto approve for destroy. eg. `terraform destroy --auto-approve`

#### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform Lock File **should be commited** to your Version Control System (VCS) eg. Github

#### Terraform State Files

`terraform.tfstate` constains information about the current state of your infrastructure

This file **should not be commited** to your VCS. 

This file may contain sensitive data. 

If you lose this file, you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

#### Terraform Directory

`.terraform` directory contains binaries of terraform providers.


## Things to Remember

- Do not forget to check the naming rules for S3 bucket while creating a bucket using Terraform.