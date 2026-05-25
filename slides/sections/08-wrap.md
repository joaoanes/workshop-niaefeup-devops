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

<div class="space-y-3 mt-6 text-base">

<div class="flex gap-3"><span class="text-yellow-400 font-bold">✓</span><span>Explain DevOps to someone without using the word "DevOps"</span></div>

<div class="flex gap-3" v-click><span class="text-yellow-400 font-bold">✓</span><span>Walk the request chain from a keystroke to a rendered page</span></div>

<div class="flex gap-3" v-click><span class="text-yellow-400 font-bold">✓</span><span>Provision a cloud VM with Terraform — from scratch, with state, with outputs</span></div>

<div class="flex gap-3" v-click><span class="text-yellow-400 font-bold">✓</span><span>Install software on it declaratively, with dependencies that survive replacement</span></div>

<div class="flex gap-3" v-click><span class="text-yellow-400 font-bold">✓</span><span>Point a domain at it via DNS</span></div>

<div class="flex gap-3" v-click><span class="text-yellow-400 font-bold">✓</span><span>Tear the whole thing down on demand</span></div>

</div>

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

<div class="grid grid-cols-3 gap-3 mt-6 text-xs">

<div class="rounded border border-yellow-500/30 p-3">

#### 🐳 Containers / Docker
Packaging the app itself.

</div>

<div class="rounded border border-yellow-500/30 p-3">

#### 🔁 CI/CD
Automating build → test → deploy.

</div>

<div class="rounded border border-yellow-500/30 p-3">

#### ☸️ Kubernetes
Orchestrating containers at scale.

</div>

<div class="rounded border border-yellow-500/30 p-3">

#### 👁️ Observability
Prometheus, Grafana, logs, traces.

</div>

<div class="rounded border border-yellow-500/30 p-3">

#### 🔐 Secrets
Vault, AWS Secrets Manager, sealed-secrets.

</div>

<div class="rounded border border-yellow-500/30 p-3">

#### 📜 Config management
Ansible, Chef, Puppet.

</div>

<div class="rounded border border-yellow-500/30 p-3 col-span-3">

#### ⚙️ GitOps
Git as the source of truth for infrastructure (Flux, ArgoCD).

</div>

</div>

<!-- Reused from devops-workshop/slides.md "Topics Not Covered" section -->

---
layout: center
class: text-center
---

# Thank you!

### Questions?

#### hi@joaoanes.website
