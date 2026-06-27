#!/bin/bash
# Pre-deployment validation script
# Author: Vijaya Saradhi Meka
set -e
echo "🔍 Running pre-deployment validation..."
sf org display --target-org $TARGET_ORG
sf apex run test --test-level RunLocalTests --result-format human --wait 20 --target-org $TARGET_ORG
echo "✅ Validation complete"
