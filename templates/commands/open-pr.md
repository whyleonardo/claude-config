---
description: Create comprehensive PR with summary, diagram, and verification steps
---

# /open-pr

Generate a complete Pull Request description for the current branch.

## Workflow

### 1. Analyze Changes
!`git log main..HEAD --oneline`
!`git diff main..HEAD --stat`

Review commits and file changes to understand:
- What was changed (files, components, modules)
- Why changes were made (problem being solved)
- How changes work together (data flow, dependencies)
- Impact on existing functionality

### 2. Generate PR Title
- Follow conventional commits format: `type(scope): description`
- Types: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `perf`, `style`
- Keep under 72 characters
- Be specific and descriptive

### 3. Write Summary
Create 2-4 bullet points covering:
- Problem statement or motivation
- Solution approach and key decisions
- Notable implementation details
- Breaking changes or migration notes (if any)

### 4. Create Changes Diagram
Generate a Mermaid diagram showing:
- Files/components affected
- Data flow changes
- New dependencies or integrations
- Architecture impact (if significant)

Use appropriate diagram type:
- `flowchart` for process flows
- `graph` for relationships
- `sequenceDiagram` for interactions
- `classDiagram` for structure changes

### 5. Testing Instructions
Provide clear steps to verify changes:
- Setup requirements (if any)
- How to test new functionality
- How to verify existing behavior still works
- Edge cases to check
- Performance considerations (if applicable)

### 6. Quality Checklist
- [ ] Tests added/updated (unit, integration, e2e as needed)
- [ ] Documentation updated (README, comments, API docs)
- [ ] Types are properly defined (e2e type-safety)
- [ ] Error handling implemented
- [ ] No breaking changes (or documented with migration guide)
- [ ] Accessibility requirements met (if UI changes)
- [ ] Performance impact considered
- [ ] Security implications reviewed

## Requirements

- Follow CLAUDE.md git workflow principles
- Reference relevant skills for code quality standards
- Ensure PR description is clear for reviewers
- Include all necessary context for understanding changes
- Make testing steps reproducible
- Link to related issues or documentation

## Output Format

Provide ready-to-paste PR description with:
1. Title (single line)
2. Summary section
3. Mermaid diagram (code block)
4. Testing Instructions section
5. Checklist section (markdown checkboxes)
