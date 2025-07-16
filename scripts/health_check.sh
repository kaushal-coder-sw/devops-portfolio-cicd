#!/bin/bash

APP_URL="http://3.7.248.20"

MAX_RETRIES=20
RETRY_DELAY=3
COUNT=0
STATUS=000

while [ "$STATUS" -ne 200 ] && [ $COUNT -lt $MAX_RETRIES ]; do
  echo "⌛ Waiting for app to become healthy... (attempt $((COUNT+1)))"
  sleep $RETRY_DELAY
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$APP_URL" || echo "000")
  COUNT=$((COUNT+1))
done

if [ "$STATUS" -ne 200 ]; then
  echo "❌ Health check failed! Status: $STATUS"
  echo "Rolling back..."

  sudo docker stop portfolio || true
  sudo docker rm portfolio || true
  exit 1
else
  echo "✅ Health check passed. App running at $APP_URL"
fi
