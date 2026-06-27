#!/bin/bash
# Rollback to previous package version
# Author: Vijaya Saradhi Meka
set -e
echo "⏪ Rolling back to version $ROLLBACK_VERSION..."
sf package install --package $ROLLBACK_VERSION --target-org $TARGET_ORG --wait 20
echo "✅ Rollback complete"
