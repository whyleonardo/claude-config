# MCP (Model Context Protocol) Integration Reference

MCP connects Claude Code to external data sources and tools, enabling access to databases, APIs, cloud services, and more.

## What is MCP?

MCP allows Claude Code to:
- Access external data (Google Drive, Slack, Notion, etc.)
- Query databases directly
- Integrate with APIs and services
- Extend capabilities beyond the local filesystem

## Configuration

MCP servers are configured in `.claude/agents/mcp.json`:

```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@scope/mcp-server-package"],
      "env": {
        "API_KEY": "${API_KEY}"
      }
    }
  }
}
```

## Common MCP Servers

### GitHub Integration

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**Usage:**
```
> "Create an issue on GitHub for the bug we just found"
> "List open PRs in the repository"
> "Search the codebase on GitHub for authentication patterns"
```

### Slack Integration

```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-slack"],
      "env": {
        "SLACK_BOT_TOKEN": "${SLACK_BOT_TOKEN}",
        "SLACK_TEAM_ID": "T01234567"
      }
    }
  }
}
```

**Usage:**
```
> "Search Slack for conversations about the API redesign"
> "Send a message to #dev-team about the deployment"
```

### Google Drive Integration

```json
{
  "mcpServers": {
    "gdrive": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-gdrive"],
      "env": {
        "GDRIVE_CREDENTIALS_PATH": "${HOME}/.gdrive-credentials.json"
      }
    }
  }
}
```

**Usage:**
```
> "Search Google Drive for Q4 planning documents"
> "Read the project requirements from Drive"
```

### PostgreSQL Database

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-postgres",
        "${DATABASE_URL}"
      ]
    }
  }
}
```

**Usage:**
```
> "Show all users created in the last week"
> "Query the database for orders with status 'pending'"
```

### Notion Integration

```json
{
  "mcpServers": {
    "notion": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-notion"],
      "env": {
        "NOTION_API_KEY": "${NOTION_API_KEY}"
      }
    }
  }
}
```

**Usage:**
```
> "Search Notion for sprint planning notes"
> "Create a new page in the project documentation"
```

## OAuth Authentication

Some MCP servers use OAuth for secure authentication:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "oauth": {
        "provider": "github",
        "scopes": ["repo", "read:user"]
      }
    }
  }
}
```

Claude Code will guide you through OAuth flow on first use. Use `/mcp` command to authenticate.

## Environment Variables

### Using .env Files

Create `.env` file (add to `.gitignore`):
```env
GITHUB_TOKEN=ghp_your_token_here
DATABASE_URL=postgresql://user:pass@localhost/db
SLACK_BOT_TOKEN=xoxb-your-token
```

Create `.env.example` template (commit to git):
```env
GITHUB_TOKEN=
DATABASE_URL=
SLACK_BOT_TOKEN=
```

### Variable Expansion

MCP config supports `${VAR}` expansion:
```json
{
  "env": {
    "API_KEY": "${MY_API_KEY}",
    "FALLBACK": "${VAR:-default_value}"
  }
}
```

## Managing MCP Servers

### Enable/Disable Servers

```json
{
  "enableAllProjectMcpServers": true,
  "enabledMcpjsonServers": ["github", "postgres"],
  "disabledMcpjsonServers": ["experimental-server"]
}
```

### Enterprise Configuration

```json
{
  "useEnterpriseMcpConfigOnly": true,
  "allowedMcpServers": ["approved-server-1", "approved-server-2"]
}
```

## Tool Usage

Once configured, MCP tools appear with pattern `mcp__<server>__<tool>`:

```
# List MCP servers and tools
> /mcp

# Claude automatically uses MCP tools when relevant
> "Search our Slack for API discussions"
# Uses: mcp__slack__search_messages

> "Query database for user statistics"
# Uses: mcp__postgres__query
```

## Troubleshooting

### Server Not Showing

1. Check configuration syntax:
   ```bash
   cat .claude/agents/mcp.json | jq .
   ```

2. Verify environment variables:
   ```bash
   echo $API_KEY
   ```

3. Restart Claude Code after config changes

### Tools Not Available

1. Check server actually started:
   ```bash
   ps aux | grep mcp
   ```

2. Check debug logs:
   ```bash
   claude --debug
   tail -f ~/.claude/logs/claude.log
   ```

3. Verify OAuth authentication:
   ```
   > /mcp
   # Follow authentication prompts
   ```

### OAuth Issues

1. Use `/mcp` command (not direct URL)
2. Clear OAuth cache if issues persist:
   ```bash
   rm -rf ~/.claude/oauth-cache
   ```

## Custom MCP Marketplace

Add custom or private MCP servers:

```json
{
  "extraKnownMarketplaces": [
    {
      "name": "company-internal",
      "type": "github",
      "url": "https://github.com/company/mcp-servers"
    }
  ]
}
```

## Security Considerations

### API Keys
- Never commit API keys to git
- Use environment variables
- Rotate keys regularly
- Use least-privilege access

### Database Access
- Use read-only credentials when possible
- Limit query permissions
- Validate all inputs
- Log all queries

### OAuth Scopes
- Request minimum necessary scopes
- Review permissions carefully
- Revoke unused tokens

## Available Official MCP Servers

```bash
# Core Services
@modelcontextprotocol/server-github         # GitHub integration
@modelcontextprotocol/server-slack          # Slack integration
@modelcontextprotocol/server-gdrive         # Google Drive
@modelcontextprotocol/server-postgres       # PostgreSQL
@modelcontextprotocol/server-sqlite         # SQLite
@modelcontextprotocol/server-filesystem     # Extended file access

# More servers available in MCP marketplace
```

## Example Workflows

### Database-Backed Development
```
> "Query the users table to understand the schema"
> "Find all users with unverified emails"
> "Based on the query results, implement the verification endpoint"
```

### Documentation Research
```
> "Search Notion for API guidelines"
> "Read the authentication docs from Drive"
> "Implement auth following the documented patterns"
```

### Team Communication
```
> "Search Slack for decisions about the database migration"
> "Based on the Slack discussion, proceed with the migration plan"
```

## References

- [Official MCP Documentation](https://docs.claude.com/en/docs/claude-code/mcp)
- [MCP Server Registry](https://github.com/modelcontextprotocol/servers)
- [MCP Protocol Specification](https://modelcontextprotocol.io)
