---
layout: section
---

# 3. Hosting & AWS access

---

# Where do we deploy?

### A server is just a computer that listens for requests. Almost always Linux.

<div class="grid grid-cols-3 gap-4 mt-6 text-sm">

<div class="rounded border border-yellow-500/30 p-4">

#### Your closet
A box you own and plug into your home network. Free-ish, but you eat the power bill, the noise, and the dynamic-IP problem.

</div>

<div class="rounded border border-yellow-500/30 p-4">

#### VPS
A slice of a big machine, sold by the hour. Cheap, flexible, what almost every small project uses. **Today's option.**

</div>

<div class="rounded border border-yellow-500/30 p-4">

#### Bare metal
A whole physical machine in someone else's datacenter. Expensive, fast, predictable.

</div>

</div>

<!-- Reused from devops-workshop/day1/2hosting.md -->

---

# Where to rent one?

<div class="grid grid-cols-2 gap-6 mt-4">

<div class="rounded border border-yellow-500/30 p-4">

### Hetzner / Scaleway / OVH
**Personal projects.** Cheap, raw, great value.

- Fewer nice APIs (limited Terraform support)
- Security model largely yours to implement
- Sparse integrations

</div>

<div class="rounded border border-yellow-500/30 p-4">

### AWS / Azure / GCP
**Anything serious.** Expensive, but every possible integration.

- Hundreds of products beyond hosting (DBs, queues, ML, identity, even satellites)
- Built-in IAM, monitoring, deploys
- What you'll see at work

</div>

</div>

<div class="text-center mt-6 text-lg">Today: <strong class="text-yellow-400">AWS</strong>.</div>

---

# How AWS rents you a server: EC2

<VClicks>

- **EC2** — Elastic Compute Cloud — is AWS's name for "rent a virtual server".
- **Instance types** — `t3.micro`, `m5.large`, `c7g.xlarge`… hundreds of them, tuned for CPU / memory / GPU / network / storage.
- **Pay only for what you use**: per-second billing, with options for **reserved** (long-term discount) or **spot** (cheap but interruptible) instances.
- Scale up (bigger instance) or out (more instances) on demand.
- That's the model. Today we rent one `t3.small` each, for a couple of hours.

</VClicks>

---

# Why this account lets you do anything: IAM

<VClicks>

- **IAM** — Identity and Access Management — decides **who can do what**.
- Every API call is checked: "can this user launch an EC2? in this region? with this tag?"
- The reason large teams can share one cloud account without stepping on each other.

</VClicks>

---
layout: center
---

# Your credentials

## We've generated IAM users for this workshop.

### Grab yours from the shared sheet:

<a href="https://docs.google.com/spreadsheets/d/1lU12SAphXJnN0eFz8DzUbNp965_mrTHePDDTJtqeTCM/edit?gid=1219591200#gid=1219591200" class="text-xl">
docs.google.com/spreadsheets/.../student-creds
</a>

Find your row, copy the access key + secret. The accounts have **limits set on them**, so don't worry about runaway bills.

---

# Setting up the CLI

### You already installed `awscli` in the prereqs. Now configure it.

<div class="grid grid-cols-3 gap-4 mt-4 text-sm">

<div>

#### macOS

```bash
aws configure
aws sts \
  get-caller-identity
```

</div>

<div>

#### Linux / WSL

```bash
aws configure
aws sts \
  get-caller-identity
```

</div>

<div>

#### Windows (native)

```powershell
aws configure
aws sts `
  get-caller-identity
```

</div>

</div>

<VClicks>

- `aws configure` prompts for your access key + secret. Paste from the sheet.
- `aws sts get-caller-identity` should print:
  ```json
  {
    "UserId":  "AIDA...",
    "Account": "305518020756",
    "Arn":     "arn:aws:iam::305518020756:user/student-7"
  }
  ```
- If you see your **own** ARN, you're configured for the wrong profile.

</VClicks>

<!-- Adapted from devops-workshop/day1/2hosting.md -->
