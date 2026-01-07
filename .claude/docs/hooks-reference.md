# Hooks Configuration Reference

Hooks allow you to automate actions at specific points in Claude Code's workflow. They can run shell commands or use LLM prompts for intelligent decisions.

## Hook Types

### Command Hooks (`type: "command"`)
Execute bash commands at specific events.

### Prompt Hooks (`type: "prompt"`)
Use LLM for context-aware decisions.

## Available Events

| Event | When It Fires | Can Block |
|-------|---------------|-----------|
| `SessionStart` | Session begins | No |
| `SessionEnd` | Session ends | No |
| `UserPromptSubmit` | User sends message | Yes |
| `PreToolUse` | Before tool execution | Yes |
| `PostToolUse` | After tool completes | No |
| `Stop` | Claude considers stopping | Yes |
| `SubagentStop` | Sub-agent considers stopping | Yes |
| `Notification` | Claude sends notification | No |
| `PreCompact` | Before context compaction | No |

## Configuration Location

Add hooks to `.claude/settings.json`:

```json
{
  "hooks": {
    "EventName": [
      {
        "matcher": "ToolPattern",
        "hooks": [
          {"type": "command", "command": "script"}
        ]
      }
    ]
  }
}
```

## Common Hook Patterns

### 1. Protect Sensitive Files

Prevent editing of .env files and .git directory:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'FILE=$(echo \"$HOOK_INPUT\" | jq -r \".tool_input.file_path // empty\"); if [[ \"$FILE\" == *\".env\"* ]] || [[ \"$FILE\" == \".git/\"* ]]; then echo \"Cannot modify sensitive files\" >&2; exit 2; fi'"
          }
        ]
      }
    ]
  }
}
```

### 2. Auto-Format Code After Edits

Run formatter automatically:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/format-code.sh"
          }
        ]
      }
    ]
  }
}
```

**Script (~/.claude/hooks/format-code.sh):**
```bash
#!/bin/bash
FILE=$(echo "$HOOK_INPUT" | jq -r '.tool_input.file_path // empty')

[[ -z "$FILE" ]] && exit 0

case "$FILE" in
  *.ts|*.tsx|*.js|*.jsx)
    prettier --write "$FILE" &> /dev/null || true
    ;;
  *.py)
    ruff format "$FILE" &> /dev/null || true
    ;;
esac
```

### 3. Session Context Injection

Add context at session start:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "cat .claude/session-context.txt"
          }
        ]
      }
    ]
  }
}
```

**File (.claude/session-context.txt):**
```
Current Sprint: Authentication Refactor
Focus: Migrating from sessions to JWT
Branch: feature/jwt-auth
Important: Don't modify legacy auth code in /old-auth
```

### 4. Run Tests Before Git Commits

Ensure tests pass before committing:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/pre-commit-test.sh"
          }
        ]
      }
    ]
  }
}
```

**Script:**
```bash
#!/bin/bash
COMMAND=$(echo "$HOOK_INPUT" | jq -r '.tool_input.command // empty')

if [[ "$COMMAND" == git*commit* ]]; then
  echo "Running tests before commit..." >&2
  if npm test &>/dev/null; then
    echo "✅ Tests passed" >&2
    exit 0
  else
    echo "❌ Tests failed - blocking commit" >&2
    exit 2
  fi
fi

exit 0
```

### 5. Audit Logging

Log all tool usage:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'echo \"$(date -Iseconds) $TOOL_NAME: $(echo \\\"$HOOK_INPUT\\\" | jq -c .)\" >> ~/.claude/audit.log'"
          }
        ]
      }
    ]
  }
}
```

### 6. Detect Secrets Before Committing

Scan for hardcoded secrets:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/detect-secrets.sh"
          }
        ]
      }
    ]
  }
}
```

**Script:**
```bash
#!/bin/bash
FILE=$(echo "$HOOK_INPUT" | jq -r '.tool_input.file_path // empty')
NEW_CONTENT=$(echo "$HOOK_INPUT" | jq -r '.tool_input.new_string // .tool_input.content // empty')

# Check for common secret patterns
if echo "$NEW_CONTENT" | grep -iE '(api[_-]?key|password|secret|token)["\s:=]+\S{16,}' &>/dev/null; then
  echo "⚠️  Potential secret detected in $FILE" >&2
  echo "Please review and use environment variables instead" >&2
  exit 2
fi

exit 0
```

### 7. Validate Commit Messages

Enforce conventional commits:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/validate-commit.sh"
          }
        ]
      }
    ]
  }
}
```

**Script:**
```bash
#!/bin/bash
COMMAND=$(echo "$HOOK_INPUT" | jq -r '.tool_input.command // empty')

if [[ "$COMMAND" == git*commit*-m* ]]; then
  MSG=$(echo "$COMMAND" | sed -n 's/.*-m[[:space:]]*["'"'"']\([^"'"'"']*\)["'"'"'].*/\1/p')

  # Check conventional commit format
  if [[ ! "$MSG" =~ ^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: ]]; then
    echo "❌ Commit message must follow format: type(scope): message" >&2
    echo "Valid types: feat, fix, docs, style, refactor, test, chore" >&2
    exit 2
  fi
fi

exit 0
```

## Hook Input/Output

### Input (via stdin as JSON)
```json
{
  "sessionId": "abc123",
  "tool_name": "Edit",
  "tool_input": {
    "file_path": "/src/app.ts",
    "old_string": "...",
    "new_string": "..."
  },
  "project_dir": "/home/user/project"
}
```

### Output (exit codes)
- `0` - Success, continue
- `2` - Block the action
- Other - Non-blocking error (logged)

## Environment Variables Available

- `$HOOK_INPUT` - JSON input (use `jq` to parse)
- `$TOOL_NAME` - Name of the tool being used
- `$CLAUDE_PROJECT_DIR` - Project directory

## Security Best Practices

⚠️ **Critical:** You are responsible for hook commands. They can modify or delete files.

### Always:
- Quote variables: `FILE="$HOOK_INPUT"`
- Validate paths before operations
- Use absolute paths
- Sanitize inputs with `jq`
- Test hooks before deploying

### Never:
- Use `eval` with user input
- Trust unvalidated variables
- Use relative paths without validation
- Execute arbitrary commands

## Debugging Hooks

```bash
# Run Claude with debug mode
claude --debug

# Check hook configuration
> /hooks

# Test hook manually
echo '{"tool_name":"Edit","tool_input":{"file_path":".env"}}' | bash your-hook-script.sh

# View logs
tail -f ~/.claude/logs/claude.log
```

## Hook Recipes

See the comprehensive hook recipes in the Claude Code guide for more patterns:
- Auto-formatting
- ESLint auto-fix
- Performance profiling
- Token usage tracking
- And more...

## References

- [Official Hooks Documentation](https://docs.claude.com/en/docs/claude-code/hooks)
- [Hooks Guide](https://docs.claude.com/en/docs/claude-code/hooks-guide)
