#!/bin/bash

echo "🔍 Checking v2 health..."

FAIL=0

# Check 5 times
for i in {1..5}
do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3001/health)

  echo "Attempt $i → Status: $STATUS"

  if [ "$STATUS" != "200" ]; then
    FAIL=$((FAIL+1))
  fi

  sleep 2
done

# Decision making
if [ "$FAIL" -ge 3 ]; then
  echo "❌ V2 is NOT stable → Rolling back..."

  pm2 delete myapp-v2

  echo "✅ Staying on v1 (stable)"

else
  echo "✅ V2 is stable → Promoting to v1..."

  # Stop old v1
  pm2 delete myapp-v1

  # Replace v1 with v2
  rm -rf app/v1
  cp -r app/v2 app/v1

  # Restart as v1
  pm2 start ecosystem.config.js --only myapp-v1

  # Remove v2
  pm2 delete myapp-v2

  echo "🎉 Promotion complete: v2 → v1"
fi
