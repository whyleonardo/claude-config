---
name: typescript
description: TypeScript and JavaScript coding standards and best practices.
---

# TypeScript Standards

## Type Safety

- Enable strict mode (`"strict": true`)
- Avoid `any` - use `unknown` when type is uncertain
- Prefer `type` for unions/intersections, `interface` for object shapes
- Use const assertions for literal types: `as const`
- Leverage discriminated unions for state machines

## Prefer Modern Syntax

- Use `const`/`let` over `var`
- Arrow functions for callbacks and short functions
- Template literals over string concatenation
- Optional chaining (`?.`) and nullish coalescing (`??`)
- Destructuring for cleaner code

## Functions

- Explicit return types for public APIs
- Use overloads for complex signatures
- Prefer pure functions when possible
- Keep functions small and focused (max ~20-30 lines)
- Use default parameters over conditional logic

## Error Handling

- Use typed error classes
- Prefer Result/Either patterns for expected failures
- Throw for unexpected/unrecoverable errors
- Always type catch blocks: `catch (error: unknown)`

## Async Code

- Prefer `async/await` over raw Promises
- Use `Promise.all` for parallel operations
- Handle rejection with try/catch or `.catch()`
- Avoid mixing callbacks and promises
- Consider `Promise.allSettled` when partial success is acceptable

## Imports & Exports

- Use named exports for most cases
- Default exports only for main module entry
- Group imports: external, internal, types
- Use barrel files (`index.ts`) sparingly
- Prefer absolute imports with path aliases

## Best Practices

- Avoid mutation when possible
- Use `readonly` for immutable data
- Prefer composition over inheritance
- Use generics for reusable type-safe code
- Validate external data at boundaries (Zod, etc.)
