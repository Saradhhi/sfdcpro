# ADR-003: Package Structure

## Status
Accepted

## Context
A single monolithic force-app structure limits reuse and slows down deployments. A multi-package structure supports modular delivery and unlocked package management.

## Decision
Use a multi-package source layout with:
- `force-app` for core metadata
- `packages/*` for layer-specific unlocked package code
- `lwc-framework` for reusable component systems
- `platform-events` for event objects

## Consequences
- enables package-level deployment
- supports team ownership of modules
- allows independent versioning of framework components
