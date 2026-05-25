# Proof: the full working stack

End-to-end working Terraform config for the workshop. This is the **reference
implementation**. The slides and checkpoint stages should mirror what's here.

## What it builds

- An Ubuntu 22.04 EC2 (`t3.small`) in `eu-west-1`
- A unique SSH key pair (using your laptop's public key)
- A security group (SSH 22, Minecraft 25565, Dynmap 8123)
- A `null_resource` that copies `install.sh` + `minecraft.service` to the box
  and runs the install
- A running PaperMC server with the Dynmap plugin, supervised by systemd

## Files

```
proof/
├── main.tf                  # providers, resources, null_resource provisioning
├── variables.tf             # input variables
├── outputs.tf               # ssh_command, minecraft_address, dynmap_url
├── install.sh               # the actual provisioning recipe (apt/wget/systemd)
├── minecraft.service        # systemd unit
└── terraform.tfvars.example # copy to terraform.tfvars and fill in
```

## Use

```bash
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars and paste your SSH public key
terraform init
terraform apply
terraform output ssh_command
```

When you're done:

```bash
terraform destroy
```

## Iterating on the install script

Edit `install.sh`, then re-run only the install (no instance replacement):

```bash
terraform apply -replace=null_resource.minecraft_install
```

The `triggers` block uses `filemd5(install.sh)` and `filemd5(minecraft.service)`,
so any edit to those files will also trigger a re-install on the next plain
`terraform apply`.
