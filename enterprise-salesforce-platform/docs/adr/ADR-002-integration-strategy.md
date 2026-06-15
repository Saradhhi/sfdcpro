# ADR-002: Integration Strategy

## Status
Accepted

## Context
Enterprise integrations require decoupled Salesforce-side adapters, centralized HTTP handling, and mocking support for tests.

## Decision
Implement an integration layer with:
- dedicated Apex REST clients
- centralized error handling
- mockable service interfaces
- platform events for async notifications

## Consequences
- easier testing and failover handling
- consistent external API behavior
- separation between domain rules and integration code
