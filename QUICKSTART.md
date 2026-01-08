# Quick Start Guide

## For End Users

### Option 1: Interactive CLI (Recommended)
```bash
npx @whyleonardo/agent-config
```

Follow the prompts to customize your setup!

### Option 2: Bash Script
```bash
# Local install
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/agent-config@main/install.sh | bash

# Global install
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/agent-config@main/install.sh | bash -s -- --global
```

## For Developers

### Setup Development Environment

```bash
# Clone the repository
git clone https://github.com/whyleonardo/agent-config.git
cd agent-config

# Navigate to CLI directory
cd cli

# Install dependencies
npm install

# Build the project
npm run build

# Test locally
npm start
# or
node dist/cli.js --help
```

### Development Workflow

```bash
# Watch mode for development
npm run dev

# Build for production
npm run build

# Run built CLI
npm start

# Test help command
node dist/cli.js --help

# Test version
node dist/cli.js --version
```

### Project Structure

```
agent-config/
├── .claude/           # Template content (edit these to change defaults)
├── cli/              # NPM package source
│   └── src/
│       ├── commands/     # CLI commands
│       ├── core/         # Core functionality
│       ├── presets/      # Preset configurations
│       ├── prompts/      # Interactive prompts
│       ├── types/        # TypeScript types
│       ├── utils/        # Utility functions
│       └── cli.ts        # Entry point
└── install.sh        # Bash installer (legacy)
```

### Making Changes

**To modify presets:**
Edit `cli/src/presets/index.ts`

**To change prompts:**
Edit `cli/src/prompts/init-prompts.ts`

**To add new commands:**
1. Create file in `cli/src/commands/`
2. Import and register in `cli/src/cli.ts`

**To modify template content:**
Edit files in `.claude/` directory

### Testing Your Changes

```bash
cd cli
npm run build
npm start
```

### Publishing (Maintainers Only)

```bash
# Update version in cli/package.json
# Then build and publish
cd cli
npm run build
npm publish
```

## Common Tasks

### Add a New Skill

1. Create skill file in `.claude/skills/new-skill/SKILL.md`
2. Add skill type to `cli/src/types/index.ts`
3. Add to fetch list in `cli/src/utils/github-fetcher.ts`
4. Add to prompt options in `cli/src/prompts/init-prompts.ts`

### Add a New Command

1. Create command file in `.claude/commands/new-command.md`
2. Add command type to `cli/src/types/index.ts`
3. Add to fetch list in `cli/src/utils/github-fetcher.ts`
4. Add to prompt options in `cli/src/prompts/init-prompts.ts`

### Add a New Preset

1. Add preset definition in `cli/src/presets/index.ts`
2. Add to prompt options in `cli/src/prompts/init-prompts.ts`

## Troubleshooting

**Build errors:**
```bash
cd cli
rm -rf dist node_modules
npm install
npm run build
```

**TypeScript errors:**
Check `cli/tsconfig.json` and ensure all types are properly defined

**Runtime errors:**
Enable verbose logging in the code or use Node.js inspector:
```bash
node --inspect dist/cli.js
```

## Resources

- [Clack Prompts Docs](https://github.com/natemoo-re/clack)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [Node.js ESM Guide](https://nodejs.org/api/esm.html)
