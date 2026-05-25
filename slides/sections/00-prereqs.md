---
layout: section
---

# 0. Before we start

### Make sure everyone has a working terminal and Terraform.

---

# What you need

<VClicks>

- A **terminal** — where you'll type commands.
- **Terraform** — the tool we'll use to provision infrastructure.
- The **AWS CLI** — to talk to AWS from your terminal.
- An **SSH key** (we'll generate one in the SSH keys slide if you don't have one).
- That's it. No IDE required. No cloud accounts to create.

</VClicks>

---

# Terminal: macOS

<VClicks>

- You already have one. Open **Terminal.app** (`⌘ + Space`, type "Terminal").
- Or install **iTerm2** if you want a nicer one: <https://iterm2.com>
- Verify:
  ```bash
  echo "hello"
  ```

</VClicks>

---

# Terminal: Linux

<VClicks>

- You already have one. Open whichever your distro gives you (GNOME Terminal, Konsole, Alacritty, etc.).
- Verify:
  ```bash
  echo "hello"
  ```

</VClicks>

---

# Terminal: Windows

<VClicks>

- Windows PowerShell technically works, but **we'll use WSL** (Windows Subsystem for Linux) so all the commands match the macOS/Linux ones.
- Install it once, from an Administrator PowerShell:
  ```powershell
  wsl --install
  ```
- This installs Ubuntu by default. Restart when prompted, then launch **Ubuntu** from the Start menu.
- From there on, you have a real Linux terminal. Everything in this workshop runs in there.

</VClicks>

---

# Installing Terraform

### Pick your OS.

---

# Terraform: macOS

```bash
brew install terraform
```

<VClicks>

- Don't have Homebrew? Install it first: <https://brew.sh>
- Verify:
  ```bash
  terraform -version
  ```
  You should see `Terraform v1.x.x`.

</VClicks>

---

# Terraform: Linux (and WSL)

```bash
sudo snap install terraform --classic
```

<VClicks>

- Verify:
  ```bash
  terraform -version
  ```
- No snap? Grab the binary from <https://developer.hashicorp.com/terraform/install> and drop it in `/usr/local/bin/`.

</VClicks>

---

# Terraform: Windows (no WSL)

<VClicks>

- If you really can't use WSL, use **Chocolatey** in PowerShell:
  ```powershell
  choco install terraform
  ```
- Or download the `.exe` directly: <https://developer.hashicorp.com/terraform/install>
- Add it to your `PATH`. Open a new PowerShell. Verify:
  ```powershell
  terraform -version
  ```
- **Strongly recommended**: use WSL instead. The rest of the workshop assumes a Unix shell.

</VClicks>

---

# Installing the AWS CLI

### Same idea — pick your OS.

---

# AWS CLI: macOS

```bash
brew install awscli
```

<VClicks>

- Verify:
  ```bash
  aws --version
  ```
  You should see `aws-cli/2.x.x`.

</VClicks>

---

# AWS CLI: Linux (and WSL)

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

<VClicks>

- `apt install awscli` works too, but ships an older v1. Use the bundled installer above for v2.
- Verify:
  ```bash
  aws --version
  ```

</VClicks>

---

# AWS CLI: Windows (no WSL)

<VClicks>

- Download the MSI: <https://awscli.amazonaws.com/AWSCLIV2.msi>
- Run it. Open a new PowerShell. Verify:
  ```powershell
  aws --version
  ```
- Or, again, just use WSL and follow the Linux instructions.

</VClicks>

---
layout: center
---

# Everyone has `terraform -version` and `aws --version` working?

### 👍 Good. Let's start.
