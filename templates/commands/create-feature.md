---
description: Automate feature development workflow
---

# /create-feature [description]

Plan and implement a new feature following CLAUDE.md guidelines.

## Workflow

### 1. Branch Creation
git checkout -b feat/<feature-name>

### 2. Planning Phase
- Analyze existing codebase patterns
- Identify affected files and components
- Define clear acceptance criteria
- Estimate complexity and break down into smaller tasks if needed
- Plan data flow and state management approach
- Consider edge cases and error scenarios
- Review security implications (validation, sanitization, auth)
- Identify required types and interfaces
- Plan testing strategy (unit, integration, e2e)

### 3. Implementation
- Clarity: Descriptive names, early returns
- Type Safety: Explicit types for parameters/returns, prefer `unknown` over `any`
- Modern Standards: Use const/let, arrow functions, optional chaining, destructuring
- Functional Approach: Immutability, higher-order functions, pure functions
- Component Design: Function components, proper hook usage, semantic HTML
- Error Handling: Try-catch blocks, descriptive Error objects, user feedback
- Accessibility: ARIA attributes, semantic elements, keyboard support
- Performance: Proper memoization, avoid premature optimization
- Security: Input validation, no eval(), rel="noopener" on external links
- Code Organization: Keep functions focused, extract complex conditions, flat structure
- Framework-Specific: Use Server Components for async data fetching in Next.js, React Query for client-side data

### 4. Quality Checks
- Run type checker: `tsc --noEmit` or framework equivalent
- Run linter and formatter to ensure code style consistency
- Verify all tests pass: unit, integration, and e2e tests
- Test accessibility: keyboard navigation, screen reader compatibility
- Review error handling: all edge cases covered with proper feedback
- Check observability: errors logged, critical paths monitored
- Verify no console.log, debugger, or magic strings remain
- Ensure no default exports, all exports are named
- Confirm all dependencies in hook arrays are correct
- Validate security: no SQL injection risks, inputs sanitized

### 5. Stage Changes
git add <files>
git commit -m "feat: <brief description>"

## Requirements

- Follow CLAUDE.md and CLAUDE-verbose.md principles
- Use `software-engineering` skill for core principles
- Use `typescript` skill for TypeScript/JavaScript standards
- Use `react` skill for React/Next.js patterns
- Ensure e2e type-safety throughout the stack
- Write automated tests for new functionality
- Add error boundaries for React components
- Document complex logic with well-named functions/variables (not comments)
- Keep code close to where it's used unless reused 2-3+ times
