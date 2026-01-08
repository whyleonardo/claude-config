---
name: reviewing-code
description: Guidelines and checklist for thorough code review.
---

# Code Review Guidelines

## Review Mindset

- Be constructive, not critical
- Focus on the code, not the author
- Ask questions instead of making demands
- Praise good patterns and improvements
- Consider the context and constraints

## Checklist

### Correctness
- [ ] Does the code do what it's supposed to do?
- [ ] Are edge cases handled?
- [ ] Are there any off-by-one errors?
- [ ] Is error handling appropriate?

### Security
- [ ] Is user input validated/sanitized?
- [ ] Are there any SQL injection risks?
- [ ] Is sensitive data properly protected?
- [ ] Are authentication/authorization correct?

### Performance
- [ ] Are there any obvious N+1 queries?
- [ ] Is there unnecessary computation in loops?
- [ ] Are expensive operations cached appropriately?
- [ ] Could any operations be parallelized?

### Maintainability
- [ ] Is the code readable and self-documenting?
- [ ] Are functions/modules appropriately sized?
- [ ] Is there code duplication that should be abstracted?
- [ ] Are naming conventions followed?

### Testing
- [ ] Are there tests for new functionality?
- [ ] Do existing tests still pass?
- [ ] Are edge cases covered in tests?
- [ ] Is test coverage adequate?

### Type Safety
- [ ] Are types properly defined?
- [ ] Are there any `any` types that should be typed?
- [ ] Are null/undefined cases handled?

## Communication

- Use conventional comment prefixes:
  - `nit:` - minor, non-blocking suggestion
  - `suggestion:` - optional improvement
  - `question:` - seeking clarification
  - `issue:` - must be addressed before merge
- Provide examples when suggesting changes
- Link to documentation or resources when helpful
