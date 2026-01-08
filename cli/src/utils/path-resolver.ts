import { homedir } from 'node:os';
import { join, resolve } from 'node:path';
import type { InstallTarget } from '../types/index.js';

export function resolveInstallPath(target: InstallTarget, configDirName = '.claude'): string {
  if (target === 'global') {
    return join(homedir(), configDirName);
  }
  return resolve(process.cwd(), configDirName);
}

export function getSkillPath(basePath: string, skillName: string, configDirName: string): string {
  // OpenCode uses 'skill', Claude Code uses 'skills'
  const skillDir = configDirName === '.opencode' ? 'skill' : 'skills';
  return join(basePath, skillDir, skillName, 'SKILL.md');
}

export function getCommandPath(basePath: string, commandName: string, configDirName: string): string {
  // OpenCode uses 'command', Claude Code uses 'commands'
  const commandDir = configDirName === '.opencode' ? 'command' : 'commands';
  return join(basePath, commandDir, `${commandName}.md`);
}

export function getBaseConfigPath(basePath: string, configFileName: string): string {
  return join(basePath, configFileName);
}
