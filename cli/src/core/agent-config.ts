import type { AgentType } from '../types/index.js';

export interface AgentConfig {
  configFileName: string;
  agentName: string;
  commitMessagePrefix: string;
}

export function getAgentConfig(agent: AgentType): AgentConfig {
  switch (agent) {
    case 'claude-code':
      return {
        configFileName: 'CLAUDE.md',
        agentName: 'Claude Code',
        commitMessagePrefix: 'Claude Code',
      };
    case 'opencode':
      return {
        configFileName: 'CLAUDE.md', // OpenCode also uses .claude/CLAUDE.md
        agentName: 'OpenCode',
        commitMessagePrefix: 'OpenCode',
      };
  }
}

export function customizeBaseConfigForAgent(
  baseConfig: string,
  agent: AgentType,
  commitStyle: string
): string {
  const agentConfig = getAgentConfig(agent);
  let customized = baseConfig;

  // Replace agent name in "Do not include X in commit messages"
  customized = customized.replace(
    /Do not include "(Claude Code|OpenCode)" in commit messages/,
    `Do not include "${agentConfig.commitMessagePrefix}" in commit messages`
  );

  // Customize commit style if needed
  if (commitStyle === 'semantic') {
    customized = customized.replace(
      'Use conventional commits',
      'Use semantic commits'
    );
  }

  return customized;
}
