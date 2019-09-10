#!/bin/bash

# Add Docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Install Nomad and Docker
apt-get update
apt-get install unzip docker-ce -y
wget https://releases.hashicorp.com/nomad/0.9.5/nomad_0.9.5_linux_amd64.zip
unzip nomad_0.9.5_linux_amd64.zip -d /usr/bin/

mkdir /etc/nomad
cat << EOF > /etc/nomad/settings.hcl
server {
  enabled          = true
  bootstrap_expect = 1
}

client {
  enabled          = true # supported, but only for demonstration purposes - use a separate client otherwise!
}

data_dir  = "/var/lib/nomad"
EOF

cat << EOF > /etc/systemd/system/nomad.service
[Unit]
Description=Nomad

[Service]
Type=simple
KillMode=process
ExecStart=/usr/bin/nomad agent -config /etc/nomad/settings.hcl

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start nomad.service