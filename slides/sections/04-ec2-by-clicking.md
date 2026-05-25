---
layout: section
---

# 4. Demo: EC2 the painful way

### Me clicking, you watching.

---

# What we are about to do

<VClicks>

- Open the AWS console → EC2 → Launch instance.
- Pick an AMI (Ubuntu 22.04).
- Pick an instance type (`t3.micro`).
- Generate a key pair, **download the `.pem`**, never lose it.
- Configure a security group: allow SSH (22), HTTP (80), HTTPS (443).
- Launch. Wait. Find the public IP. SSH in.

</VClicks>

<!--
LIVE DEMO. Don't pre-record. Make the mistakes. The mistakes are the point.
TODO: drop in screenshots once captured, or skip and do it all live.
-->

---
layout: fact
---

# 7 / 3 / 1 / 1

<div class="grid grid-cols-4 gap-4 text-sm text-center mt-6 max-w-3xl mx-auto">
<div>screens to click through</div>
<div>dropdowns where the default is wrong</div>
<div>download you cannot lose</div>
<div>region selector that has bitten everyone</div>
</div>

<div class="mt-8 text-base opacity-80">…repeat for every machine, every mistake, every time.</div>

---
layout: statement
---

# Now imagine doing this for 50 machines.

### Or 500. Or every time a deploy fails.

---
layout: statement
---

# Console for exploring. Code for repeating.

<div class="mt-6 text-base opacity-70">
Nothing we just did is reviewable. No diff. No history. No teardown button that means it.<br/>
That's exactly the problem <strong class="text-yellow-400">Infrastructure as Code</strong> solves.
</div>
