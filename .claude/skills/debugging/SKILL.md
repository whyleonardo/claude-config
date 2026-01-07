---
name: debugging
description: Systematic debugging and root cause analysis. Use when user asks to debug, investigate bugs, find issues, troubleshoot errors, or analyze failures.
allowed-tools: [Read, Grep, Glob, Bash]
---

# Debugging Skill

## When to Activate
Use this Skill when the user asks to:
- Debug an issue or error
- Investigate a bug
- Find the root cause of a problem
- Troubleshoot failures
- Analyze error logs
- Understand why something isn't working

## Systematic Debugging Process

### 1. Gather Context
**Ask critical questions:**
- What is the expected behavior?
- What is the actual behavior?
- When did this start happening?
- Is it consistent or intermittent?
- What changed recently?

**Collect evidence:**
- Error messages and stack traces
- Log files
- Recent commits (use `git log`)
- Related code files
- Configuration files

### 2. Understand the Code Flow
- Trace execution path from entry to exit
- Identify all touch points
- Map dependencies
- Understand state changes
- Check for side effects

### 3. Hypothesis Generation
Generate possible causes ranked by likelihood:
1. Recent code changes (most likely)
2. Configuration issues
3. Environmental factors
4. Dependency problems
5. Race conditions
6. Edge case handling

### 4. Test Hypotheses Systematically
For each hypothesis:
- Find relevant code with Grep/Glob
- Read implementation details
- Look for similar patterns
- Check for known issues
- Test assumptions

### 5. Root Cause Analysis
Once found:
- Explain WHY it happens (not just what)
- Identify contributing factors
- Assess full impact
- Consider similar issues elsewhere

### 6. Solution Proposal
Provide:
- **Primary fix** with code example
- **Why it works** (explanation)
- **Alternative approaches** with tradeoffs
- **Tests to add** (prevent recurrence)
- **Monitoring suggestions** (catch future issues)

## Investigation Techniques

### Stack Trace Analysis
```typescript
// Read stack trace bottom-to-top
Error: Cannot read property 'name' of undefined
  at getUserName (user.ts:45)      // ← Error occurred here
  at formatUser (formatter.ts:12)  // ← Called from here
  at render (app.ts:89)            // ← Entry point

// Investigation:
// 1. Check user.ts:45 - why is object undefined?
// 2. Check formatter.ts:12 - is null check missing?
// 3. Check app.ts:89 - where does data come from?
```

### Log Pattern Analysis
```bash
# Use Grep to find patterns
Grep pattern="ERROR|WARN" output_mode="content" -C=3

# Look for:
- Timestamps (when did it start?)
- Frequency (how often?)
- Correlation (what else happens nearby?)
- Progression (does it get worse?)
```

### Recent Changes Analysis
```bash
# Check recent commits
Bash command="git log --oneline -20"

# See what changed in suspect file
Bash command="git log -p --follow -- path/to/file.ts"

# Find when bug was introduced
Bash command="git log --grep='feature-name'"
```

### Dependency Analysis
```typescript
// Find all imports/uses
Grep pattern="import.*from.*problematic-module"
Grep pattern="\.problemFunction\("

// Check versions
Read file_path="package.json"
Read file_path="package-lock.json"
```

## Common Bug Patterns

### Null/Undefined Issues
```typescript
// Problem: No null check
function getUser(id) {
  return users.find(u => u.id === id).name; // ❌ Crashes if not found
}

// Solution: Safe access
function getUser(id) {
  const user = users.find(u => u.id === id);
  return user?.name; // ✅ Returns undefined safely
}
```

### Race Conditions
```typescript
// Problem: Async race
let data = null;
fetchData().then(result => data = result);
console.log(data); // ❌ null - not loaded yet

// Solution: Await properly
const data = await fetchData();
console.log(data); // ✅ Has value
```

### Off-by-One Errors
```typescript
// Problem: Wrong loop bound
for (let i = 0; i <= array.length; i++) { // ❌ Will access undefined
  console.log(array[i]);
}

// Solution: Correct bound
for (let i = 0; i < array.length; i++) { // ✅ Correct
  console.log(array[i]);
}
```

### Type Coercion Issues
```typescript
// Problem: Loose equality
if (value == null) // ❌ Matches both null AND undefined

// Solution: Strict equality
if (value === null) // ✅ Only matches null
```

## Output Format

```markdown
## Debug Analysis: [Issue]

### Symptom
[What users experience]

### Root Cause
[Detailed explanation of why it happens]

**Location**: `file.ts:line`
**Evidence**: [logs, errors, code]

### How It Happens
1. [Step 1]
2. [Step 2]
3. [Error occurs]

### Solution
```[language]
// Current code (problematic)
[existing code]

// Fixed code
[corrected code]
```

### Why This Fixes It
[Explanation]

### Alternative Solutions
1. **Option 1**: [Description]
   - Pros: [benefits]
   - Cons: [drawbacks]

2. **Option 2**: [Description]
   - Pros: [benefits]
   - Cons: [drawbacks]

### Prevention
- **Test to add**: [test case description]
- **Monitoring**: [what to log/alert on]
- **Documentation**: [what to document]

### Related Issues
[Similar bugs to check/fix]
```

## Best Practices

- Start with the simplest explanation
- Follow the data flow
- Use binary search (eliminate half possibilities each time)
- Reproduce reliably before fixing
- Fix root cause, not symptoms
- Add tests to prevent regression
- Document learnings in CLAUDE.md

## When to Escalate

If unable to find root cause:
- Complex distributed system issue
- Requires deep domain knowledge
- Environment-specific (can't reproduce)
- Hardware/infrastructure problem
- Third-party service issue

In these cases: Document what you found, suggest next steps, recommend who to involve.
