---
description: Systematic debugging workflow for production issues
---

# /debug [issue description]

Deep investigation and root cause analysis for bugs and errors.

## Investigation Protocol

### 1. Understand the Context
- What is the current behavior?
- What is the expected behavior?
- When did this start happening?
- Is it consistent or intermittent?
- What are the constraints and requirements?

### 2. Gather Evidence
- Read error messages and stack traces
- Check recent code changes (git log)
- Review related log files
- Examine affected files and components
- Check for similar issues in codebase

### 3. Hypothesis Generation
- List all possible causes
- Prioritize by likelihood
- Consider recent changes first
- Think about edge cases and race conditions
- Consider environmental factors

### 4. Systematic Investigation
- Test each hypothesis methodically
- Use Grep to find related code patterns
- Read implementation details carefully
- Check for similar patterns elsewhere
- Trace the execution path

### 5. Root Cause Analysis
- Identify the precise cause
- Explain why it happens
- Understand the full impact
- Document the underlying issue

### 6. Solution Proposal
- Suggest specific fixes with code examples
- Explain tradeoffs of each approach
- Consider backward compatibility
- Recommend tests to prevent recurrence
- Suggest monitoring/observability improvements

## Output Format

Provide a detailed analysis:

```markdown
## Issue Summary
- **Symptom**: [What users see]
- **Impact**: [Who is affected, severity]
- **Frequency**: [Always/Sometimes/Rare]

## Root Cause
[Detailed explanation of the underlying issue]

## Evidence
- Error logs: [relevant excerpts]
- Code location: [file:line]
- Related issues: [similar problems]

## Solution
### Recommended Fix
```[language]
[Code example]
```

### Why This Works
[Explanation of the fix]

### Alternative Approaches
1. [Option 1] - Pros/Cons
2. [Option 2] - Pros/Cons

## Prevention
- Test cases to add
- Monitoring to implement
- Documentation updates needed
```

## Requirements

- Follow CLAUDE.md principles
- Use `software-engineering` skill for analysis
- Provide specific file:line references
- Include code examples in solutions
- Consider security implications
- Suggest observability improvements
