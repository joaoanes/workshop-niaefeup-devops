#!/usr/bin/env bash
# Provisioning script for the workshop Minecraft + BlueMap server.
# Copied to the EC2 by Terraform's `file` provisioner, then executed
# via `remote-exec`. Idempotent enough to be re-run safely.

set -euxo pipefail

# Wait for cloud-init so apt doesn't fight with the initial Ubuntu setup.
cloud-init status --wait || true

# Add 2GB of swap. t3.small only has 2GB RAM and Java + apt can outrun it.
if [ ! -f /swapfile ]; then
  sudo fallocate -l 2G /swapfile
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile
  sudo swapon /swapfile
  echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
fi

# Java 21 + wget.
sudo apt-get update -y
sudo apt-get install -y openjdk-21-jre-headless wget

# Make a home for the server.
sudo mkdir -p /opt/minecraft/plugins/BlueMap
sudo chown -R ubuntu:ubuntu /opt/minecraft

# Latest PaperMC for MC 1.21.11.
wget -qO /opt/minecraft/server.jar \
  "https://api.papermc.io/v2/projects/paper/versions/1.21.11/builds/69/downloads/paper-1.21.11-69.jar"

# BlueMap 5.16 for Paper.
wget -qO /opt/minecraft/plugins/BlueMap.jar \
  "https://cdn.modrinth.com/data/swbUV1cr/versions/Vb2ZE8bR/bluemap-5.16-paper.jar"

# Pre-accept BlueMap's asset download — otherwise the plugin refuses to render
# on first run and prints "accept-download is set to false".
cat > /opt/minecraft/plugins/BlueMap/core.conf <<'EOF'
accept-download: true
metrics: false
EOF

# Mojang EULA.
echo 'eula=true' > /opt/minecraft/eula.txt

# Workshop server: turn off Mojang auth so anyone can connect (cracked / test
# accounts / borrowed launchers). If the file already exists (re-run), edit in
# place so we don't lose Minecraft's other generated defaults.
if [ -f /opt/minecraft/server.properties ]; then
  sudo -u ubuntu sed -i \
    -e 's/^online-mode=.*/online-mode=false/' \
    -e 's/^enforce-secure-profile=.*/enforce-secure-profile=false/' \
    /opt/minecraft/server.properties
else
  cat > /opt/minecraft/server.properties <<'EOF'
online-mode=false
enforce-secure-profile=false
EOF
fi

# Install the systemd unit (delivered by Terraform's `file` provisioner to /tmp).
sudo mv /tmp/minecraft.service /etc/systemd/system/minecraft.service
sudo systemctl daemon-reload
sudo systemctl enable minecraft.service
sudo systemctl restart minecraft.service

echo "Provisioning complete. Server is starting up; world generation + BlueMap render may take a couple of minutes."
