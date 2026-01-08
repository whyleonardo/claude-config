# Agent Config

Personal configuration repository for AI agents ([OpenCode](https://opencode.ai/), Claude, etc.), containing custom commands, skills, and workflow settings.

[![GitHub](https://img.shields.io/badge/GitHub-agent--config-blue?style=flat-square&logo=github)](https://github.com/whyleonardo/agent-config)
[![npm](https://img.shields.io/badge/npm-%40whyleonardo%2Fagent--config-red?style=flat-square&logo=npm)](https://www.npmjs.com/package/@whyleonardo/agent-config)

## 🚀 Quick Start

### Installation

```bash
# Run the interactive CLI
npx @whyleonardo/agent-config
```

**Benefits:**
- Interactive prompts guide you through setup
- Choose from preset configurations or customize
- Select only the skills/commands you need
- Beautiful terminal UI
- Always fetches latest version
- Automatic backup of existing configurations

**Requirements:**
- Node.js ≥18.0.0
- npm (comes with Node.js)

[📖 CLI Documentation](./cli/README.md)

## ✨ What's Included

### 📂 Structure

```
.claude/
├── CLAUDE.md           # Global settings and workflow preferences
├── commands/           # Custom slash commands
│   ├── create-feature.md
│   ├── investigate.md
│   ├── investigate-batch.md
│   ├── open-pr.md
│   ├── review-staged.md
│   └── trim.md
└── skills/            # Coding guidelines and best practices
    ├── react/
    ├── reviewing-code/
    ├── software-engineering/
    ├── typescript/
    └── writing/
```

### 🎯 Global Settings (CLAUDE.md)

Core principles applied across all projects:

- **Git Workflow**: Conventional commits, no "Claude Code" in messages
- **Code Quality Focus**: 
  - End-to-end type safety
  - Error monitoring/observability
  - Automated testing
  - Readability/maintainability

### ⚡ Custom Commands

| Command | Description | Trigger |
|---------|-------------|---------|
| `create-feature` | Scaffold new features following best practices | `/create-feature` |
| `investigate` | Deep dive into bugs or issues | `/investigate` |
| `investigate-batch` | Quick investigation for simple issues | `/investigate-batch` |
| `open-pr` | Create pull requests with proper context | `/open-pr` |
| `review-staged` | Review staged changes before committing | `/review-staged` |
| `trim` | Enable concise response mode | `/trim` |

### 🛠️ Skills

Detailed coding guidelines that agents can reference:

| Skill | Description |
|-------|-------------|
| `software-engineering` | Core engineering principles, design patterns, SOLID |
| `typescript` | TypeScript/JavaScript standards and best practices |
| `react` | React/Next.js patterns, hooks, component architecture |
| `reviewing-code` | Code review guidelines, checklists, and standards |
| `writing` | Technical writing and documentation standards |

## 🎨 CLI Preset Configurations

The interactive CLI offers preset configurations:

### Full-Stack React
Perfect for React/Next.js full-stack projects
- Skills: TypeScript, React, Software Engineering, Code Review
- Commands: create-feature, investigate, review-staged, open-pr

### Backend API
Optimized for Node.js backend development
- Skills: TypeScript, Software Engineering, Code Review
- Commands: create-feature, investigate, review-staged, trim

### Frontend Only
Frontend-focused with React
- Skills: TypeScript, React, Writing
- Commands: create-feature, review-staged, open-pr

### Minimal
Essentials only for any TypeScript project
- Skills: TypeScript, Software Engineering
- Commands: investigate

## 📚 CLI Installation Guide

```bash
# Install and run
npx @whyleonardo/agent-config

# Follow the prompts:
# 1. Choose AI agent (Claude Code / OpenCode)
# 2. Choose installation target (project/global)
# 3. Select a preset or customize
# 4. Pick skills and commands
# 5. Configure git workflow
```

[Full CLI Documentation →](./cli/README.md)

## 🔄 Updating

```bash
# Run the CLI again - it will detect and backup existing config
npx @whyleonardo/agent-config
```

## 🌍 Local vs Global Installation

### Local Installation (`./.claude/`)

**Use when:**
- Working in a team with shared coding standards
- Want configuration versioned with your project
- Need project-specific customizations

**Characteristics:**
- Located in project root
- Committed to version control
- Shared with team members
- Overrides global settings

### Global Installation (`~/.claude/`)

**Use when:**
- Want consistent settings across all projects
- Working on personal projects
- Need default configuration for new projects

**Characteristics:**
- Located in home directory
- Personal preferences
- Not committed to version control
- Used as fallback when no local config exists

## 🛠️ Development

### CLI Development

```bash
cd cli/
npm install
npm run dev        # Watch mode
npm run build      # Build for production
npm start          # Run built CLI
```

### Repository Structure

```
agent-config/
├── .claude/           # Template content (source of truth)
├── cli/              # NPM package source
│   ├── src/          # TypeScript source
│   ├── dist/         # Built files
│   └── package.json
└── README.md         # This file
```

## 🤝 Contributing

Contributions welcome! Feel free to:

- Open an [issue](https://github.com/whyleonardo/agent-config/issues) for bugs or features
- Submit a [pull request](https://github.com/whyleonardo/agent-config/pulls) with improvements
- Share your custom commands and skills

## 📖 Learn More

- [OpenCode Documentation](https://opencode.ai/docs)
- [Custom Commands Guide](https://opencode.ai/docs/custom-commands)
- [Skills Documentation](https://opencode.ai/docs/skills)
- [Configuration Reference](https://opencode.ai/docs/configuration)

## 📝 License

MIT

---

**Repository**: [github.com/whyleonardo/agent-config](https://github.com/whyleonardo/agent-config)

**NPM Package**: [@whyleonardo/agent-config](https://www.npmjs.com/package/@whyleonardo/agent-config)

**Issues & Support**: [github.com/whyleonardo/agent-config/issues](https://github.com/whyleonardo/agent-config/issues)
