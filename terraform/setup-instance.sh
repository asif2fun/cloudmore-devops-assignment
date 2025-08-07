#!/bin/bash

apt update -y && apt upgrade -y              # Update system

curl -fsSL https://get.docker.com | sh       # Install Docker

usermod -aG docker asifadmin                 # Allow current user (asifadmin) to run Docker

apt install -y docker-compose-plugin         # Install Docker Compose plugin

apt install -y python3 python3-pip git curl  # Install Python 3, pip and dependencies

pip3 install requests flask                  # Install Python packages

git clone https://github.com/asifahmed-dev/cloudmore-devops-assignment.git /home/asifadmin/cloudmore-devops-assignment    # Clone your GitHub project (replace with your actual repo URL)

cd /home/asifadmin/cloudmore-devops-assignment     # Change to project directory

export OWM_API_KEY=your_real_openweathermap_key    # (Optional) Export API key if not using .env

docker compose up -d    # Start containers