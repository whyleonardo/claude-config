---
description: Create PR with summary and diagram
---

Prepare a Pull Request for the current branch.

!`git log main..HEAD --oneline`
!`git diff main..HEAD --stat`

## Generate

1. **PR Title** - Concise, follows conventional commits
2. **Summary** - What changed and why (2-3 bullet points)
3. **Changes Diagram** - Mermaid diagram showing:
   - Components/files affected
   - Data flow changes
   - Dependencies modified

4. **Testing Instructions** - How to verify the changes
5. **Checklist**
   - [ ] Tests added/updated
   - [ ] Documentation updated
   - [ ] No breaking changes (or documented)

Format the output as a ready-to-use PR description.
