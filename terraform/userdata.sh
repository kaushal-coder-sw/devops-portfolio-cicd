#!/bin/bash

# Install Docker
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user

mkdir -p /home/ec2-user/app

# Pull and run the container
cd /home/ec2-user/app  # <-- assuming this is where your app code is copied
docker build -t portfolio .
docker run -d -p 80:80 --name portfolio portfolio

# Health Check
APP_URL="http://localhost"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL)

if [ "$STATUS" -ne 200 ]; then
  echo "❌ Health check failed! Status: $STATUS"
  echo "Rolling back..."

  docker stop portfolio || true
  docker rm portfolio || true
  exit 1
else
  echo "✅ Health check passed. App running at $APP_URL"
fi
