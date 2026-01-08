---
description: Comprehensive review of staged changes before committing
---

# /review-staged

Review currently staged changes for quality, correctness, and adherence to standards.

## Workflow

### 1. View Staged Changes
!`git diff --staged`

Analyze what's being committed:
- Files modified, added, or deleted
- Scope and size of changes
- Relationship between changes
- Potential impact areas

### 2. Correctness Review
- Does the code work as intended?
- Are edge cases handled properly?
- Is error handling appropriate?
- Are there any logical errors?
- Do changes align with requirements?

Questions to ask:
- Will this break existing functionality?
- Are there off-by-one errors or race conditions?
- Does async code handle all states (loading, error, success)?

### 3. Type Safety Review
- Are all types explicitly defined where needed?
- Is `unknown` used instead of `any`?
- Are type assertions justified and safe?
- Is type narrowing used appropriately?
- Are generic types properly constrained?
- Is end-to-end type safety maintained?

Check for:
- Missing return types on public functions
- Unsafe type casts (`as`)
- Implicit `any` types
- Incorrect generic constraints

### 4. Code Quality Review
Use the `reviewing-code` skill for detailed guidelines.

**Clarity & Readability:**
- Are names descriptive and meaningful?
- Is code self-documenting?
- Are functions focused and reasonably sized?
- Is nesting minimized with early returns?

**Modern Standards:**
- Using const/let (no var)?
- Arrow functions where appropriate?
- Optional chaining and nullish coalescing?
- Template literals over concatenation?
- Proper async/await usage?

**Best Practices:**
- No console.log, debugger statements?
- No magic numbers or strings?
- Named exports (not default)?
- Proper error handling with try-catch?
- No commented-out code?

### 5. Framework-Specific Review
**React/Next.js (if applicable):**
- Function components only?
- Hooks used correctly (top level, dependencies array)?
- Key props on mapped elements?
- Semantic HTML and ARIA attributes?
- Error boundaries where needed?

**TypeScript/JavaScript:**
- Following project conventions?
- Imports organized properly?
- No circular dependencies?
- Pure functions where possible?

### 6. Security Review
- Are user inputs validated?
- Are outputs sanitized (XSS prevention)?
- No SQL injection risks?
- Secrets or credentials exposed?
- External links have rel="noopener"?
- Authentication/authorization properly checked?

### 7. Testing Review
- Are there tests for new functionality?
- Are existing tests updated if behavior changed?
- Do tests cover edge cases?
- Are test names descriptive?
- Is test coverage adequate?

### 8. Documentation Review
- Is README updated if needed?
- Are JSDoc comments added for public APIs?
- Are breaking changes documented?
- Is migration guide provided (if needed)?

## Requirements

- Use `reviewing-code` skill for comprehensive checklist
- Use `software-engineering` skill for architecture review
- Use `typescript` skill for TS/JS code standards
- Use `react` skill for React/Next.js patterns
- Follow CLAUDE.md and CLAUDE-verbose.md principles
- Check for type safety, error handling, and security
- Verify automated tests are included
- Ensure observability/monitoring for production code

## Output Format

### Summary of Changes
[High-level overview of what's being committed]

### Issues Found
If issues exist, list each with:
- Severity (Critical/High/Medium/Low)
- Location (file and line reference)
- Description
- Suggested fix

### Positive Observations
Highlight good practices used (reinforces quality work)

### Suggestions for Improvement
Non-critical improvements that could enhance code quality

### Verdict
**[✅ Ready to commit | ⚠️ Ready with minor notes | ❌ Needs changes]**

[Brief justification of verdict]

### Next Steps
- If ready: Suggested commit message (conventional commits format)
- If needs changes: Prioritized list of required fixes
