# Changelog

All notable changes to this template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2026-01-06

### Added

#### Configuration
- Initial release of Claude Code configuration template
- Global settings in `CLAUDE.md`:
  - Git workflow preferences (conventional commits, no "Claude Code" in messages)
  - Core code quality principles (type-safety, observability, testing, maintainability)
  - References to skill modules for detailed guidelines

#### Custom Commands
- `create-feature` - Scaffold new features following best practices
- `investigate` - Deep dive analysis for bugs and issues
- `investigate-batch` - Batch investigation of multiple issues
- `open-pr` - Create pull requests with proper context and formatting
- `review-staged` - Review staged changes before committing
- `trim` - Cleanup and optimize code

#### Skills
- `software-engineering` - Core engineering principles and design patterns
- `typescript` - TypeScript/JavaScript coding standards and best practices
- `react` - React/Next.js patterns, hooks, and component architecture
- `reviewing-code` - Comprehensive code review guidelines and checklists
- `writing` - Technical writing and documentation standards

#### Installation
- Robust installation script (`install.sh`) with:
  - Local installation support (`./.claude/`)
  - Global installation support (`~/.claude/`)
  - Version pinning capability
  - Automatic backups to `.claude-backups/` directory
  - Backup retention (keeps last 3 backups)
  - Colored diff preview using `colordiff` (with fallback to `diff`)
  - Update functionality (`--update` flag)
  - Confirmation prompts for safety
  - Comprehensive error handling
  - Support for flags: `--local`, `--global`, `--update`, `--version`, `--help`

#### Documentation
- Comprehensive README with:
  - Quick start guide for new and existing projects
  - Multiple installation methods (GitHub template, install script, manual)
  - jsDelivr CDN URLs for faster, globally cached downloads
  - GitHub raw URLs as alternative
  - Update instructions with detailed explanations
  - Global vs local installation comparison
  - Version pinning guide with examples
  - Troubleshooting section covering common issues
  - Contributing guidelines
  - Links to Claude Code documentation
- CHANGELOG for tracking template updates
- Detailed inline documentation in commands and skills
- GitHub badges for template and version
- Tables for better readability of commands, skills, and options

#### GitHub Integration
- Template repository setup for easy new project creation
- GitHub CLI support for streamlined workflows
- Release versioning with semantic versioning
- Topics for discoverability: `claude-code`, `opencode`, `template`, `developer-tools`, `configuration`, `dotfiles`

[Unreleased]: https://github.com/whyleonardo/claude-config/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/whyleonardo/claude-config/releases/tag/v1.0.0
