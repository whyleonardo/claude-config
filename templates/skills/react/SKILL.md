---
name: react
description: React and Next.js patterns, hooks, and component architecture.
---

# React & Next.js Standards

## Component Architecture

- Prefer function components with hooks
- Keep components small and focused (single responsibility)
- Separate container (logic) from presentational (UI) components
- Use composition over prop drilling
- Co-locate related files (component, styles, tests, types)

## Naming Conventions

- Components: PascalCase (`UserProfile.tsx`)
- Hooks: camelCase with `use` prefix (`useAuth`)
- Event handlers: `handle` prefix (`handleClick`)
- Boolean props: `is`, `has`, `should` prefixes

## Hooks Best Practices

- Follow rules of hooks (top-level, React functions only)
- Extract custom hooks for reusable logic
- Use `useMemo`/`useCallback` for expensive computations or stable references
- Avoid premature memoization - measure first
- Keep dependency arrays accurate and minimal

## State Management

- Start with local state (`useState`)
- Lift state only when necessary
- Use Context for truly global state (theme, auth)
- Consider Zustand/Jotai for complex client state
- Server state: React Query/SWR/TanStack Query

## Next.js Patterns

- Prefer Server Components by default
- Use `"use client"` only when necessary (interactivity, hooks, browser APIs)
- Leverage `loading.tsx` and `error.tsx` for loading/error states
- Use Route Handlers for API endpoints
- Implement proper metadata for SEO

## Performance

- Lazy load heavy components with `React.lazy` or `next/dynamic`
- Optimize images with `next/image`
- Use Suspense boundaries strategically
- Avoid inline object/array literals in JSX props
- Profile with React DevTools before optimizing

## Forms & Validation

- Use controlled components or React Hook Form
- Validate with Zod for type-safe schemas
- Show validation errors inline
- Disable submit during loading
- Handle server errors gracefully

## Testing

- Test behavior, not implementation
- Use React Testing Library
- Test user interactions and outcomes
- Mock external dependencies
- Write integration tests for critical flows
