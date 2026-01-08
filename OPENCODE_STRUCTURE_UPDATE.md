# OpenCode Folder Structure Implementation

## Overview

Updated the CLI to properly follow OpenCode's official folder structure convention, which differs from Claude Code's structure.

## Changes Made

### 1. Agent-Specific Directory Names

**OpenCode** now uses:
- Directory: `.opencode/` (instead of `.claude/`)
- Base config: `AGENTS.md` (instead of `CLAUDE.md`)
- Skills directory: `skill/` (instead of `skills/`)
- Commands directory: `command/` (instead of `commands/`)

**Claude Code** continues to use:
- Directory: `.claude/`
- Base config: `CLAUDE.md`
- Skills directory: `skills/`
- Commands directory: `commands/`

### 2. Updated Files

#### Core CLI Files

1. **cli/src/core/agent-config.ts**
   - Already had `configDirName` field
   - OpenCode config now uses `.opencode` directory name
   - Config file name is `AGENTS.md` for OpenCode

2. **cli/src/utils/path-resolver.ts**
   - Updated `getSkillPath()` to use agent-specific directory names
   - Updated `getCommandPath()` to use agent-specific directory names
   - Both functions now accept `configDirName` parameter
   - OpenCode: `skill/` and `command/`
   - Claude Code: `skills/` and `commands/`

3. **cli/src/core/file-writer.ts**
   - Updated to pass `configDirName` to path resolver functions
   - Ensures skills and commands are written to correct locations

4. **cli/src/commands/init.ts**
   - Already using `configDirName` for backup and install paths
   - Updated summary output to show correct config file name

5. **cli/src/prompts/init-prompts.ts**
   - Already showing agent-specific directory names in prompts

#### Template Files

6. **templates/agents/opencode/BASE_CONFIG.md**
   - Updated to reference OpenCode documentation
   - Mentions skills are loaded on-demand
   - More appropriate content for `AGENTS.md` file

#### Documentation

7. **MULTI_AGENT_SUPPORT.md**
   - Updated "Supported Agents" section with full path details
   - Added directory structure for both agents

8. **AGENT_SUPPORT_SUMMARY.md**
   - Updated with complete folder structure for both agents

9. **cli/README.md**
   - Split "What Gets Installed" into two sections
   - Shows both Claude Code and OpenCode structures

## Folder Structure Comparison

### Claude Code
```
.claude/
├── CLAUDE.md
├── skills/
│   └── <name>/
│       └── SKILL.md
└── commands/
    └── <name>.md
```

### OpenCode
```
.opencode/
├── AGENTS.md
├── skill/
│   └── <name>/
│       └── SKILL.md
└── command/
    └── <name>.md
```

## Testing

Verified path generation with test script:

```bash
cd cli && node -e "
const { getAgentConfig } = require('./dist/core/agent-config.js');
const { getSkillPath, getCommandPath } = require('./dist/utils/path-resolver.js');

const opencode = getAgentConfig('opencode');
console.log('OpenCode Skill:', getSkillPath('/test/.opencode', 'typescript', '.opencode'));
// Output: /test/.opencode/skill/typescript/SKILL.md

console.log('OpenCode Command:', getCommandPath('/test/.opencode', 'create-feature', '.opencode'));
// Output: /test/.opencode/command/create-feature.md

const claude = getAgentConfig('claude-code');
console.log('Claude Skill:', getSkillPath('/test/.claude', 'typescript', '.claude'));
// Output: /test/.claude/skills/typescript/SKILL.md

console.log('Claude Command:', getCommandPath('/test/.claude', 'create-feature', '.claude'));
// Output: /test/.claude/commands/create-feature.md
"
```

✅ All paths generate correctly for both agents

## Build Status

✅ TypeScript compilation successful
✅ No errors or warnings

## References

- OpenCode Skills Documentation: https://opencode.ai/docs/skills/
- OpenCode Commands Documentation: https://opencode.ai/docs/commands/
- OpenCode Rules (AGENTS.md): https://opencode.ai/docs/rules/

## Impact

- ✅ **Backward Compatible**: Claude Code users unaffected
- ✅ **Standards Compliant**: OpenCode follows official conventions
- ✅ **Type Safe**: All changes maintain TypeScript type safety
- ✅ **Tested**: Path generation verified for both agents
- ✅ **Documented**: All documentation updated

## Next Steps

1. Commit changes
2. Test CLI with actual OpenCode installation
3. Verify generated structure matches OpenCode expectations
4. Update version number if needed
