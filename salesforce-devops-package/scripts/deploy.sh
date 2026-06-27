#!/bin/bash
# Delta deployment script
# Author: Vijaya Saradhi Meka
set -e
echo "🚀 Starting delta deployment to $TARGET_ORG..."
sf project deploy start \
  --source-dir force-app \
  --target-org $TARGET_ORG \
  --test-level RunLocalTests \
  --wait 30
echo "✅ Deployment complete"
