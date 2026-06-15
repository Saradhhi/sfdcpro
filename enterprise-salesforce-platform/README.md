# Salesforce Enterprise Platform

This repository is a deployable Salesforce DX blueprint for an enterprise-ready application.

## Getting Started

1. Install Salesforce CLI and Node.js.
2. Run `npm install`.
3. Create a scratch org:
   ```bash
   sf org create scratch --definition-file config/project-scratch-def.json --setdefaultusername --alias SCRATCH
   ```
4. Deploy source:
   ```bash
   sf project deploy start --target-org SCRATCH
   ```
5. Run Apex tests:
   ```bash
   sf apex test run --target-org SCRATCH --result-format human
   ```

## Repository Structure

- `force-app/main/default`: Salesforce metadata source
- `apex`: shared Apex platform library, selectors, events, and services
- `packages/core-domain`: domain package with trigger orchestration and business rules
- `packages/integration-layer`: HTTP adapters and external service clients
- `packages/ui-framework`: reusable Lightning Web Components and UI framework patterns
- `platform-events`: platform event definitions and event object metadata
- `.github/workflows`: CI/CD automation
- `config/project-scratch-def.json`: scratch org definition
