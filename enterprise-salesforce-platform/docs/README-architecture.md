# Architecture Overview

## Enterprise Layering
- `packages/core-domain`: domain logic, rules, and trigger orchestration
- `packages/integration-layer`: external API adapters and service clients
- `packages/ui-framework`: reusable Lightning Web Components and UI patterns
- `platform-events`: Platform Event definitions for event-driven workflows

## DevSecOps
- GitHub Actions for PR validation, CodeQL, and SFDX static scanning
- `sfdx-project.json` declares modular package directories
- `README.md` contains scratch org creation and deploy commands

## Deployment
Use `sf project deploy start --target-org SCRATCH` from this repository root.
