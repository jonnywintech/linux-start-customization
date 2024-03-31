#!/bin/bash

sudo apt-get update
sudo apt-get install ca-certificates curl systemctl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

VERSION_STRING=5:24.0.0-1~ubuntu.22.04~jammy
sudo apt-get install docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin docker-compose-plugin

sudo service docker start

sudo usermod -aG docker $USER

# Start Docker service
if sudo service docker status >/dev/null 2>&1; then
    echo "Docker service is already running."
else
    echo "Starting Docker service..."
    sudo service docker start
    if [ $? -eq 0 ]; then
        echo "Docker service started successfully."
    else
        echo "Failed to start Docker service."
        exit 1
    fi
fi

sleep 5

echo "All looking good, installing portainer now"

sudo docker volume create portainer_data
sudo docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

echo "Relog to run docker commands without sudo"

# Keep the script running for a while
newgrp docker
sleep 10
