# ADR-001: Trigger Framework

## Status
Accepted

## Context
Salesforce triggers must remain thin to keep business logic testable and reusable. A domain-driven architecture separates trigger orchestration from business rules, selectors, and event publishing.

## Decision
Adopt a trigger framework where:
- triggers are thin entry points
- domain classes contain business logic
- services orchestrate rule application
- selectors handle SOQL
- event publishers handle async communication

## Consequences
- better separation of concerns
- easier unit testing
- reduced trigger recursion and mixed responsibilities
