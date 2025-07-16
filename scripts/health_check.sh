#!/bin/bash

APP_URL="http://13.232.240.157"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL)

if [ "$STATUS" -ne 200 ]; then
  echo "❌ Health check failed! Status: $STATUS"
  echo "Rolling back..."

  sudo docker stop portfolio || true
  sudo docker rm portfolio || true
  exit 1
else
  echo "✅ Health check passed. App running at $APP_URL"
fi
