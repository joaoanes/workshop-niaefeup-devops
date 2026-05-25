---
layout: section
---

# 6. Provisioning: Minecraft + Dynmap

---

# We have a server. What does that mean?

<VClicks>

- A real, running Linux machine sitting in an AWS datacenter in Ireland.
- It has a public IP. It accepts SSH on port 22 (we opened that in the security group).
- It knows about your public key (we uploaded that via `aws_key_pair`).
- Which means: we can log into it right now, from your laptop, as if it were on your desk.

</VClicks>

---

# Let's SSH in

```bash
# Easiest — Terraform printed the command for you
terraform output -raw ssh_command | bash

# Or do it by hand
ssh ubuntu@$(terraform output -raw instance_public_ip)
```

<VClicks>

- First time, SSH asks "are you sure?" — yes, you are.
- You should see something like `ubuntu@ip-10-0-1-23:~$`. You are inside the EC2.
- The shell looks exactly like a normal Ubuntu terminal because **it is one**. There's no magic; it's just a remote computer.

</VClicks>

---

# You're in. A quick terminal tour

```bash
pwd                # where am I?           /home/ubuntu
ls -la             # what's here?
whoami             # who am I?             ubuntu
uname -a           # what OS am I on?      Linux ... Ubuntu 22.04 ...
cat /etc/os-release
df -h              # disk usage
free -h            # memory
top                # processes (q to quit)
sudo apt update    # run something as root
exit               # back to your laptop
```

<VClicks>

- These are the same commands you'd type on a Linux laptop. Nothing about it being remote changes the shell.
- `sudo` runs a command as root — needed to install software.
- `exit` (or Ctrl+D) drops you back on your own machine.

</VClicks>

---

# Could we install Minecraft by hand from here?

<VClicks>

- Absolutely. SSH in, `apt install java`, download the server JAR, run it.
- For 1 server, that's fine. For 20 students all doing it slightly differently, with no record of what was done — that's not fine.
- We want it **scripted, repeatable, and re-runnable**. Same input, same output.
- That's what provisioning means.

</VClicks>

---

# What we actually need to install

<VClicks>

- **Java 21** — the Minecraft server is a Java program. Ubuntu doesn't ship with it.
- **The server JAR** — we'll use **PaperMC** (a Spigot-compatible server, faster and easier to distribute).
- **EULA acceptance** — Mojang requires you to `echo eula=true > eula.txt` before the server will boot.
- **The Dynmap plugin JAR** — dropped into a `plugins/` folder next to the server.
- **A way to keep it running** — if we just launch it, it dies when SSH disconnects. We need a **systemd service**.

</VClicks>

---

# Step by step: the commands

```bash
# 1. Java
sudo apt-get update -y
sudo apt-get install -y openjdk-21-jre-headless wget

# 2. A home for the server
sudo mkdir -p /opt/minecraft/plugins
sudo chown -R ubuntu:ubuntu /opt/minecraft

# 3. Download the server and the plugin
wget -qO /opt/minecraft/server.jar       <PAPERMC_URL>
wget -qO /opt/minecraft/plugins/Dynmap.jar <DYNMAP_URL>

# 4. Accept the EULA
echo 'eula=true' > /opt/minecraft/eula.txt
```

<VClicks>

- That's the whole install. Nothing exotic — `apt`, `wget`, a couple of files.
- We still need to **start it**, and make sure it survives reboots.

</VClicks>

---

# Wrapping it in a systemd service

```ini
[Unit]
Description=Minecraft Server
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/opt/minecraft
ExecStart=/usr/bin/java -Xmx1500M -Xms1500M -jar server.jar nogui
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
```

<VClicks>

- Write this to `/etc/systemd/system/minecraft.service`.
- `sudo systemctl daemon-reload && sudo systemctl enable --now minecraft.service`.
- Now the server starts at boot, restarts on crash, and runs detached from any shell.
- This is how Linux runs every long-lived service: ssh, nginx, postgres, your app.

</VClicks>

---

# Now: do all that, from Terraform

<VClicks>

