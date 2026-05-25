---
layout: section
---

# 1. What is DevOps?

---

# Before DevOps

<VClicks>

- Devs wrote code; ops ran servers. Two tribes, one wall.
- Releases were events: a Friday night, a war room, a printed runbook.
- "Works on my machine" was a real defense.
- To ship a change, dev filed a ticket with ops. Ops scheduled it. The hand-off was slow because nobody owned both sides.
- The fastest way to deploy was to know somebody.

</VClicks>

<!--
TODO: anecdote — pick one war story (the Friday deploy that took the weekend).
-->

---

# The shift

<VClicks>

- **Google SRE (2003)**: treat ops as a software problem. Error budgets, SLOs, automation.
- **"You build it, you run it"** — Werner Vogels, Amazon, 2006. Devs own production.
- **The DevOps movement (2009)**: Patrick Debois coins "devopsdays". Culture + tools + practice.
- **Cloud (2006+)**: AWS makes infrastructure programmable. Suddenly servers can be code.
- **Containers (2013)**: Docker makes "works on my machine" portable.
- **The team boundary moves**: instead of dev → ops handoff, one team owns the whole loop.

</VClicks>

---

# The rise of CI/CD

<div class="grid grid-cols-2 gap-8 mt-4">

<div>

### CI — Continuous Integration

Every push is automatically built and tested. Breakage shows up in minutes, not weeks.

</div>

<div>

### CD — Continuous Delivery / Deployment

Every passing build is **ready to ship** (delivery) — or actually shipped, automatically (deployment).

</div>

</div>

<VClicks>

- Pre-CI/CD: integration was a quarterly event called "merge week" and everybody dreaded it.
- Post-CI/CD: the pipeline *is* the release process. Tests, security scans, deploys, rollbacks — scripted.
- The loop DevOps is built around. Today's tools (Terraform, cloud APIs) are pieces of it.

</VClicks>

---

# So what *is* DevOps?

<VClicks>

- It is **not** a job title (even though it is on a lot of business cards).
- It is **not** a tool.
- It **is** the practice of applying programming skill to the operational parts of running software.
- A DevOps person is a systems engineer who codes, or a developer who owns infrastructure.
- The point is **leverage**: automate the toil so you can ship more, more safely.

</VClicks>

---
layout: center
---

## It's really about

# keeping the application online

## and not setting your weekend on fire when it isn't

<!--
Reused/rewritten from devops-workshop/day1/0intro.md
-->

---

# Today's plan

<VClicks>

1. Talk about what happens when you type `google.com`
2. Get AWS keys
3. Click an EC2 into existence (the painful way)
4. Replace clicking with **Terraform**
5. Make the EC2 install a **Minecraft server + Dynmap** automatically
6. Point a **domain name** at it
7. Tear it all down

</VClicks>
