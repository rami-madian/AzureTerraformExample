# Module Overview

- The `./main.tf` module provisions three Azure windows virtual machines and a key vault.
- All the input parameters defined in `./variables.tf` have default reasonable values that be easily overridden when required.
- The default Admin user name for all the 3 VMs is `vmAdmin`
- The default Admin password for all the 3 VMs is a similar random password with a suffix of 0, 1, and 2 respectively.
- The `./main.tf` module produces a list of 3 json objects as an output in the following format:

```hcl-terraform
vm = [
  {
    "admin_password" = <...>
    "admin_username" = <...>
    "id" = <...>
    "identity_id" = "<...>
  },
  {
    "admin_password" = <...>
    "admin_username" = <...>
    "id" = <...>
    "identity_id" = "<...>
  },
  {
    "admin_password" = <...>
    "admin_username" = <...>
    "id" = <...>
    "identity_id" = "<...>
  },
]
```
- Each object in the above list displays the admin username/password, id and identity_id for each VM.

## Deployment Process

### Prerequisites
- Terraform (the code is tested using v0.12.28)
- Azure CLI for your environment (Mac, Linux, Windows etc...)
- A MS Azure account

1- First step is to login to your Azure account `az login`

2- Complete the login process on your browser.

3- Optional: Switch to a specific subscription if you have many `az account set --subscription <subscriptionXYZ>`

4- `terraform init`, `plan` and finally `apply`

5- You should get an output like this:

```hcl-terraform
vm = [
  {
    "admin_password" = "random-password-0"
    "admin_username" = "vmAdmin"
    "id" = "/subscriptions/<Your Subscription ID>/resourceGroups/ApplicationRG/providers/Microsoft.Compute/virtualMachines/app-vm-0"
    "identity_id" = "....."
  },
  {
    "admin_password" = "random-password-1"
    "admin_username" = "vmAdmin"
    "id" = "/subscriptions/<Your Subscription ID>/resourceGroups/ApplicationRG/providers/Microsoft.Compute/virtualMachines/app-vm-1"
    "identity_id" = "....."
  },
  {
    "admin_password" = "random-password-2"
    "admin_username" = "vmAdmin"
    "id" = "/subscriptions/<Your Subscription ID>/resourceGroups/ApplicationRG/providers/Microsoft.Compute/virtualMachines/app-vm-2"
    "identity_id" = "....."
  }
]

```

## Extras:

#### Gitlab pipeline for deployment to a Terraform Cloud workspace

- A Gitlab pipeline can be built using Gitlab Actions.
- There is already a workflow available on Github named `Terraform` that can be used for this purpose.

#### Pipeline tests

- We can add basic tests to verify the success or failure of the pipeline.
- As a primary step, we must verify the success of the `Terraform Apply` step.
- Next we can use Azure cli (We need to install it on the agent first) to query the status/properties for our resources
- For example we can retrieve the VM object IDs then verify that these values exist in the Azure Key Vault Access Policy.

#### Any improvements to the modules

- I had to introduce a dynamic block for the Key Vault Access Policy that to grant the VMs the required list of permissions.

```hcl-terraform
  dynamic "access_policy" {
    for_each = var.object_ids
    content {
      tenant_id           = var.tenant_id
      object_id           = access_policy.value

      key_permissions     = var.key_permissions
      secret_permissions  = var.secret_permissions
      storage_permissions = var.storage_permissions
    }
  }
```

