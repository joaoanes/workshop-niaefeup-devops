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

# Count the clicks

<VClicks>

- ~7 screens.
- ~3 dropdowns where the default is wrong.
- 1 download that you must not lose.
- 1 region selector that has bitten everyone who has ever used AWS.
- Repeat for every machine. Repeat after every mistake.

</VClicks>

---
layout: center
---

# Now imagine doing this for 50 machines.

## Or 500. Or every time a deploy fails.

---

# What we just learned

<VClicks>

- The console is **fine** for exploring.
- The console is **terrible** for repeating.
- Nothing we did is reviewable. No diff. No history. No teardown button that means it.
- This is exactly the problem **Infrastructure as Code** solves.

</VClicks>
