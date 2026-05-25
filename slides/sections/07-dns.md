---
layout: section
---

# 7. DNS

---

# We have a server. It's an IP. That feels wrong.

<VClicks>

- `54.234.118.42` is hard to remember, hard to type, hard to share.
- IPs change when machines change. Names don't have to.
- We want: `mine.yourdomain.tld` → our box.

</VClicks>

<!-- Reused from devops-workshop/day2/5dns.md -->

---

# Quick recap (we covered this in section 2)

<VClicks>

- A **registrar** (Namecheap, Cloudflare, Porkbun…) leases you a name.
- **NS records** at the registry point to nameservers.
- The nameserver holds your **A** records (→ IPv4), **CNAMEs** (→ another name), etc.
- Today we just need one A record pointing your name at the EC2 IP.

</VClicks>

---

# For today

```
Type:  A
Name:  mine
Host:  mine.yourdomain.tld
Value: 54.234.118.42     # our EC2's public IP
TTL:   60                # short, so propagation is fast for the demo
```

<VClicks>

- We use **A** (not CNAME) because we have a raw IP.
- If AWS gave us a hostname like `ec2-54-...amazonaws.com`, **CNAME** would be the right call.

</VClicks>

---
layout: center
---

# 🎬 Live demo

## Namecheap dashboard → add record → wait → connect.

<!--
Demo flow:
1. Show Namecheap "Advanced DNS" tab.
2. Add A record: host=mine, value=<EC2 IP>, TTL=60.
3. `dig mine.yourdomain.tld` from terminal — watch it resolve.
4. Connect in Minecraft client by name.
5. Open Dynmap via http://mine.yourdomain.tld:8123.
-->

---

# Propagation

<VClicks>

- DNS is **cached**. Everywhere. At every layer.
- Old TTL says how long old caches will hold on.
- New record propagates as fast as TTLs expire — seconds at TTL=60, days at TTL=86400.
- Modern registrars push updates fast, often within seconds, but you can't rely on it.

</VClicks>

---

# Verifying

```bash
dig mine.yourdomain.tld          # what your resolver thinks
dig @8.8.8.8 mine.yourdomain.tld # what Google's resolver thinks
dig +trace mine.yourdomain.tld   # walk the full chain
```

<VClicks>

- `dig` is the only DNS tool you ever need. Learn it.
- If `dig +trace` shows the right answer but your browser doesn't: it's a cache. Wait, or flush.

</VClicks>

---

# What about HTTPS?

<VClicks>

- Once you have a domain, you can get a **certificate** for it.
- **Let's Encrypt** is free and automated. **Certbot** is the standard client. **Caddy** does it transparently.
- Out of scope today, but: this is the path to a "real" production server.

</VClicks>

<!-- Hooks into devops-workshop/day2/5dns.md Certbot/Caddy material if there's time. -->

---
layout: statement
---

# You did the whole loop.

### Code → machine → installed software → name on the internet.
