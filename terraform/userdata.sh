#!/bin/bash

# Install Docker
sudo dnf update -y

echo "🔄 Installing Docker on Amazon Linux 2023..."

echo "📦 Installing Docker via dnf..."
sudo dnf install -y docker

echo "▶️ Enabling and starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

mkdir -p /home/ec2-user/app

# Pull and run the container
cd /home/ec2-user/app  # <-- assuming this is where your app code is copied

sudo dnf install -y git # Install git to clone the repository

echo "cloning the repository..."
sudo git clone https://github.com/kaushal-coder-sw/devops-portfolio-cicd.git

if [ $? -ne 0 ]; then
  echo "❌ Failed to clone repository. Exiting..."
  exit 1
fi

cd devops-portfolio-cicd

echo "🐳 Building Docker image..."
sudo docker build -t portfolio .

sleep 10

if [ $? -ne 0 ]; then
  echo "❌ Docker image build failed!"
  exit 1
fi

# Run the container
echo "🚀 Running container..."
sudo docker run -d -p 80:80 --name portfolio portfolio

# Wait for container to start (up to 30 seconds)
echo "⏳ Waiting for container to become healthy..."
for i in {1..10}; do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost)
  if [ "$STATUS" -eq 200 ]; then
    echo "✅ Health check passed. App running at http://<instance-public-ip>"
    exit 0
  fi
  echo "⏳ Waiting... ($i/10)"
  sleep 3
done

echo "❌ Health check failed! Status: $STATUS"
echo "Rolling back..."
sudo docker stop portfolio || true
sudo docker rm portfolio || true
exit 1