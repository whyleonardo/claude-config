# Changelog

All notable changes to this template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [CLI 0.3.0] - 2026-01-08

### Added
- **Kiro Agent Support**
  - Added Kiro as a third AI agent option alongside Claude Code and OpenCode
  - New agent type: `'kiro'` in TypeScript type system
  - Kiro-specific configuration structure:
    - Config file: `KIRO.md`
    - Directory: `.kiro/`
    - Commit message prefix: `Kiro`
  - Interactive CLI now presents Kiro as selectable agent option
  - Created `templates/agents/kiro/BASE_CONFIG.md` template
  - Full integration with existing skills and commands system
  - Maintains architectural consistency with Claude Code and OpenCode patterns

### Changed
- Extended `AgentType` union type to include `'kiro'` for type safety
- Updated commit message customization regex to handle Kiro agent name
- Added "kiro" keyword to package.json for better discoverability

### Technical Details
- 4 files modified: 32 insertions, 2 deletions
- Zero breaking changes - purely additive feature
- Follows established agent configuration patterns
- Kiro shares the same skills system (typescript, react, software-engineering, etc.)
- Kiro shares the same commands system (create-feature, investigate, review-staged, etc.)
- Easy to extend with Kiro-specific customizations in the future

## [2.0.0] - 2026-01-08

### Removed
- **BREAKING: Bash installation script (`install.sh`)**
  - Removed legacy bash installer (446 lines)
  - Installation now exclusively through `npx @whyleonardo/agent-config`
  - Requirement: Node.js ≥18.0.0 now mandatory for installation
  - Users without Node.js must install manually by cloning repository
- **BREAKING: CI/CD Infrastructure**
  - Removed `.github/workflows/release.yml`
  - Removed entire `.github/` directory
  - GitHub Actions automation removed (will be reimplemented in future)
  - No automated releases until CI/CD is rebuilt
  - Manual release process required for now

### Changed
- **Installation is now CLI-only**
  - Single installation method for better maintenance and user experience
  - Interactive prompts provide superior UX compared to bash script
  - All users must have Node.js ≥18 installed
  - Simplified documentation focusing on CLI approach
- **Updated Documentation**
  - README.md simplified to CLI-only installation
  - Removed bash script comparison tables
  - Removed bash installation instructions
  - Updated repository structure diagrams
- **Implementation Documentation**
  - Updated IMPLEMENTATION.md to reflect CLI-only approach
  - Removed bash installer migration guides
  - Updated future enhancement roadmap
- **Multi-Agent Support Documentation**
  - Removed backward compatibility mentions
  - Updated migration path to focus on CLI templates system

### Migration Notes
Users previously using the bash installer must migrate to CLI:
- Old: `curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/agent-config@main/install.sh | bash`
- New: `npx @whyleonardo/agent-config`
- Manual alternative: Clone repository and copy `.claude/` directory

## [CLI 0.2.0] - 2026-01-08

### Added
- **OpenCode-Specific Folder Structure**
  - Proper support for OpenCode's official folder conventions
  - `.opencode/` directory (instead of `.claude/` for OpenCode)
  - `AGENTS.md` base config file (instead of `CLAUDE.md`)
  - `skill/` directory for skills (singular, not plural)
  - `command/` directory for commands (singular, not plural)
  - Agent-aware path generation in CLI

### Changed
- Updated path resolver to generate agent-specific folder structures
- Modified file writer to use correct paths based on selected agent
- Enhanced documentation with side-by-side structure comparison
- Updated OpenCode BASE_CONFIG.md template with proper AGENTS.md content

### Fixed
- OpenCode installations now follow official OpenCode documentation standards
- Folder structure matches OpenCode expectations from https://opencode.ai/docs/

## [1.4.0] - 2026-01-07

### Added
- **New Commands**
  - `/ultra-think` - Deep analysis and strategic decision-making command
    - Multi-perspective analysis (Technical, Business, User, System)
    - Generates 3-5 solution approaches with pros/cons
    - Comprehensive 2-4 page output with recommendations
    - Ideal for architectural decisions and complex problem-solving
  - `/generate-tests` - Comprehensive test suite generation
    - Generates unit, integration, and edge case tests
    - Supports Jest, Vitest, React Testing Library, Vue Test Utils
    - Creates test files with AAA pattern and proper setup/teardown
    - 80%+ coverage focus on critical paths
  - `/create-architecture-documentation` - Architecture documentation generator
    - Generates C4 Model diagrams (Context, Containers, Components, Code)
    - Creates Architecture Decision Records (ADRs)
    - Supports Arc42 comprehensive template
    - PlantUML/Mermaid diagram-as-code generation
    - Includes security, data, and deployment architecture docs

### Added
- **Comprehensive Command Documentation**
  - Created `.claude/commands/README.md` with detailed usage guide (509 lines)
  - Added Quick Reference table for all commands
  - Visual Command Decision Tree for choosing right command
  - Detailed sections for each command with:
    - When to use / When NOT to use
    - Real-world example scenarios
    - Expected output descriptions
    - Framework/tool support details
  - 9 common workflows including:
    - Feature development
    - Bug fixing
    - Test-driven development
    - Architecture review preparation
    - System migration/modernization
  - Best practices and tips for command usage
  - Cost efficiency guidance

### Changed
- **Updated README.md**
  - Added 3 new commands to commands table
  - Updated command descriptions for clarity
  - Added link to comprehensive Command Usage Guide
  - Total commands increased from 6 to 9

## [1.3.0] - 2026-01-07

