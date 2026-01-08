# Repository Naming Note

## Current Status

The repository is currently named `claude-config` on GitHub, but the NPM package and documentation reference `agent-config`.

## What Works Now

✅ CLI is fully functional
✅ Fetches from `whyleonardo/claude-config` (current repo)
✅ All features implemented and working
✅ Package name: `@whyleonardo/agent-config`

## Before Publishing to NPM

You have two options:

### Option 1: Keep `claude-config` repo name
- Update all `agent-config` references to `claude-config` in:
  - README.md
  - cli/README.md
  - cli/src/cli.ts
- Consider renaming NPM package to `@whyleonardo/claude-config`

### Option 2: Rename repo to `agent-config`
- Rename GitHub repo: `claude-config` → `agent-config`
- Update `cli/src/utils/github-fetcher.ts` back to `agent-config`
- Update `install.sh` if it has hardcoded repo names
- All documentation already references `agent-config`

## Recommendation

**Option 2** is recommended since:
- Most documentation already uses `agent-config`
- "Agent Config" is more generic (works for any AI agent)
- "Claude Config" is specific to Claude
- NPM package is already named `@whyleonardo/agent-config`

## Steps to Rename on GitHub

1. Go to repo settings
2. Scroll to "Danger Zone"
3. Click "Change repository name"
4. Enter `agent-config`
5. Confirm the change

GitHub will automatically redirect old URLs for a while.

## After Renaming

Update `cli/src/utils/github-fetcher.ts`:
```typescript
const GITHUB_RAW_BASE = 'https://raw.githubusercontent.com/whyleonardo/agent-config/main';
```

Then rebuild:
```bash
cd cli
npm run build
```
