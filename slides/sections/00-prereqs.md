---
layout: section
---

# 0. Before we start

### Make sure everyone has a working terminal and Terraform.

---

# What you need

<div class="grid grid-cols-2 gap-4 mt-6">

<div class="rounded border border-yellow-500/30 p-4">

### Terminal
Where you type commands. macOS and Linux have one; Windows users install WSL.

</div>

<div class="rounded border border-yellow-500/30 p-4">

### Terraform
The tool we'll use to provision infrastructure.

</div>

<div class="rounded border border-yellow-500/30 p-4">

### AWS CLI
To talk to AWS from your terminal.

</div>

<div class="rounded border border-yellow-500/30 p-4">

### SSH key
For logging into the EC2. We'll generate one if you don't have it.

</div>

</div>

<div class="text-sm opacity-70 mt-4">No IDE required. No cloud accounts to create.</div>

---

# Getting a terminal

<div class="grid grid-cols-3 gap-4 mt-4 text-sm">

<div>

#### macOS

Open **Terminal.app** (`⌘ + Space`, "Terminal").

```bash
echo "hello"
```

Want nicer? <https://iterm2.com>

</div>

<div>

#### Linux

You already have one — GNOME Terminal, Konsole, Alacritty, whatever your distro ships.

```bash
echo "hello"
```

</div>

<div>

#### Windows

Install **WSL** (Windows Subsystem for Linux) so commands match macOS/Linux.

```powershell
wsl --install
```

Restart, then launch **Ubuntu** from Start. Everything from here on runs in there.

</div>

</div>

---

# Installing Terraform

<div class="grid grid-cols-3 gap-4 mt-4 text-sm">

<div>

#### macOS

```bash
brew install terraform
```

No Homebrew? <https://brew.sh>

</div>

<div>

#### Linux / WSL

```bash
sudo snap install \
  terraform --classic
```

No snap? Grab the binary from <https://developer.hashicorp.com/terraform/install>.

</div>

<div>

#### Windows (no WSL)

```powershell
choco install terraform
```

Or download the `.exe` from terraform.io.

</div>

</div>

<div class="mt-4 text-sm">Verify with <code>terraform -version</code> — you should see <code>Terraform v1.x.x</code>.</div>

---

# Installing the AWS CLI

<div class="grid grid-cols-3 gap-4 mt-4 text-sm">

<div>

#### macOS

```bash
brew install awscli
```

</div>

<div>

#### Linux / WSL

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
  -o awscliv2.zip
unzip awscliv2.zip
sudo ./aws/install
```

(<code>apt install awscli</code> ships an older v1 — prefer the bundled installer.)

</div>

<div>

#### Windows (no WSL)

Download the MSI:

<https://awscli.amazonaws.com/AWSCLIV2.msi>

Run it. Open a fresh PowerShell.

</div>

</div>

<div class="mt-4 text-sm">Verify with <code>aws --version</code> — you should see <code>aws-cli/2.x.x</code>.</div>

---
layout: center
---

# Everyone has `terraform -version` and `aws --version` working?

### 👍 Good. Let's start.
