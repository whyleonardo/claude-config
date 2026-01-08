# Command Guide

This guide helps you choose the right command for your task. Commands are organized by workflow phase and use case.

## Quick Reference

| Command | When to Use | Output Style |
|---------|-------------|--------------|
| `/ultra-think` | Strategic decisions, architecture planning | Comprehensive (2-4 pages) |
| `/investigate` | Deep bug analysis, complex issues | Detailed analysis |
| `/investigate-batch` | Quick troubleshooting, simple issues | Brief summary |
| `/create-feature` | Implementing new features | Full workflow |
| `/create-architecture-documentation` | Creating architecture docs, diagrams, ADRs | Complete documentation suite |
| `/generate-tests` | Creating test suites for components/functions | Complete test files |
| `/review-staged` | Before committing changes | Quality checklist |
| `/open-pr` | Creating pull requests | PR template |
| `/trim` | Need concise responses | Mode change |

## Command Decision Tree

```
┌─ Need to make a strategic decision?
│  └─ /ultra-think
│
├─ Need to fix something?
│  ├─ Complex bug or system issue?
│  │  └─ /investigate
│  └─ Quick fix or simple issue?
│     └─ /investigate-batch
│
├─ Need to build something?
│  ├─ New feature?
│  │  └─ /create-feature
│  ├─ Tests for existing code?
│  │  └─ /generate-tests
│  └─ Architecture documentation?
│     └─ /create-architecture-documentation
│
├─ Ready to commit?
│  └─ /review-staged
│
├─ Ready to create PR?
│  └─ /open-pr
│
└─ Want shorter responses?
   └─ /trim
```

## Detailed Command Usage

### 1. Strategic Planning & Architecture

#### `/ultra-think` - Deep Analysis and Problem Solving

**Use when:**
- Making architectural decisions (microservices vs monolith, database choice)
- Evaluating technology stack changes
- Planning system scaling strategies
- Analyzing complex tradeoffs
- Need multi-perspective analysis (technical, business, user, system)

**Don't use for:**
- Debugging existing code (use `/investigate` instead)
- Quick questions (just ask normally)
- Implementing features (use `/create-feature`)

**Example scenarios:**
```bash
# Architecture decisions
/ultra-think Should we migrate from REST to GraphQL?
/ultra-think How do we scale to handle 10x traffic while reducing costs?

# Technology choices
/ultra-think Which state management solution fits our React app?
/ultra-think MongoDB vs PostgreSQL for our use case?

# Strategic planning
/ultra-think How to refactor our legacy monolith incrementally?
/ultra-think What's the best approach for adding real-time features?
```

**Output:** 2-4 pages including:
- Multi-perspective analysis
- 3-5 solution approaches with pros/cons
- Recommendation with reasoning
- Implementation considerations

---

### 2. Debugging & Investigation

#### `/investigate` - Deep Investigation with Detailed Analysis

**Use when:**
- Complex bugs requiring deep analysis
- System-wide issues affecting multiple components
- Performance problems needing profiling
- Need comprehensive root cause analysis
- Want detailed recommendations and solutions

**Don't use for:**
- Simple syntax errors (just ask)
- Quick checks (use `/investigate-batch`)
- Strategic decisions (use `/ultra-think`)

**Example scenarios:**
```bash
/investigate Memory leak in the React components
/investigate API endpoints returning 500 errors intermittently
/investigate Database queries are slow on production
```

**Output:** Detailed report with context, root cause, and step-by-step fix

---

#### `/investigate-batch` - Quick Investigation (Cost-Efficient)

**Use when:**
- Simple bugs or errors
- Quick troubleshooting needed
- Want fast, concise answers
- Cost efficiency is important
- Clear symptoms pointing to likely cause

**Don't use for:**
- Complex multi-component issues (use `/investigate`)
- Need detailed analysis
- Architectural questions (use `/ultra-think`)

**Example scenarios:**
```bash
/investigate-batch Test failing in checkout.test.ts
/investigate-batch Button click handler not firing
/investigate-batch TypeScript error in user.service.ts:45
```

**Output:** Quick summary with 1-2 sentence root cause and recommended fix

---

### 3. Feature Development

#### `/create-feature` - Automate Feature Development Workflow

**Use when:**
- Starting new feature development
- Want automated branch creation
- Need structured implementation plan
- Following team workflow standards

**Don't use for:**
- Small bug fixes (just fix and commit)
- Exploratory coding
- Quick prototypes

**Example scenarios:**
```bash
/create-feature Add user authentication with JWT
/create-feature Implement dark mode toggle
/create-feature Create admin dashboard with analytics
```

