---
description: Deep investigation with detailed analysis and actionable recommendations
---

# /investigate [topic/issue/bug]

Perform thorough investigation of a problem, codebase pattern, or technical question.

## Workflow

### 1. Understand the Context
- Clarify the current behavior vs expected behavior
- Identify constraints and requirements
- Review error messages or symptoms
- Understand the business context and user impact
- Determine scope and affected components

Questions to answer:
- What is happening now?
- What should happen instead?
- When did this start occurring?
- What changed recently?

### 2. Deep Dive Analysis
- Trace code flow from entry point to exit
- Map all dependencies and side effects
- Examine related code patterns in codebase
- Check git history for relevant context (`git log`, `git blame`)
- Review configuration and environment factors
- Analyze data flow and state management
- Identify integration points and boundaries

Tools to use:
- `grep` for finding related code patterns
- `git log` for historical context
- Type system for understanding contracts
- Debugger or logging for runtime behavior

### 3. Root Cause Analysis
- Form multiple hypotheses
- Validate each hypothesis with evidence
- Eliminate incorrect assumptions
- Identify the root cause (not just symptoms)
- Document reasoning process
- Consider edge cases and boundary conditions

Analysis framework:
- What are the facts (observable, verifiable)?
- What are the assumptions (need validation)?
- What are the unknowns (need investigation)?

### 4. Provide Recommendations
For each viable solution:
- Describe the approach clearly
- Show implementation with code examples
- Explain trade-offs (complexity, performance, maintainability)
- Estimate effort and risk
- Note any prerequisites or dependencies

Include:
- Immediate fix (if critical bug)
- Proper solution (addressing root cause)
- Preventive measures (avoid recurrence)
- Testing strategy to validate fix

### 5. Summary and Next Steps
- Summarize key findings
- Recommend best approach with justification
- List action items with priority
- Identify areas needing further investigation
- Document lessons learned

## Requirements

- Use `software-engineering` skill for analysis approach
- Use `typescript` skill for code analysis (if applicable)
- Use `react` skill for React/Next.js issues (if applicable)
- Follow CLAUDE.md principles in recommendations
- Ensure recommendations are type-safe and testable
- Consider security implications of proposed solutions
- Include error handling in code examples

## Output Structure

1. **Problem Summary** (2-3 sentences)
2. **Context & Background** (relevant details)
3. **Analysis** (step-by-step investigation findings)
4. **Root Cause** (definitive cause with evidence)
5. **Recommendations** (2-3 options with trade-offs)
6. **Implementation** (code examples for preferred solution)
7. **Testing** (how to verify the fix)
8. **Prevention** (how to avoid similar issues)

Be thorough and explain reasoning at each step.
