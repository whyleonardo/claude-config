## Git Workflow
- Do not include "Claude Code" in commit messages
- Use conventional commits (be brief and descriptive)
- Format: `type(scope): description` where type is feat|fix|docs|style|refactor|test|chore

## Important Concepts
Focus on these principles in all code:
- e2e type-safety
- error monitoring/observability
- automated tests
- readability/maintainability
- security-first approach
- performance awareness

## Available Skills
All detailed coding guidelines are in the skills (auto-activated when relevant):

### Core Development
- `software-engineering` - Core engineering principles and patterns
- `typescript` - TypeScript/JavaScript standards and best practices
- `react` - React/Next.js patterns and component architecture

### Quality & Analysis
- `reviewing-code` - Code review guidelines and checklists
- `writing` - Technical writing and documentation standards
- `debugging` - Systematic debugging and root cause analysis
- `test-generation` - Comprehensive test coverage with best practices
- `security` - Security vulnerabilities and best practices review
- `performance` - Performance optimization and profiling

### Documentation
- `api-documentation` - Generate comprehensive API documentation

## Available Commands
Custom workflow commands for common tasks:

### Development Workflows
- `/create-feature [description]` - Plan and implement new features
- `/refactor [target]` - Safe refactoring with tests and validation
- `/debug [issue]` - Systematic debugging and investigation
- `/test-gen [target]` - Generate comprehensive tests

### Code Quality
- `/review-staged` - Review staged changes before committing
- `/trim` - Cleanup and optimize code
- `/investigate` - Deep dive analysis
- `/investigate-batch` - Batch investigation of multiple issues

### Documentation & Deployment
- `/api-docs [scope]` - Generate complete API documentation
- `/open-pr` - Create pull requests with proper context

## Project Context Patterns

### When Starting Work
1. Check CLAUDE.md for project-specific conventions
2. Review recent commits for context
3. Run project's verification commands
4. Understand the architecture before changing code

### When Making Changes
1. Plan the approach first for complex features
2. Make incremental, testable changes
3. Run tests frequently
4. Verify type safety after changes

### Before Committing
1. Run linter and formatter
2. Run all relevant tests
3. Review changes carefully
4. Use conventional commit format

## Common Commands to Reference
```bash
# Development
npm run dev          # Start development server
npm test             # Run tests
npm run lint         # Lint code
npm run typecheck    # TypeScript validation
npm run build        # Build for production

# Git
git status           # Check current changes
git diff             # See detailed changes
git log --oneline    # View commit history
```

## Best Practices

### Code Quality
- Write self-documenting code (clear names, simple logic)
- Keep functions small and focused
- Follow DRY principle but avoid premature abstraction
- Test behavior, not implementation
- Handle errors explicitly

### Security
- Never commit secrets or credentials
- Validate and sanitize all user input
- Use parameterized queries (never string concatenation)
- Implement proper authentication and authorization
- Follow OWASP best practices

### Performance
- Profile before optimizing
- Fix N+1 query problems
- Use appropriate data structures
- Implement caching strategically
- Monitor production performance

### Testing
- Cover happy path, errors, and edge cases
- Make tests independent and deterministic
- Use meaningful test names (behavior, not implementation)
- Follow AAA pattern: Arrange, Act, Assert

## Project Learnings
(Document patterns and gotchas as you learn them)
