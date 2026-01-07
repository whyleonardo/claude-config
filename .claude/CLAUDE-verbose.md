## Git Workflow
- Do not include "Claude Code" in commit messages
- Use conventional commits (be brief and descriptive)

## Important Concepts
Focus on these principles in all code:
- e2e type-safety
- error monitoring/observability
- automated tests
- readability/maintainability

All detailed coding guidelines are in the skills:
- Use `software-engineering` skill for core principles
- Use `typescript` skill for TypeScript/JavaScript
- Use `react` skill for React/Next.js

## Core Principles
Write code that is accessible, performant, type-safe, and maintainable. Focus on clarity and explicit intent over brevity. Every character must earn its place.

## Type Safety & Explicitness
- Always use explicit types for function parameters and return values when they enhance clarity
- Always prefer `unknown` over `any` when the type is genuinely unknown
- Always use const assertions (`as const`) for immutable values and literal types
- Always leverage TypeScript's type narrowing instead of type assertions
- Always use meaningful variable names instead of magic numbers - extract constants with descriptive names

## Modern JavaScript/TypeScript Standards
- Always prefer types over interfaces
- Always place types close to where they're used
- Always use strict TypeScript, never use `any`, almost never use `as`
- Always use arrow functions for callbacks and short functions
- Always prefer `for...of` loops over `.forEach()` and indexed `for` loops
- Always use optional chaining (`?.`) and nullish coalescing (`??`) for safer property access
- Always prefer template literals over string concatenation
- Always use destructuring for object and array assignments
- Always use `const` by default, `let` only when reassignment is needed, never use `var`
- Never use suffixes like Manager, Helper, Service unless essential
- Always prefer concise names: `retryCount` over `maximumNumberOfTimesToRetryBeforeGivingUpOnTheRequest`
- Unused vars must start with `_` (or remove them entirely)
- Always aim for e2e type-safety
- Always let the compiler infer response types whenever possible
- Always use named exports; never use default exports unless required
- Never abbreviate; always use descriptive names
- Always use early return over if-else
- Always prefer hash-lists over switch-case
- Always follow programming language naming conventions (SNAKE_CAPS for constants, camelCase for functions, kebab-case for file names)
- Always avoid indentation levels, strive for flat code
- Always remove redundancy: `users` not `userList`

## Software Engineering Concepts
- Always aim for e2e type-safety across the entire application stack
- Always implement monitoring/observability/profiling/tracing in production systems
- Always follow simplicity principles (KISS, YAGNI, 1 idea per sentence, no clutter/filler words)
- Always use descriptive naming (avoid vague terms: data, item, list, component, info)
- Always prefer functional programming principles (immutability, higher-order functions)
- Always write automated tests (prevents bug re-occurrence, makes changes safer)
- Always handle errors and provide user feedback, log errors with observability tools
- Always use automation with CI pipelines to validate builds and tests
- Always focus on accessibility (a11y, strive for WCAG 2.0 guidelines)
- Always follow security best practices (OWASP)
- Comments are unnecessary 98% of the time, convert them to a function/variable instead
- Never write pure SQL strings, always use query-builders for SQL-injection protection
- Always use higher-order functions for monitoring/error handling/profiling
- Never do premature optimization
- Code is reference, history and functionality - must be readable as a journal
- Always be concrete and specific: `retryAfterMs` over `timeout`, `emailValidator` over `validator`
- Always use nested objects to provide context: `config.public.ENV_NAME` instead of `ENV_NAME`
- Always avoid useless abstractions (functions that mainly call one function, helper used only once)
- Always keep code close to where it's used, unless used 2-3+ times
- A folder with a single file should be a single file

## Async & Promises
- Always `await` promises in async functions - don't forget to use the return value
- Always use `async/await` syntax instead of promise chains for better readability
- Always handle errors appropriately in async code with try-catch blocks
- Never use async functions as Promise executors

## React & JSX
- Always use function components, never use class components
- Always call hooks at the top level only, never conditionally
- Always specify all dependencies in hook dependency arrays correctly
- Always use the `key` prop for elements in iterables (prefer unique IDs over array indices)
- Always nest children between opening and closing tags instead of passing as props
- Never use magic numbers/strings
- Always use errorBoundary with retry button
- Always use semantic HTML and ARIA attributes for accessibility:
  - Always provide meaningful alt text for images
  - Always use proper heading hierarchy
  - Always add labels for form inputs
  - Always include keyboard event handlers alongside mouse events
  - Always use semantic elements (`<button>`, `<nav>`, etc.) instead of divs with roles

## Error Handling & Debugging
- Never use `console.log`, `debugger`, or `alert` statements in production code
- Always throw `Error` objects with descriptive messages, never throw strings or other values
- Always use `try-catch` blocks meaningfully - don't catch errors just to rethrow them
- Always prefer early returns over nested conditionals for error cases

## Code Organization
- Always keep functions focused and under reasonable cognitive complexity limits
- Always extract complex conditions into well-named boolean variables
- Always use early returns to reduce nesting
- Always prefer simple conditionals over nested ternary operators
- Always group related code together and separate concerns

## Security
- Always add `rel="noopener"` when using `target="_blank"` on links
- Avoid `dangerouslySetInnerHTML` unless absolutely necessary
- Never use `eval()` or assign directly to `document.cookie`
- Always validate and sanitize user input

## Performance
- Never use spread syntax in accumulators within loops
- Always use top-level regex literals instead of creating them in loops
- Always prefer specific imports over namespace imports
- Always avoid barrel files (index files that re-export everything)
- Always use proper image components (e.g., Next.js `<Image>`) over `<img>` tags

## Framework-Specific Guidance

### Next.js
- Always use Next.js `<Image>` component for images
- Always use `next/head` or App Router metadata API for head elements
- Always use Server Components for async data fetching instead of async Client Components

### React 19+
- Always use ref as a prop instead of `React.forwardRef`
- Never define components inside other components
- Always use React 19 best practices (Suspense, hook "use", promises as props)
- Always use enum for React Query cache strings
- Always use React Query to fetch async data on the client-side
- Never declare constants or functions inside components; keep them pure
- Never fetch data in useEffect, always use React Query
  - You probably shouldn't use useEffect
  - Always use `use`, `useTransition` and `startTransition` instead of useEffect
- Never use magic strings for cache tags; always use an enum/factory
- Always prefer `<Suspense>` and `useSuspenseQuery` over React Query `isLoading`

## Testing
- Always write assertions inside `it()` or `test()` blocks
- Always use async/await instead of done callbacks in async tests
- Never use `.only` or `.skip` in committed code
- Always keep test suites reasonably flat - avoid excessive `describe` nesting
- Always use describe clauses to segment the test file as feature behavioral
- Always test behavior, never test implementation
- Never use "should", always use 3rd person verbs
- Always write a test for each bug you fix to ensure no re-occurrence

## Writing & Documentation
- Always be concise, 1 idea per sentence, each word must earn its place
- Always prefer active voice: "We fixed the bug" over "The bug was fixed by us"
- Always prefer short sentences
- Always lead with result, return early, make outcomes obvious
- Always cut the clutter: delete redundant words in names and code
