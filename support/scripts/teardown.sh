#!/usr/bin/env bash
# End-of-workshop teardown. Runs Terraform destroy on every state we have.
# Intended to be safe to re-run; idempotent.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

echo "==> Destroying student Minecraft infra (if any)"
if [ -d "$ROOT/support/tf/minecraft" ] && [ -f "$ROOT/support/tf/minecraft/terraform.tfstate" ]; then
  ( cd "$ROOT/support/tf/minecraft" && terraform destroy -auto-approve ) || true
else
  echo "    (no state — skipping)"
fi

echo "==> Destroying student IAM users"
if [ -d "$ROOT/support/tf/iam-gen" ] && [ -f "$ROOT/support/tf/iam-gen/terraform.tfstate" ]; then
  ( cd "$ROOT/support/tf/iam-gen" && terraform destroy -auto-approve ) || true
else
  echo "    (no state — skipping)"
fi

echo "==> Done. Verify in the AWS console that nothing is left running."
echo "    Especially: EC2 instances, key pairs, security groups, IAM users."
