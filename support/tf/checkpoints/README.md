# Terraform checkpoints

Working states of the workshop Terraform config, at each major step.
If you fall behind during the live workshop, copy the next checkpoint and
keep going from there.

| Stage | What it has | When in the workshop |
|-------|-------------|----------------------|
| `stage-1-starter/`        | `terraform`, `provider`, variable. `init` works. | After the Terraform blocks slides |
| `stage-2-keys-and-sg/`    | + `random_pet`, `aws_key_pair`, `aws_security_group` | After the security group step |
| `stage-3-ec2/`            | + `aws_ami` data, `aws_instance`, `output`s | End of the Terraform section |
| `stage-4-minecraft/`      | + `null_resource` install of Spigot + Dynmap | End of the Minecraft section |

## Use

```bash
cp -r stage-N-name/ ~/my-workshop
cd ~/my-workshop
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars and paste your SSH public key
terraform init
terraform apply
```

Each stage uses `terraform.tfvars` (auto-loaded, no `--var-file` flag needed).
