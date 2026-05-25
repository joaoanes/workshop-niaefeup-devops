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

<div class="flex flex-col gap-3 mt-4 text-sm">

<div class="flex gap-4 items-start">
<div class="font-mono text-yellow-400 w-20 shrink-0 text-right pt-1">2003</div>
<div><strong>Google SRE</strong> — treat ops as a software problem. Error budgets, SLOs, automation.</div>
</div>

<div class="flex gap-4 items-start">
<div class="font-mono text-yellow-400 w-20 shrink-0 text-right pt-1">2006</div>
<div><strong>AWS launches.</strong> Werner Vogels says "<em>you build it, you run it.</em>" Servers become an API call.</div>
</div>

<div class="flex gap-4 items-start">
<div class="font-mono text-yellow-400 w-20 shrink-0 text-right pt-1">2009</div>
<div><strong>devopsdays</strong> — Patrick Debois coins the name. Culture + tools + practice.</div>
</div>

<div class="flex gap-4 items-start">
<div class="font-mono text-yellow-400 w-20 shrink-0 text-right pt-1">2013</div>
<div><strong>Docker.</strong> "Works on my machine" becomes portable.</div>
</div>

<div class="flex gap-4 items-start">
<div class="font-mono text-yellow-400 w-20 shrink-0 text-right pt-1">today</div>
<div>One team owns the whole loop. No more dev → ops handoff.</div>
</div>

</div>

---
layout: quote
---

# "You build it, you run it."

### — Werner Vogels, CTO of Amazon, 2006

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

<div class="mt-8 space-y-6 text-2xl">

<div><span class="opacity-60">Not</span> a job title.</div>

<div v-click><span class="opacity-60">Not</span> a tool.</div>

<div v-click class="text-yellow-400"><strong>The practice of applying programming skill to operational toil.</strong></div>

<div v-click class="text-sm opacity-70 pt-4">
A systems engineer who codes, or a developer who owns infrastructure. The point is leverage — automate the toil so you ship more, more safely.
</div>

</div>

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
5. Make the EC2 install a **Minecraft server + BlueMap** automatically
6. Point a **domain name** at it
7. Tear it all down

</VClicks>
