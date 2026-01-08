import { homedir } from 'node:os';
import { join, resolve } from 'node:path';
import type { InstallTarget } from '../types/index.js';

export function resolveInstallPath(target: InstallTarget): string {
  if (target === 'global') {
    return join(homedir(), '.claude');
  }
  return resolve(process.cwd(), '.claude');
}

export function getSkillPath(basePath: string, skillName: string): string {
  return join(basePath, 'skills', skillName, 'SKILL.md');
}

export function getCommandPath(basePath: string, commandName: string): string {
  return join(basePath, 'commands', `${commandName}.md`);
}

export function getBaseConfigPath(basePath: string): string {
  return join(basePath, 'CLAUDE.md');
}
