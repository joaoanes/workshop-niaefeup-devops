# Student IAM generator

Creates 20 EC2-locked IAM users for the workshop. Each user gets an access key.

## Use

```bash
terraform init
terraform apply
terraform output -json student_credentials > creds.json
```

`creds.json` is sensitive — gitignore it, hand keys out 1:1, then delete.

## Teardown

```bash
terraform destroy
```

Or use the global `support/scripts/teardown.sh`.
