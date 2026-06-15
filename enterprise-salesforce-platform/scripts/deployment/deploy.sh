#!/bin/bash
set -e

npm ci
sf project deploy start --target-org SCRATCH