**Output:** Full workflow including:
1. Branch creation
2. Implementation plan
3. Code changes
4. Quality checks
5. Ready for staging

---

#### `/generate-tests` - Generate Comprehensive Test Suite

**Use when:**
- Need tests for existing components or functions
- Want comprehensive test coverage (unit, integration, edge cases)
- Setting up tests for a new module
- Improving test coverage for critical code
- Need test examples following project patterns

**Don't use for:**
- Running existing tests (just run `npm test`)
- Debugging test failures (use `/investigate-batch`)
- Simple one-off test cases (just write them directly)

**Example scenarios:**
```bash
# Generate tests for a component
/generate-tests src/components/Button.tsx
/generate-tests UserProfile

# Generate tests for a service
/generate-tests src/services/auth.service.ts

# Generate tests for utilities
/generate-tests src/utils/formatters.ts
```

**What it generates:**
- **Unit tests**: Individual function/method testing with various inputs
- **Integration tests**: Component interactions and API integrations
- **Edge cases**: Boundary values, error conditions, null/undefined handling
- **Mocks**: Proper mocking for external dependencies
- **Test utilities**: Helpers and factories as needed
- **Framework-specific**: Adapts to Jest, Vitest, React Testing Library, etc.

**Output:** Complete test file(s) with:
- Descriptive test names explaining behavior
- AAA pattern (Arrange, Act, Assert)
- Proper setup/teardown for isolation
- 80%+ coverage of critical paths
- Both happy path and error scenarios

**Testing frameworks supported:**
- **React**: React Testing Library + Jest/Vitest
- **Vue**: Vue Test Utils + Jest/Vitest
- **Angular**: TestBed + Jasmine/Jest
- **Node.js**: Jest/Vitest for APIs and services

---

#### `/create-architecture-documentation` - Generate Architecture Documentation

**Use when:**
- Starting a new project and need architecture documentation
- Onboarding new team members who need system overview
- Preparing for architecture review or audit
- Need to document existing undocumented system
- Creating technical debt analysis
- Preparing for system migration or modernization
- Need compliance or regulatory documentation

**Don't use for:**
- API documentation (use OpenAPI/Swagger)
- Code-level documentation (use JSDoc/TSDoc)
- User manuals (different purpose)
- Quick diagrams (just create them directly)

**Example scenarios:**
```bash
# Generate full architecture documentation suite
/create-architecture-documentation --full-suite

# Generate C4 model diagrams
/create-architecture-documentation --c4-model

# Generate Architecture Decision Records
/create-architecture-documentation --adr

# Generate Arc42 documentation template
/create-architecture-documentation --arc42

# Generate PlantUML diagrams
/create-architecture-documentation --plantuml

# Framework-specific documentation
/create-architecture-documentation microservices
/create-architecture-documentation next.js
```

**What it generates:**

**📊 Diagrams & Visualizations:**
- **C4 Model**: Context, Containers, Components, Code diagrams
- **PlantUML/Mermaid**: Diagram-as-code for version control
- **System Context**: High-level system overview and boundaries
- **Service Dependencies**: Microservices communication patterns
- **Data Flow**: Data processing pipelines and transformations
- **Deployment**: Infrastructure and deployment architecture

**📝 Documentation Frameworks:**
- **Arc42**: Comprehensive architecture template (12 sections)
- **ADRs**: Architecture Decision Records with rationale
- **System Context**: External systems and integrations
- **Component Documentation**: Internal module structure
- **Quality Attributes**: Performance, security, scalability

**🔒 Specialized Sections:**
- **Security Architecture**: Auth flows, threat model, trust zones
- **Data Architecture**: Database schemas, data governance
- **Deployment Architecture**: Infrastructure, containers, orchestration
- **Observability**: Monitoring, logging, alerting architecture
- **Disaster Recovery**: Backup, failover, business continuity

**🤖 Automation Setup:**
- Documentation pipeline and CI/CD integration
- Automated diagram generation from code annotations
- Documentation validation and consistency checking
- Version control and change management

**Output:** Complete documentation suite including:
- Markdown files with structured documentation
- Diagram files (`.puml`, `.mmd`, or visual formats)
- ADR templates and examples
- Documentation maintenance guidelines
- Team training materials

**Best suited for:**
- Enterprise applications needing formal documentation
- Microservices architectures with complex interactions
- Systems requiring compliance documentation
- Teams onboarding multiple developers
- Projects transitioning to new architecture

---

### 4. Code Review

#### `/review-staged` - Review Staged Changes Before Committing

**Use when:**
- Before committing changes
- Want automated code review
- Need quality checklist verification
- Ensuring code meets standards

**Don't use for:**
- Reviewing someone else's PR (review manually)
- Checking unstaged changes

