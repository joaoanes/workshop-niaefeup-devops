---
layout: section
---

# 8. Wrap up

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
