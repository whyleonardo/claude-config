import * as clack from '@clack/prompts';
import type { ConfigSelection, InstallTarget, ConfigApproach, PresetType, SkillType, CommandType, CommitStyle, AgentType } from '../types/index.js';
import { listPresets, getPreset } from '../presets/index.js';
import { resolveInstallPath } from '../utils/path-resolver.js';
import { getAgentConfig } from '../core/agent-config.js';
import { existsSync } from 'node:fs';

export async function promptInitFlow(): Promise<ConfigSelection> {
  clack.intro('Agent Config Setup');

  // 1. Agent selection
  const agent = await clack.select<{ value: AgentType; label: string; hint: string }[], AgentType>({
    message: 'Which AI agent are you configuring?',
    options: [
      { value: 'claude-code', label: 'Claude Code', hint: 'Anthropic Claude for coding' },
      { value: 'opencode', label: 'OpenCode', hint: 'Open source AI coding agent' },
    ],
  });

  if (clack.isCancel(agent)) {
    clack.cancel('Installation cancelled');
    process.exit(0);
  }

  const agentConfig = getAgentConfig(agent);

  // 2. Installation target
  const target = await clack.select<{ value: InstallTarget; label: string }[], InstallTarget>({
    message: 'Where would you like to install the configuration?',
    options: [
      { value: 'project', label: `Project (${agentConfig.configDirName}/) - Local to this project` },
      { value: 'global', label: `Global (~/${agentConfig.configDirName}/) - All projects` },
    ],
  });

  if (clack.isCancel(target)) {
    clack.cancel('Installation cancelled');
    process.exit(0);
  }

  // Check if existing config exists
  const installPath = resolveInstallPath(target, agentConfig.configDirName);
  if (existsSync(installPath)) {
    const shouldContinue = await clack.confirm({
      message: `Existing configuration found at ${installPath}. Continue?`,
      initialValue: false,
    });

    if (clack.isCancel(shouldContinue) || !shouldContinue) {
      clack.cancel('Installation cancelled');
      process.exit(0);
    }
  }

  // 3. Configuration approach
  const approach = await clack.select<{ value: ConfigApproach; label: string }[], ConfigApproach>({
    message: 'How would you like to configure?',
    options: [
      { value: 'preset', label: 'Start with a preset (recommended)' },
      { value: 'custom', label: 'Custom selection' },
    ],
  });

  if (clack.isCancel(approach)) {
    clack.cancel('Installation cancelled');
    process.exit(0);
  }

  let selectedPreset: PresetType | undefined;
  let skills: SkillType[] = [];
  let commands: CommandType[] = [];
  let commitStyle: CommitStyle = 'conventional';

  if (approach === 'preset') {
    // 4a. Select preset
    const presets = listPresets();
    const presetChoice = await clack.select<{ value: PresetType; label: string; hint: string }[], PresetType>({
      message: 'Select a preset:',
      options: [
        { value: 'fullstack-react', label: 'Full-Stack React', hint: presets[0].description },
        { value: 'backend-api', label: 'Backend API', hint: presets[1].description },
        { value: 'frontend-only', label: 'Frontend Only', hint: presets[2].description },
        { value: 'minimal', label: 'Minimal', hint: presets[3].description },
      ],
    });

    if (clack.isCancel(presetChoice)) {
      clack.cancel('Installation cancelled');
      process.exit(0);
    }

    selectedPreset = presetChoice;
    const preset = getPreset(presetChoice);
    if (preset) {
      skills = preset.skills;
      commands = preset.commands;
      commitStyle = preset.commitStyle;
    }

    // Ask if they want to customize
    const customize = await clack.confirm({
      message: 'Would you like to customize this preset?',
      initialValue: false,
    });

    if (clack.isCancel(customize)) {
      clack.cancel('Installation cancelled');
      process.exit(0);
    }

    if (customize) {
      // Allow customization
      const customSkills = await promptSkillSelection(skills);
      const customCommands = await promptCommandSelection(commands);
      skills = customSkills;
      commands = customCommands;
    }
  } else {
    // 4b. Custom selection
    skills = await promptSkillSelection([]);
    commands = await promptCommandSelection([]);
  }

  // 5. Git workflow preferences
  const commitStyleResult = await clack.select<{ value: CommitStyle; label: string }[], CommitStyle>({
    message: 'Git commit style preference:',
    options: [
      { value: 'conventional', label: 'Conventional Commits (recommended)' },
      { value: 'semantic', label: 'Semantic Commits' },
      { value: 'custom', label: 'Custom' },
    ],
    initialValue: commitStyle,
  });

  if (clack.isCancel(commitStyleResult)) {
    clack.cancel('Installation cancelled');
    process.exit(0);
  }

  commitStyle = commitStyleResult;

  return {
    agent,
    target,
    approach,
    preset: selectedPreset,
    skills,
    commands,
    commitStyle,
  };
}

async function promptSkillSelection(initial: SkillType[]): Promise<SkillType[]> {
  const selected = await clack.multiselect<{ value: SkillType; label: string; hint: string }[], SkillType>({
    message: 'Select skills to include:',
    options: [
      { value: 'typescript', label: 'TypeScript', hint: 'TypeScript/JavaScript best practices' },
      { value: 'react', label: 'React', hint: 'React/Next.js patterns' },
      { value: 'software-engineering', label: 'Software Engineering', hint: 'Core engineering principles' },
      { value: 'writing', label: 'Writing', hint: 'Technical writing standards' },
      { value: 'reviewing-code', label: 'Code Review', hint: 'Code review guidelines' },
    ],
    initialValues: initial,
    required: false,
  });

  if (clack.isCancel(selected)) {
    clack.cancel('Installation cancelled');
    process.exit(0);
  }

  return selected;
}

async function promptCommandSelection(initial: CommandType[]): Promise<CommandType[]> {
  const selected = await clack.multiselect<{ value: CommandType; label: string; hint: string }[], CommandType>({
    message: 'Select commands to include:',
    options: [
      { value: 'create-feature', label: 'create-feature', hint: 'Scaffold new features' },
      { value: 'investigate', label: 'investigate', hint: 'Deep dive into bugs' },
      { value: 'investigate-batch', label: 'investigate-batch', hint: 'Quick investigation' },
      { value: 'open-pr', label: 'open-pr', hint: 'Create pull requests' },
      { value: 'review-staged', label: 'review-staged', hint: 'Review staged changes' },
      { value: 'trim', label: 'trim', hint: 'Concise response mode' },
      { value: 'ultra-think', label: 'ultra-think', hint: 'Deep strategic analysis' },
      { value: 'create-architecture-documentation', label: 'create-architecture-docs', hint: 'Generate architecture docs' },
      { value: 'generate-tests', label: 'generate-tests', hint: 'Generate comprehensive tests' },
    ],
    initialValues: initial,
    required: false,
  });

  if (clack.isCancel(selected)) {
    clack.cancel('Installation cancelled');
    process.exit(0);
  }

  return selected;
}