**Example scenarios:**
```bash
# After staging changes
git add .
/review-staged
```

**Output:** Review report with:
- Summary of changes
- Issues found (if any)
- Suggestions for improvement
- Verdict (approve/needs changes)

---

### 5. Pull Requests

#### `/open-pr` - Create PR with Summary and Diagram

**Use when:**
- Ready to create pull request
- Need PR description generated
- Want Mermaid diagram of changes
- Following PR template standards

**Don't use for:**
- Draft PRs without completed work
- Before code is reviewed

**Example scenarios:**
```bash
# On feature branch with committed changes
/open-pr
```

**Output:** PR template with:
- Title and summary
- Mermaid diagram showing changes
- Testing instructions
- Reviewer checklist

---

### 6. Communication Style

#### `/trim` - Enable Concise Response Mode

**Use when:**
- Want shorter, more direct responses
- Prefer code over explanations
- Need quick answers
- Working in rapid iteration mode

**Don't use for:**
- Learning new concepts (need explanations)
- Complex analysis requiring context

**Example:**
```bash
/trim
```

**Output:** "Concise mode enabled." - All future responses become brief and code-focused

---

## Common Workflows

### Workflow 1: New Feature Development
```bash
1. /ultra-think [evaluate approach if complex decision needed]
2. /create-feature [description]
3. [implement feature]
4. /generate-tests [component-path]  # Add test coverage
5. /review-staged
6. git commit
7. /open-pr
```

### Workflow 2: Bug Fixing
```bash
1. /investigate [issue description]  # or /investigate-batch for simple bugs
2. [fix the bug]
3. /review-staged
4. git commit
5. /open-pr
```

### Workflow 3: Architectural Decision
```bash
1. /ultra-think [architectural question]
2. [review recommendations]
3. /create-feature [implement chosen approach]
4. [continue normal workflow]
```

### Workflow 4: Quick Fix
```bash
1. /investigate-batch [issue]
2. [apply fix]
3. git add . && git commit
```

### Workflow 5: Test-Driven Development (TDD)
```bash
1. /generate-tests [component-path]  # Generate test structure first
2. [implement functionality to pass tests]
3. /review-staged
4. git commit
```

### Workflow 6: Improving Test Coverage
```bash
1. npm run test:coverage  # Check current coverage
2. /generate-tests [low-coverage-file]  # Generate missing tests
3. [review and adjust generated tests]
4. npm run test  # Verify tests pass
5. git add . && git commit -m "test: improve coverage for [file]"
```

### Workflow 7: New Project Setup
```bash
1. [initialize project]
2. /create-architecture-documentation --full-suite
3. [review and customize documentation]
4. /create-feature [first feature]
5. [continue development]
```

### Workflow 8: System Migration/Modernization
```bash
1. /ultra-think [migration strategy]
2. /create-architecture-documentation --c4-model  # Document current state
3. /create-architecture-documentation --adr  # Document migration decisions
4. [implement migration incrementally]
5. [update architecture docs as you go]
```

### Workflow 9: Architecture Review Preparation
```bash
1. /create-architecture-documentation --arc42  # Comprehensive docs
2. /create-architecture-documentation --c4-model  # Visual diagrams
3. [review technical debt and improvements]
4. /ultra-think [evaluate architecture improvement opportunities]
5. [present to stakeholders]
```

---

## Tips

**Combine commands strategically:**
- Use `/ultra-think` before `/create-feature` for complex features
- Use `/create-architecture-documentation` early in project lifecycle
- Use `/generate-tests` after implementing new code for coverage
- Always use `/review-staged` before committing
- Use `/trim` when working in rapid iteration mode

**Match command to task complexity:**
- Simple = `/investigate-batch`, normal workflow
- Complex = `/investigate`, `/ultra-think`, full workflow
- Strategic = `/ultra-think` first, then implementation commands

**Documentation best practices:**
- Generate architecture docs at project start or during onboarding
- Update ADRs when making significant architectural changes
- Use C4 model for clear system visualization
- Keep documentation in version control alongside code
- Automate documentation updates where possible

**Test generation best practices:**
- Run `/generate-tests` after feature implementation
- Review generated tests and adjust to your needs
- Use TDD workflow for critical business logic
- Generate tests for untested legacy code incrementally

**Cost efficiency:**
- `/investigate-batch` is faster and cheaper than `/investigate`
- `/trim` reduces response length for quicker iterations
- Regular questions are fine for simple tasks

---

## Getting Help

- Press `Ctrl+P` in Claude Code to see all available commands
- Each command has inline help with examples
- Ask Claude: "When should I use /investigate vs /investigate-batch?"