- We have a recipe. ~10 shell commands plus a systemd unit.
- Running them by hand on 20 servers is exactly the toil we've been trying to avoid.
- Terraform has a mechanism for this: provisioners attached to a resource.
- We'll wrap our recipe in a `null_resource` so it runs once the EC2 exists, and **re-runs cleanly** when we want to iterate.

</VClicks>

---

# `null_resource` and provisioners

<VClicks>

- A `null_resource` is a Terraform resource that does nothing on its own.
- But it has **provisioners** — `remote-exec`, `local-exec`, `file` — that run commands.
- With `depends_on`, you tie it to the EC2 so it runs **after** the box exists.
- With `triggers`, you tell Terraform when to re-run it.

</VClicks>

---

# The install resource

```hcl {maxHeight:'400px'}
resource "null_resource" "minecraft_install" {
  depends_on = [aws_instance.student_instance]

  triggers = {
    instance_id = aws_instance.student_instance.id
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = aws_instance.student_instance.public_ip
    private_key = file("~/.ssh/id_ed25519")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y openjdk-21-jre-headless wget unzip",
      "mkdir -p ~/mc && cd ~/mc",
      "wget -O spigot.jar https://example.invalid/spigot-1.21.jar",       # TODO: real URL or BuildTools
      "echo 'eula=true' > eula.txt",
      "mkdir -p plugins",
      "wget -O plugins/Dynmap.jar https://dev.bukkit.org/.../Dynmap.jar",  # TODO: pin a version
      "nohup java -Xmx1500M -jar spigot.jar nogui > server.log 2>&1 &",
      "sleep 5"
    ]
  }
}
```

<!--
TODO: replace the placeholder URLs.
- Spigot: build via BuildTools at provision time OR mirror a JAR somewhere we control.
- Dynmap: pin a specific release URL from dev.bukkit.org / modrinth.
-->

---

# The dependency story

<VClicks>

- `depends_on = [aws_instance.student_instance]` — wait for the box.
- `triggers = { instance_id = ... }` — if the instance is **replaced**, re-run the install.
- This is the killer feature: replace the machine, and the install re-runs automatically. No drift.

</VClicks>

---

# Try it: break it on purpose

<VClicks>

- `terraform apply -replace=aws_instance.student_instance`
- Terraform destroys and recreates the instance.
- Because `null_resource.minecraft_install` depends on `instance_id`, it **also** reruns.
- One command, fully rebuilt server.
- (Older docs use `terraform taint` — same idea, now deprecated in favour of `-replace`.)

</VClicks>

---

# Or just rerun the install

<VClicks>

- Don't want a new machine, just a fresh install? Tweak the script and:
  ```bash
  terraform apply -replace=null_resource.minecraft_install
  ```
- Same EC2, same IP, same security group. New Minecraft.
- This is the thing `user_data` cannot do.

</VClicks>

---

# Why not `user_data`?

<VClicks>

- EC2 has a `user_data` field — a script the box runs once, on first boot. Looks simpler:
  ```hcl
  resource "aws_instance" "student_instance" {
    user_data = file("${path.module}/install.sh")
  }
  ```
- It's a fine pattern. A lot of production code uses it. But for **today** we deliberately chose `null_resource` instead.

</VClicks>

---

# The case for `null_resource`

<VClicks>

- **`user_data` fails invisibly** — script runs on the box, errors land in `/var/log/cloud-init-output.log`. Terraform shrugs and reports success.
- **`null_resource` fails loudly** — `remote-exec` runs in Terraform's foreground. You see every command and every error.
- **`user_data` runs once** — change the script, no re-run, you'd have to replace the instance.
- **`null_resource` re-runs on demand** — `terraform apply -replace=null_resource.minecraft_install`, same box, fresh install.

</VClicks>

---
layout: center
---

# 🚀 Connect to the server

```
Minecraft → Multiplayer → Add Server → <your-public-ip>:25565
```

## And open the Dynmap

```
http://<your-public-ip>:8123
```

---

# What we just did

<VClicks>

- Declared a machine.
- Declared what should be on it.
- Declared the dependency between them.
- Terraform handles ordering, replacement, teardown.
- This is **declarative provisioning**. The whole point.

</VClicks>
