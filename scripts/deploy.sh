#!/bin/bash

echo "🚀 Starting deployment..."

# Step 1: Remove old v2
rm -rf app/v2
mkdir app/v2

# Step 2: Copy base → v2
cp -r app/base/* app/v2/

# Step 3: Install dependencies
cd app/v2
npm install

# Step 4: Start v2
pm2 delete myapp-v2 2>/dev/null
pm2 start ../../ecosystem.config.js --only myapp-v2

echo "⏳ Waiting for app to stabilize..."
sleep 5

# Step 5: Run monitor
cd ../..
./scripts/monitor.sh

echo "✅ Deployment process finished"
