# Claude Code Settings

Personal configuration repository for [Claude Code](https://opencode.ai/) (formerly OpenCode), containing custom commands, skills, and global settings.

[![GitHub Template](https://img.shields.io/badge/Template-Use%20This-blue?style=flat-square&logo=github)](https://github.com/whyleonardo/claude-config/generate)
[![Version](https://img.shields.io/github/v/release/whyleonardo/claude-config?style=flat-square)](https://github.com/whyleonardo/claude-config/releases)

## 🚀 Quick Start

**For New Projects:**
```bash
# Use GitHub template
gh repo create my-project --template whyleonardo/claude-config --public
```

**For Existing Projects:**
```bash
# One-liner installation (jsDelivr CDN)
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/claude-config@main/install.sh | bash
```

## 📦 Installation

### Method 1: GitHub Template (New Projects)

#### Via GitHub Web Interface
1. Click the **["Use this template"](https://github.com/whyleonardo/claude-config/generate)** button at the top of this repository
2. Create your new repository with the template
3. Clone your new repository and start coding

#### Via GitHub CLI
```bash
gh repo create my-project --template whyleonardo/claude-config --public
cd my-project
```

### Method 2: Install Script (Existing Projects)

#### Local Installation (Project-specific)

Install to current project's `.claude/` directory:

```bash
# Using jsDelivr CDN (recommended - faster, globally cached)
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/claude-config@main/install.sh | bash

# Or using GitHub raw (alternative)
curl -fsSL https://raw.githubusercontent.com/whyleonardo/claude-config/main/install.sh | bash

# Or download and run locally
wget https://cdn.jsdelivr.net/gh/whyleonardo/claude-config@main/install.sh
chmod +x install.sh
./install.sh --local
```

#### Global Installation (All Projects)

Install to `~/.claude/` to apply settings globally:

```bash
# Using jsDelivr CDN
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/claude-config@main/install.sh | bash -s -- --global

# Or using GitHub raw
curl -fsSL https://raw.githubusercontent.com/whyleonardo/claude-config/main/install.sh | bash -s -- --global
```

#### Install Specific Version

Pin to a specific release version:

```bash
# Install v1.0.0
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/claude-config@v1.0.0/install.sh | bash

# Or specify version flag
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/claude-config@main/install.sh | bash -s -- --version v1.0.0
```

#### Installation Options

The install script supports the following flags:

| Flag | Description |
|------|-------------|
| `--local` or `-l` | Install to `./.claude/` in current directory (default) |
| `--global` or `-g` | Install to `~/.claude/` for all projects |
| `--update` or `-u` | Update existing installation |
| `--version TAG` or `-v TAG` | Install specific version (e.g., `v1.0.0`) |
| `--help` or `-h` | Show help message |

**Examples:**
```bash
# Local installation
./install.sh --local

# Global installation
./install.sh --global

# Update existing local installation
./install.sh --local --update

# Install specific version globally
./install.sh --global --version v1.0.0
```

### Method 3: Manual Git Commands

For users who prefer explicit commands:

```bash
# Clone the repository
git clone --depth 1 https://github.com/whyleonardo/claude-config.git /tmp/claude-config

# Copy to your project (local)
cp -r /tmp/claude-config/.claude /path/to/your/project/

# Or copy globally
cp -r /tmp/claude-config/.claude ~/

# Cleanup
rm -rf /tmp/claude-config
```

## 🔄 Updating

Keep your configuration in sync with the latest template updates:

```bash
# Update local installation
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/claude-config@main/install.sh | bash -s -- --update

# Update global installation
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/claude-config@main/install.sh | bash -s -- --global --update
```

### What Happens During Update

The install script will:
1. **Backup** your existing configuration to `.claude-backups/<timestamp>/`
2. **Show a diff** of changes between your current and new configuration
3. **Ask for confirmation** before proceeding
4. **Install** the latest version
5. **Keep your last 3 backups** automatically (older backups are removed)

### Backup Location

- **Local installs**: `.claude-backups/` in your project directory
- **Global installs**: `~/.claude-backups/` in your home directory

## 📚 What's Included

### Structure

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

### Global Settings (`CLAUDE.md`)

Core principles applied across all projects:

- **Git Workflow**: Conventional commits, no "Claude Code" in commit messages
- **Code Quality Focus**: 
  - End-to-end type safety
  - Error monitoring/observability
  - Automated testing
  - Readability/maintainability

### Custom Commands

Located in `.claude/commands/`:

| Command | Description |
|---------|-------------|
| `create-feature` | Scaffold new features following best practices |
| `investigate` | Deep dive into bugs or issues |
| `investigate-batch` | Batch investigation of multiple issues |
| `open-pr` | Create pull requests with proper context |
| `review-staged` | Review staged changes before committing |
| `trim` | Cleanup and optimize code |

### Skills

Detailed coding guidelines in `.claude/skills/`:

| Skill | Description |
|-------|-------------|
| `software-engineering` | Core engineering principles and patterns |
| `typescript` | TypeScript/JavaScript standards and best practices |
| `react` | React/Next.js patterns and component architecture |
| `reviewing-code` | Code review guidelines and checklists |
| `writing` | Technical writing and documentation standards |

## 🏷️ Version Pinning

This template follows [Semantic Versioning](https://semver.org/). You can pin to specific versions for stability:

```bash
# Install specific version
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/claude-config@v1.0.0/install.sh | bash

# Or use the version flag
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/claude-config@main/install.sh | bash -s -- --version v1.0.0
```

**Benefits of version pinning:**
- Ensures consistency across team members
- Prevents unexpected changes from updates
- Allows controlled upgrades
- Useful for CI/CD pipelines

See [Releases](https://github.com/whyleonardo/claude-config/releases) for available versions.

## 🌍 Global vs Local Installation

### Local Installation (`./.claude/`)

**Use when:**
- Working in a team with shared coding standards
- Want configuration versioned with your project
- Need project-specific customizations

**Characteristics:**
- Located in project root: `./.claude/`
- Committed to version control
- Shared with team members
- Overrides global settings

### Global Installation (`~/.claude/`)

**Use when:**
- Want consistent settings across all projects
- Working on personal projects
- Need default configuration for new projects

**Characteristics:**
- Located in home directory: `~/.claude/`
- Personal preferences
- Not committed to version control
- Used as fallback when no local config exists

**Recommendation:** Use global for personal preferences, local for team standards.

## 🛠️ Troubleshooting

### Install script fails with "Permission denied"

Make the script executable:
```bash
chmod +x install.sh
./install.sh
```

### Diff preview not showing colors

Install `colordiff`:
```bash
# Ubuntu/Debian
sudo apt-get install colordiff

# macOS
brew install colordiff

# Fedora
sudo dnf install colordiff
```

### Backup directory filling up

The script automatically keeps only the last 3 backups. To manually clean up:
```bash
# Remove all backups
rm -rf .claude-backups/*

# Or for global installation
rm -rf ~/.claude-backups/*
```

### Configuration not being detected by Claude Code

Ensure the `.claude/` directory is in the right location:
- **Local**: At the root of your project
- **Global**: In your home directory (`~/.claude/`)

Restart Claude Code after installation:
```bash
# If using VS Code extension
# Reload window: Ctrl/Cmd + Shift + P → "Reload Window"
```

### Git clone fails with "fatal: Remote branch not found"

The specified version tag doesn't exist. Check available versions:
```bash
# List all tags
git ls-remote --tags https://github.com/whyleonardo/claude-config.git

# Or visit releases page
# https://github.com/whyleonardo/claude-config/releases
```

### Script fails with "git: command not found"

Install Git:
```bash
# Ubuntu/Debian
sudo apt-get install git

# macOS
brew install git

# Fedora
sudo dnf install git
```

## 📝 Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed list of changes in each version.

## 🤝 Contributing

Suggestions and improvements are welcome! Feel free to:
- Open an [issue](https://github.com/whyleonardo/claude-config/issues) for bugs or feature requests
- Submit a [pull request](https://github.com/whyleonardo/claude-config/pulls) with improvements
- Share your custom commands and skills

## 📖 Learn More

- [Claude Code Documentation](https://opencode.ai/docs)
- [Custom Commands Guide](https://opencode.ai/docs/custom-commands)
- [Skills Documentation](https://opencode.ai/docs/skills)
- [Configuration Reference](https://opencode.ai/docs/configuration)

---

**Repository:** [github.com/whyleonardo/claude-config](https://github.com/whyleonardo/claude-config)

**Issues & Support:** [github.com/whyleonardo/claude-config/issues](https://github.com/whyleonardo/claude-config/issues)
