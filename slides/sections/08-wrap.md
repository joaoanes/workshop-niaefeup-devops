---
layout: section
---

# 8. Wrap up

---

# This was a teaching stack, not production

<div class="grid grid-cols-2 gap-6 mt-4 text-sm">

<div>

### What we did (great for learning)

- Local Terraform state
- `null_resource` + `remote-exec`
- SSH open to `0.0.0.0/0`
- Server in `online-mode=false`
- World stored on the instance's disk
- No HTTPS / no certificates
- All 20 students in one AWS account

</div>

<div>

### What you'd do in production

- Remote state (S3 + DynamoDB locking)
- `user_data` / Packer / Ansible / configmgmt
- SSH only from a bastion or VPN
- Real Mojang auth, signed sessions
- EBS snapshots + offsite backups
- Caddy / nginx + Let's Encrypt
- One account per team, with SCPs

</div>

</div>

<VClicks>

- Every shortcut above was deliberate. Knowing the shortcut exists is half the battle.

</VClicks>

---

# What you can now do

<VClicks>

- Explain DevOps to someone without using the word "DevOps"
- Walk the request chain from a keystroke to a rendered page
- Provision a cloud VM with Terraform — from scratch, with state, with outputs
- Install software on it declaratively, with dependencies that survive replacement
- Point a domain at it via DNS
- Tear the whole thing down on demand

</VClicks>

---
layout: center
---

# Now: teardown. Together.

```bash
cd support/tf/minecraft && terraform destroy --var-file=tf.vars
```

<VClicks>

- Run it. Confirm with `yes`.
- I will run the IAM teardown after the session. Your credentials will be gone within the hour.

</VClicks>

---

# Topics we did not touch

<VClicks>

- **Containers / Docker** — packaging the app itself
- **CI/CD** — automating the build/test/deploy loop
- **Kubernetes** — orchestrating containers at scale
- **Observability** — Prometheus, Grafana, logs, traces
- **Secrets** — Vault, AWS Secrets Manager, sealed-secrets
- **Configuration management** — Ansible, Chef, Puppet
- **GitOps** — Git as the source of truth for infra

</VClicks>

<!-- Reused from devops-workshop/slides.md "Topics Not Covered" section -->

---
layout: center
class: text-center
---

# Thank you!

### Questions?

#### hi@joaoanes.website
