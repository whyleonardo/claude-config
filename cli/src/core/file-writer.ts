import { mkdir, writeFile } from 'node:fs/promises';
import { dirname } from 'node:path';
import { existsSync } from 'node:fs';
import type { ConfigSelection, FetchedContent } from '../types/index.js';
import { resolveInstallPath, getSkillPath, getCommandPath, getBaseConfigPath } from '../utils/path-resolver.js';
import { success, info } from '../utils/logger.js';
import { getAgentConfig, customizeBaseConfigForAgent } from './agent-config.js';

export async function writeConfiguration(
  selection: ConfigSelection,
  content: FetchedContent
): Promise<void> {
  const basePath = resolveInstallPath(selection.target);
  const agentConfig = getAgentConfig(selection.agent);

  // Ensure base directory exists
  if (!existsSync(basePath)) {
    await mkdir(basePath, { recursive: true });
  }

  // Write base config
  const baseConfigPath = getBaseConfigPath(basePath);
  const customizedBaseConfig = customizeBaseConfigForAgent(
    content.baseConfig,
    selection.agent,
    selection.commitStyle
  );
  
  // Add custom git rules if provided
  let finalBaseConfig = customizedBaseConfig;
  if (selection.customGitRules) {
    finalBaseConfig += `\n\n## Custom Git Rules\n${selection.customGitRules}\n`;
  }
  
  await writeFile(baseConfigPath, finalBaseConfig, 'utf-8');
  info(`Created ${agentConfig.configFileName}`);

  // Write skills
  for (const skill of selection.skills) {
    const skillContent = content.skills.get(skill);
    if (skillContent) {
      const skillPath = getSkillPath(basePath, skill);
      await mkdir(dirname(skillPath), { recursive: true });
      await writeFile(skillPath, skillContent, 'utf-8');
      info(`Created skill: ${skill}`);
    }
  }

  // Write commands
  for (const command of selection.commands) {
    const commandContent = content.commands.get(command);
    if (commandContent) {
      const commandPath = getCommandPath(basePath, command);
      await mkdir(dirname(commandPath), { recursive: true });
      await writeFile(commandPath, commandContent, 'utf-8');
      info(`Created command: ${command}`);
    }
  }

  success(`Configuration installed to: ${basePath}`);
}

export async function backupExistingConfig(target: 'project' | 'global'): Promise<string | null> {
  const basePath = resolveInstallPath(target);
  
  if (!existsSync(basePath)) {
    return null;
  }

  const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
  const backupPath = `${basePath}-backup-${timestamp}`;
  
  const { cp } = await import('node:fs/promises');
  await cp(basePath, backupPath, { recursive: true });
  
  return backupPath;
}
