---
description: Safe refactoring workflow with tests and validation
---

# /refactor [target and goal]

Systematically refactor code with safety checks and test coverage.

## Refactoring Protocol

### 1. Pre-Refactoring Analysis
- Understand current implementation
- Identify code smells or issues
- Review existing tests
- Check dependencies and usage
- Assess impact scope
- Review git history for context

### 2. Safety Preparation
- Ensure all tests pass before starting
- Create comprehensive test coverage if missing
- Document current behavior
- Identify breaking changes
- Plan rollback strategy

### 3. Refactoring Plan
Create a step-by-step plan:
- What needs to change
- Order of operations (least to most risky)
- Expected improvements
- Potential risks
- Verification steps

### 4. Incremental Changes
Make small, testable changes:
- One logical change at a time
- Run tests after each change
- Commit working states frequently
- Maintain backward compatibility when possible

### 5. Validation
After each step:
- Run all tests
- Check type safety
- Run linter
- Verify no regressions
- Test edge cases manually if needed

### 6. Cleanup
- Remove dead code
- Update comments and documentation
- Ensure consistent style
- Verify performance hasn't degraded

## Refactoring Patterns

### Extract Function
```typescript
// Before: Complex function
function processUser(user) {
  // validation logic
  // transformation logic
  // persistence logic
}

// After: Extracted functions
function validateUser(user) { ... }
function transformUser(user) { ... }
function saveUser(user) { ... }

function processUser(user) {
  const valid = validateUser(user);
  const transformed = transformUser(valid);
  return saveUser(transformed);
}
```

### Extract Type/Interface
```typescript
// Before: Inline types
function getUser(id: string): { name: string; email: string; age: number } { ... }

// After: Named type
type User = {
  name: string;
  email: string;
  age: number;
};

function getUser(id: string): User { ... }
```

### Simplify Conditionals
```typescript
// Before: Nested ifs
if (user) {
  if (user.role === 'admin') {
    if (user.active) {
      // logic
    }
  }
}

// After: Early returns
if (!user) return;
if (user.role !== 'admin') return;
if (!user.active) return;
// logic
```

### Replace Magic Values
```typescript
// Before: Magic numbers
if (status === 200) { ... }
setTimeout(fn, 3000);

// After: Named constants
const HTTP_OK = 200;
const RETRY_DELAY_MS = 3000;

if (status === HTTP_OK) { ... }
setTimeout(fn, RETRY_DELAY_MS);
```

## Safety Checklist

Before completing refactoring:
- [ ] All tests pass
- [ ] No type errors
- [ ] Linter passes
- [ ] No console errors
- [ ] Functionality unchanged (or improved)
- [ ] Performance not degraded
- [ ] Documentation updated
- [ ] No breaking changes (or properly documented)
- [ ] Code review ready

## Output Format

```markdown
## Refactoring: [Target]

### Goal
[What we're improving and why]

### Changes Made
1. [Change 1]
   - Files: [list]
   - Why: [reason]
   - Tests: [verification]

2. [Change 2]
   - Files: [list]
   - Why: [reason]
   - Tests: [verification]

### Improvements
- Code quality: [improvements]
- Maintainability: [benefits]
- Performance: [if applicable]
- Type safety: [improvements]

### Risks Mitigated
[How we ensured safety]

### Next Steps
[Suggestions for further improvements]
```

## Requirements

- Follow CLAUDE.md principles
- Use `software-engineering` skill for patterns
- Use `typescript` skill for code standards
- Maintain or improve test coverage
- Run verification at each step
- Document all changes clearly
- Preserve or enhance performance
- Maintain backward compatibility when possible
