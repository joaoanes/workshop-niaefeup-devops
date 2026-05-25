---
layout: section
---

# 3. Hosting & AWS access

---

# Where do we deploy?

<VClicks>

- A **server** is just a computer that listens for requests and sends back data.
- Could be in your closet. Usually it's somebody else's closet.
- That computer almost always runs **Linux**. The one we'll rent today does too.
- **VPS** (Virtual Private Server): a slice of a big machine, sold by the hour. Cheap, flexible.
- **Bare metal**: a whole physical machine. Expensive, fast.

</VClicks>

<!-- Reused from devops-workshop/day1/2hosting.md -->

---

# Where to rent one?

<VClicks>

- Depends on **how much money you have** and **what your requirements are**.
- For personal projects: **Hetzner / Scaleway / OVH**. Cheap, raw, generally great value.
  - "Raw" doesn't mean closer to bare metal or less management. It means **fewer nice APIs** — provisioning with Terraform may be limited, the security model is largely yours to implement, integrations are sparse.
- For anything serious: **AWS / Azure / GCP**. The big three.
  - More expensive, but every possible integration. Hundreds of products beyond hosting.
  - They don't just sell you servers — they sell you everything an IT enterprise needs. Storage, databases, queues, ML, networking, identity. Even satellites (AWS Ground Station).
- Today: **AWS**, because the tooling and IAM story are what you'll see at work.

</VClicks>

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

- **IAM** — Identity and Access Management — is how AWS decides **who can do what**.
- Every API call is checked against a policy: "is this user allowed to launch an EC2? in this region? with this tag?".
- Roles, groups, policies, conditions — all composable. Fine-grained enough to scope by tag, by IP, by time of day.
- IAM is the part of AWS that makes the cloud usable by large teams without everyone stepping on each other.

</VClicks>

---
layout: center
---

# Your credentials

## We've generated IAM users for this workshop.

### Grab yours from the shared sheet:

<a href="https://docs.google.com/spreadsheets/d/REPLACE_ME" class="text-xl">
docs.google.com/spreadsheets/d/REPLACE_ME
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

- `aws configure` prompts for your access key + secret. Paste from the pen drive.
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
