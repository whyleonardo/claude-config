import * as clack from '@clack/prompts';
import { promptInitFlow } from '../prompts/init-prompts.js';
import { fetchFromGitHub, checkGitHubConnection } from '../utils/github-fetcher.js';
import { writeConfiguration, backupExistingConfig } from '../core/file-writer.js';
import { error, success, info } from '../utils/logger.js';
import { existsSync } from 'node:fs';
import { resolveInstallPath } from '../utils/path-resolver.js';
import { getAgentConfig } from '../core/agent-config.js';

export async function initCommand(): Promise<void> {
  try {
    // Check GitHub connection
    const spinner = clack.spinner();
    spinner.start('Checking GitHub connection...');
    
    const isOnline = await checkGitHubConnection();
    
    if (!isOnline) {
      spinner.stop('Failed to connect to GitHub');
      error('Cannot reach GitHub repository. Please check your internet connection.');
      process.exit(1);
    }
    
    spinner.stop('Connected to GitHub');

    // Run interactive prompts
    const selection = await promptInitFlow();
    const agentConfig = getAgentConfig(selection.agent);

    // Check if backup is needed
    const installPath = resolveInstallPath(selection.target, agentConfig.configDirName);
    if (existsSync(installPath)) {
      spinner.start('Creating backup of existing configuration...');
      const backupPath = await backupExistingConfig(selection.target, agentConfig.configDirName);
      if (backupPath) {
        spinner.stop('Backup created');
        info(`Backup saved to: ${backupPath}`);
      }
    }

    // Fetch content from GitHub
    spinner.start('Fetching configuration from GitHub...');
    const content = await fetchFromGitHub(selection.agent);
    spinner.stop('Content fetched successfully');

    // Write configuration files
    spinner.start('Installing configuration...');
    await writeConfiguration(selection, content);
    spinner.stop('Configuration installed');

    // Show summary
    clack.outro('Setup complete!');
    
    console.log('');
    success('Agent configuration has been installed successfully');
    console.log('');
    info('What was installed:');
    console.log(`  • Agent: ${agentConfig.agentName}`);
    console.log(`  • Base configuration (${agentConfig.configFileName})`);
    console.log(`  • ${selection.skills.length} skill(s): ${selection.skills.join(', ')}`);
    console.log(`  • ${selection.commands.length} command(s): ${selection.commands.join(', ')}`);
    console.log('');
    
    if (selection.target === 'global') {
      info('Next steps:');
      console.log('  1. This configuration will apply to all your projects');
      console.log(`  2. Restart ${agentConfig.agentName} to apply changes`);
    } else {
      info('Next steps:');
      console.log(`  1. Commit the ${agentConfig.configDirName}/ directory to version control`);
      console.log(`  2. Restart ${agentConfig.agentName} to apply changes`);
    }
    
    console.log('');
    info(`Installation location: ${installPath}`);
    console.log('');

  } catch (err) {
    error(`Installation failed: ${err instanceof Error ? err.message : 'Unknown error'}`);
    process.exit(1);
  }
}
