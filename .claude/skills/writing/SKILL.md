---
name: writing
description: Guidelines for clear technical writing and documentation.
---

# Technical Writing Standards

## General Principles

- Be concise - every word should earn its place
- Write for your audience (developer, user, stakeholder)
- Use active voice over passive voice
- Front-load important information
- One idea per paragraph

## Documentation Structure

- Start with a brief summary/overview
- Use headers to create scannable structure
- Include practical examples
- End with next steps or related resources
- Keep docs close to the code they describe

## Code Comments

- Explain "why", not "what"
- Comment on non-obvious decisions
- Keep comments up-to-date with code
- Use TODO/FIXME with context and ticket numbers
- Avoid commented-out code (use version control)

## Commit Messages

Format:
```
<type>(<scope>): <subject>

<body>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

- Subject: imperative mood, max 50 chars, no period
- Body: wrap at 72 chars, explain what and why

## PR Descriptions

- Summarize the change in 1-2 sentences
- List what changed and why
- Include testing instructions
- Link to related issues/tickets
- Add screenshots for UI changes

## README Structure

1. Project name and brief description
2. Quick start / Installation
3. Usage examples
4. Configuration options
5. Contributing guidelines
6. License

## API Documentation

- Document all public endpoints/methods
- Include request/response examples
- Specify required vs optional parameters
- Document error responses
- Keep examples up-to-date and tested
