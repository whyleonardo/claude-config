import type { AgentType } from '../types/index.js';

export interface AgentConfig {
  configFileName: string;
  agentName: string;
  commitMessagePrefix: string;
  configDirName: string; // Directory name (.claude or .opencode)
}

export function getAgentConfig(agent: AgentType): AgentConfig {
  switch (agent) {
    case 'claude-code':
      return {
        configFileName: 'CLAUDE.md',
        agentName: 'Claude Code',
        commitMessagePrefix: 'Claude Code',
        configDirName: '.claude',
      };
    case 'opencode':
      return {
        configFileName: 'AGENTS.md',
        agentName: 'OpenCode',
        commitMessagePrefix: 'OpenCode',
        configDirName: '.opencode',
      };
    case 'kiro':
      return {
        configFileName: 'KIRO.md',
        agentName: 'Kiro',
        commitMessagePrefix: 'Kiro',
        configDirName: '.kiro',
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
    /Do not include "(Claude Code|OpenCode|Kiro)" in commit messages/,
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