### Changed
- **Enhanced all commands to follow create-feature pattern**
  - Restructured all 5 commands with consistent, comprehensive format
  - Added detailed workflow sections with numbered steps for each command
  - Included requirements sections referencing appropriate skills
  - Added clear output format specifications
  - Enhanced descriptions and use cases
  - Commands improved:
    - `/trim` - Expanded from 7 to 49 lines with structured workflow for concise communication
    - `/open-pr` - Enhanced with 6-step workflow, comprehensive quality checklist (26 to 81 lines)
    - `/investigate` - Transformed into 5-step investigation framework with structured output (33 to 94 lines)
    - `/investigate-batch` - Evolved into complete batch investigation workflow (13 to 86 lines)
    - `/review-staged` - Upgraded to 8-step review process with verdict system (25 to 140 lines)
  - Updated README.md command descriptions to reflect enhanced capabilities
  - Total command documentation expanded from ~104 lines to ~450 lines
  - All commands now follow the same pattern: frontmatter, header, description, workflow, requirements, output format

## [1.2.0] - 2026-01-07

### Changed
- **Refactored `/create-feature` command with comprehensive workflow**
  - Expanded from 25 lines to 65 lines with detailed guidance
  - Enhanced Planning Phase (9 points): Added complexity estimation, task breakdown, acceptance criteria definition
  - Comprehensive Implementation section (11 points): Type safety, modern standards, functional approach, component design, error handling, accessibility, performance, security, code organization
  - Added Framework-Specific guidance: Next.js Server Components, React Query for client-side data
  - New Quality Checks section (10 points): Type checking, linting, testing, accessibility validation, observability verification
  - Clear Stage Changes workflow with conventional commit format
  - Enhanced Requirements: References to CLAUDE-verbose.md, error boundaries, documentation approach
  - Aligned with all principles from CLAUDE.md and CLAUDE-verbose.md

## [1.1.0] - 2026-01-06

### Added
- **New comprehensive configuration file: `CLAUDE-verbose.md`**
  - Detailed coding guidelines and best practices (154 lines)
  - Principle-based approach without code examples for clarity
  - Comprehensive sections covering all aspects of development:
    - Core principles (type safety, explicitness, modern standards)
    - Modern JavaScript/TypeScript standards (ESM, const/let, destructuring, etc.)
    - Software engineering concepts (SOLID, DRY, separation of concerns)
    - React & JSX best practices (hooks, composition, memoization)
    - Framework-specific guidance for Next.js & React 19+
    - Error handling, debugging, and observability
    - Security, performance, and testing principles
    - Code organization and documentation standards
  - Prescriptive language using "Always prefer" format for clear guidance
  - Focused on React/Next.js ecosystem
  - Complements the minimal `CLAUDE.md` for users who want detailed guidelines
  - References skill modules for even deeper expertise

## [1.0.2] - 2026-01-06 (Legacy)

### Changed
- **Complete visual redesign of installation script with purple theme** (DEPRECATED: Bash installer removed in v2.0.0)
  - Added beautiful purple/magenta color scheme matching Claude Code aesthetics
  - Introduced elegant bordered header with stars (★) decoration
  - Added sectioned output with clear visual separators
  - Improved visual hierarchy with bold text and proper spacing
  - Added Unicode symbols for better visual feedback (✓, ✗, →, •)
  - Enhanced success message with bordered completion box
  - Better color-coded feedback throughout installation process
- Improved readability with structured sections:
  - Configuration section showing mode, version, and target path
  - Confirmation section with clear prompts
  - Download section with progress indicators
  - Installation section with step-by-step feedback
  - Final success section with next steps
- Enhanced user experience with dimmed/gray text for secondary information
- Added light purple highlights for important information

## [1.0.1] - 2026-01-06 (Legacy)

### Fixed
- Fix installation script not working when piped through curl (DEPRECATED: Bash installer removed in v2.0.0)
  - Added automatic detection of piped input using `[ ! -t 0 ]` check
  - Script now auto-confirms when stdin is not a terminal
  - Added `--yes` / `-y` flag to explicitly skip confirmation prompts
  - This fixes the issue where `.claude/` directory was not created in new repositories

### Changed
- Updated help text to include `--yes` flag documentation
- Improved confirmation prompt messages with better color coding

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
- Robust installation script (`install.sh`) with: (DEPRECATED: Removed in v2.0.0 - use CLI instead)
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
  - Multiple installation methods (CLI and manual) (Note: Bash script removed in v2.0.0)
  - jsDelivr CDN URLs for faster, globally cached downloads (Note: Legacy bash installer)
  - GitHub raw URLs as alternative (Note: Legacy bash installer)
  - Update instructions with detailed explanations
  - Global vs local installation comparison
  - Version pinning guide with examples (Note: Legacy bash installer)
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

[Unreleased]: https://github.com/whyleonardo/agent-config/compare/v0.3.0...HEAD
[CLI 0.3.0]: https://github.com/whyleonardo/agent-config/compare/v0.2.0...v0.3.0
[2.0.0]: https://github.com/whyleonardo/agent-config/compare/v1.4.0...v2.0.0
[1.4.0]: https://github.com/whyleonardo/agent-config/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/whyleonardo/agent-config/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/whyleonardo/agent-config/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/whyleonardo/agent-config/compare/v1.0.2...v1.1.0
[1.0.2]: https://github.com/whyleonardo/agent-config/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/whyleonardo/agent-config/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/whyleonardo/agent-config/releases/tag/v1.0.0
