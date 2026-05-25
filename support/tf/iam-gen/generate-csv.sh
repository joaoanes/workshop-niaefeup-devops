#!/usr/bin/env bash
# Generates students.csv from terraform output.
# Run AFTER `terraform apply` in this directory.
#
# Output columns: username, access_key_id, secret_access_key
# This file contains secrets — do NOT commit it.

set -euo pipefail

cd "$(dirname "$0")"

if [ ! -f terraform.tfstate ]; then
  echo "error: terraform.tfstate not found — run 'terraform apply' here first" >&2
  exit 1
fi

OUT=students.csv

terraform output -json student_credentials \
  | python3 -c "
import json, sys, csv
data = json.load(sys.stdin)
w = csv.writer(sys.stdout)
w.writerow(['username', 'access_key_id', 'secret_access_key'])
for row in data:
    w.writerow([row['username'], row['access_key'], row['secret_key']])
" > "$OUT"

count=$(($(wc -l < "$OUT") - 1))
echo "wrote $count credentials to $OUT"
echo "next: paste the contents into the workshop Google Sheet (see slide §3)"
