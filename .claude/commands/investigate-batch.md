---
description: Quick batch investigation with concise output (cost-efficient for multiple issues)
---

# /investigate-batch [issues/topics]

Perform rapid investigation of multiple issues or questions with focused, actionable output.

## Workflow

### 1. Prioritize Issues
- List all issues to investigate
- Categorize by type (bug, question, optimization)
- Identify dependencies between issues
- Order by impact and urgency

### 2. Quick Analysis Per Issue
For each issue, determine:
- Core problem or question
- Affected code areas
- Likely root cause
- Immediate vs proper solution

### 3. Efficient Investigation
- Use code search (`grep`, `glob`) to locate relevant code
- Check git history only if necessary (`git log --oneline`)
- Focus on patterns and common causes
- Skip deep dives unless critical

### 4. Consolidated Findings
Group related issues:
- Similar root causes
- Same code area
- Related dependencies
- Common patterns

### 5. Prioritized Recommendations
For each issue/group:
- Quick summary of findings (1-2 sentences)
- Root cause identification
- Recommended fix (code snippet if simple)
- Estimated effort (low/medium/high)
- Priority level (critical/high/medium/low)

## Requirements

- Keep analysis concise (no verbose explanations)
- Focus on actionable insights
- Provide code examples for straightforward fixes
- Use `software-engineering` skill for patterns
- Use `typescript` skill for JS/TS issues
- Use `react` skill for React/Next.js issues
- Highlight critical issues requiring immediate attention
- Note issues that can be batched together

## Output Format

For each issue:

```
## Issue: [Brief Title]
**Category:** [Bug/Question/Optimization]
**Priority:** [Critical/High/Medium/Low]

**Findings:** [1-2 sentence summary]

**Root Cause:** [Specific cause]

**Fix:** [Code snippet or clear description]

**Effort:** [Low/Medium/High]

**Notes:** [Dependencies or considerations]
```

Group related issues and suggest batch fixes where applicable.

## Use Cases

- Triaging multiple bug reports
- Answering several related questions
- Reviewing list of technical debt items
- Quick assessment of multiple warnings/errors
- Initial scoping for refactoring efforts

For detailed investigation of single complex issue, use `/investigate` instead.
