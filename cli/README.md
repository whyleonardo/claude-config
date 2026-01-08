# Agent Config CLI

Interactive CLI tool for setting up AI agent configurations. Choose from preset configurations or customize your own setup with skills and commands tailored to your workflow.

## 🚀 Quick Start

```bash
# Run interactively (recommended)
npx @whyleonardo/agent-config

# Or install globally
npm install -g @whyleonardo/agent-config
agent-config
```

## ✨ Features

- **Interactive Setup**: Beautiful CLI prompts powered by [@clack/prompts](https://github.com/natemoo-re/clack)
- **Preset Configurations**: Pre-configured setups for common workflows
- **Customizable**: Mix and match skills and commands to fit your needs
- **GitHub-Powered**: Always fetches the latest configuration templates
- **Backup Support**: Automatically backs up existing configurations
- **Local or Global**: Install to project or apply globally

## 📦 Installation Options

### 🎯 Local (Project-Specific)

Install to current project's `.claude/` directory:

```bash
npx @whyleonardo/agent-config
# Select "Project" when prompted
```

### 🌍 Global (All Projects)

Install to `~/.claude/` for all projects:

```bash
npx @whyleonardo/agent-config
# Select "Global" when prompted
```

## 🎨 Preset Configurations

### Full-Stack React
Complete setup for React/Next.js full-stack development
- **Skills**: TypeScript, React, Software Engineering, Code Review
- **Commands**: create-feature, investigate, review-staged, open-pr

### Backend API
Optimized for Node.js backend and API development
- **Skills**: TypeScript, Software Engineering, Code Review
- **Commands**: create-feature, investigate, review-staged, trim

### Frontend Only
Focused on frontend development with React
- **Skills**: TypeScript, React, Writing
- **Commands**: create-feature, review-staged, open-pr

### Minimal
Bare essentials for any TypeScript project
- **Skills**: TypeScript, Software Engineering
- **Commands**: investigate

## 🛠️ Available Skills

| Skill | Description |
|-------|-------------|
| `typescript` | TypeScript/JavaScript best practices and patterns |
| `react` | React/Next.js component architecture and hooks |
| `software-engineering` | Core engineering principles and design patterns |
| `writing` | Technical writing and documentation standards |
| `reviewing-code` | Code review guidelines and checklists |

## ⚡ Available Commands

| Command | Description |
|---------|-------------|
| `create-feature` | Scaffold new features following best practices |
| `investigate` | Deep dive into bugs or issues with thorough analysis |
| `investigate-batch` | Quick investigation for simple issues |
| `open-pr` | Create pull requests with proper context |
| `review-staged` | Review staged changes before committing |
| `trim` | Enable concise response mode |

## 🎭 Interactive Flow

```
┌  Agent Config Setup
│
◇  Where would you like to install the configuration?
│  ● Project (.claude/) - Local to this project
│  ○ Global (~/.claude/) - All projects
│
◇  How would you like to configure?
│  ● Start with a preset (recommended)
│  ○ Custom selection
│
◇  Select a preset:
│  ● Full-Stack React
│  ○ Backend API
│  ○ Frontend Only
│  ○ Minimal
│
◇  Would you like to customize this preset?
│  Yes / No
│
◇  Git commit style preference:
│  ● Conventional Commits (recommended)
│  ○ Semantic Commits
│  ○ Custom
│
└  Setup complete!
```

## 📚 What Gets Installed

### Claude Code Structure
```
.claude/
├── CLAUDE.md              # Global settings and workflow preferences
├── commands/              # Custom slash commands
│   ├── create-feature.md
│   ├── investigate.md
│   ├── investigate-batch.md
│   ├── open-pr.md
│   ├── review-staged.md
│   └── trim.md
└── skills/               # Coding guidelines and best practices
    ├── react/
    │   └── SKILL.md
    ├── reviewing-code/
    │   └── SKILL.md
    ├── software-engineering/
    │   └── SKILL.md
    ├── typescript/
    │   └── SKILL.md
    └── writing/
        └── SKILL.md
```

### OpenCode Structure
```
.opencode/
├── AGENTS.md              # Project instructions and rules
├── command/               # Custom slash commands
│   ├── create-feature.md
│   ├── investigate.md
│   ├── investigate-batch.md
│   ├── open-pr.md
│   ├── review-staged.md
│   └── trim.md
└── skill/                # Coding guidelines and best practices
    ├── react/
    │   └── SKILL.md
    ├── reviewing-code/
    │   └── SKILL.md
    ├── software-engineering/
    │   └── SKILL.md
    ├── typescript/
    │   └── SKILL.md
    └── writing/
        └── SKILL.md
```

## 🔄 Backup & Safety

The CLI automatically creates backups when overwriting existing configurations:

- **Local installs**: `.claude-backup-<timestamp>/`
- **Global installs**: `~/.claude-backup-<timestamp>/`

## 🌐 Requirements

- Node.js ≥ 18.0.0
- Internet connection (fetches templates from GitHub)

## 🛡️ Usage

```bash
# Interactive setup (default)
npx @whyleonardo/agent-config

# Or explicitly call init
npx @whyleonardo/agent-config init

# Show help
npx @whyleonardo/agent-config --help

# Show version
npx @whyleonardo/agent-config --version
```

## 🔗 Related

- **Template Repo**: [whyleonardo/agent-config](https://github.com/whyleonardo/agent-config)
- **OpenCode Docs**: [opencode.ai/docs](https://opencode.ai/docs)

## 📝 License

MIT

## 🤝 Contributing

Issues and PRs welcome at [github.com/whyleonardo/agent-config](https://github.com/whyleonardo/agent-config)
