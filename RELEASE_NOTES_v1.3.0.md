# Release v1.3.0 - Enhanced Commands

Release Date: 2026-01-07

## What's Changed

### Enhanced All Commands
This release brings comprehensive improvements to all 5 custom commands, making them follow the same structured pattern as the `/create-feature` command introduced in v1.2.0.

**Key Improvements:**
- ✨ Restructured all commands with consistent, comprehensive format
- 📝 Added detailed workflow sections with numbered steps for each command
- 📋 Included requirements sections referencing appropriate skills
- 🎯 Added clear output format specifications
- 📖 Enhanced descriptions and use cases

**Commands Improved:**

1. **`/trim`** - Expanded from 7 to 49 lines
   - Structured workflow for concise communication
   - Clear guidelines for token-efficient responses

2. **`/open-pr`** - Enhanced from 26 to 81 lines
   - 6-step workflow process
   - Comprehensive quality checklist
   - Better PR formatting and documentation

3. **`/investigate`** - Transformed from 33 to 94 lines
   - 5-step investigation framework
   - Structured output format
   - Detailed analysis guidelines

4. **`/investigate-batch`** - Evolved from 13 to 86 lines
   - Complete batch investigation workflow
   - Cost-efficient approach for multiple issues
   - Standardized output format

5. **`/review-staged`** - Upgraded from 25 to 140 lines
   - 8-step review process
   - Verdict system for change recommendations
   - Comprehensive review checklist

**Documentation:**
- Updated README.md command descriptions to reflect enhanced capabilities
- Total command documentation expanded from ~104 lines to ~450 lines
- All commands now follow consistent pattern: frontmatter, header, description, workflow, requirements, output format

## Installation

### Quick Install (Recommended)
```bash
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/claude-config@v1.3.0/install.sh | bash
```

### Update Existing Installation
```bash
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/claude-config@v1.3.0/install.sh | bash -s -- --update
```

### Install Specific Version
```bash
# Using jsDelivr CDN
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/claude-config@main/install.sh | bash -s -- --version v1.3.0

# Or for global installation
curl -fsSL https://cdn.jsdelivr.net/gh/whyleonardo/claude-config@main/install.sh | bash -s -- --global --version v1.3.0
```

## Full Changelog
https://github.com/whyleonardo/claude-config/compare/v1.2.0...v1.3.0
