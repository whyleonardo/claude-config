---
name: software-engineering
description: Core engineering principles for quality, maintainable code.
---

# Software Engineering Standards

Apply these principles to all code.

## Core Principles

- Type-safety (aim for e2e type-safety)
- Monitoring/observability/profiling/tracing
- Automated tests (unit, integration, e2e when applicable)
- Error handling with meaningful messages and proper recovery
- Security-first approach (validate inputs, sanitize outputs)

## Naming & Clarity

- Be concrete: `retryAfterMs` > `timeout`, `emailValidator` > `validator`
- Use domain language consistently across the codebase
- Prefer explicit over clever code
- Function names should describe what they do, not how
- Boolean variables: use `is`, `has`, `should`, `can` prefixes

## Code Organization

- Keep code close to where it's used (unless used 2-3+ times)
- Single responsibility per module/function
- Avoid deep nesting (prefer early returns)
- Group related functionality together
- Separate concerns: data, logic, presentation

## Error Handling

- Never swallow errors silently
- Provide actionable error messages
- Use typed errors when possible
- Log errors with context (what, where, why)
- Fail fast in development, gracefully in production

## Performance Awareness

- Measure before optimizing
- Consider time and space complexity
- Avoid premature optimization
- Profile hot paths in production
- Cache expensive computations appropriately

## Documentation

- Code should be self-documenting when possible
- Document "why", not "what" (code shows what)
- Keep docs close to code (JSDoc, inline comments)
- Update docs when changing behavior
