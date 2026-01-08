import type { SkillType, CommandType, FetchedContent, AgentType } from '../types/index.js';
import { error, warn } from './logger.js';

const GITHUB_RAW_BASE = 'https://raw.githubusercontent.com/whyleonardo/agent-config/main';

export async function fetchFromGitHub(agent: AgentType): Promise<FetchedContent> {
  const skills = new Map<SkillType, string>();
  const commands = new Map<CommandType, string>();
  let baseConfig = '';

  try {
    // Fetch base config for the specific agent
    baseConfig = await fetchFile(`templates/agents/${agent}/BASE_CONFIG.md`);

    // Fetch skills (agnostic - same for all agents)
    const skillTypes: SkillType[] = [
      'typescript',
      'react',
      'software-engineering',
      'writing',
      'reviewing-code',
    ];

    for (const skill of skillTypes) {
      try {
        const content = await fetchFile(`templates/skills/${skill}/SKILL.md`);
        skills.set(skill, content);
      } catch (err) {
        warn(`Failed to fetch skill: ${skill}`);
      }
    }

    // Fetch commands (agnostic - same for all agents)
    const commandTypes: CommandType[] = [
      'create-feature',
      'investigate',
      'investigate-batch',
      'open-pr',
      'review-staged',
      'trim',
      'ultra-think',
      'create-architecture-documentation',
      'generate-tests',
    ];

    for (const command of commandTypes) {
      try {
        const content = await fetchFile(`templates/commands/${command}.md`);
        commands.set(command, content);
      } catch (err) {
        warn(`Failed to fetch command: ${command}`);
      }
    }

    return { skills, commands, baseConfig };
  } catch (err) {
    error('Failed to fetch content from GitHub');
    throw err;
  }
}

async function fetchFile(path: string): Promise<string> {
  const url = `${GITHUB_RAW_BASE}/${path}`;
  
  try {
    const response = await fetch(url);
    
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }
    
    return await response.text();
  } catch (err) {
    throw new Error(`Failed to fetch ${path}: ${err instanceof Error ? err.message : 'Unknown error'}`);
  }
}

export async function checkGitHubConnection(): Promise<boolean> {
  try {
    const response = await fetch(`${GITHUB_RAW_BASE}/templates/agents/claude-code/BASE_CONFIG.md`, { method: 'HEAD' });
    return response.ok;
  } catch {
    return false;
  }
}
