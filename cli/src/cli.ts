#!/usr/bin/env node

import { initCommand } from './commands/init.js';

async function main() {
  const args = process.argv.slice(2);
  const command = args[0];

  switch (command) {
    case 'init':
    case undefined:
      await initCommand();
      break;
    case '--version':
    case '-v':
      console.log('0.2.0');
      break;
    case '--help':
    case '-h':
      showHelp();
      break;
    default:
      console.error(`Unknown command: ${command}`);
      showHelp();
      process.exit(1);
  }
}

function showHelp() {
  console.log(`
Agent Config CLI

Usage:
  agent-config [command]

Commands:
  init        Initialize agent configuration (default)
  
Options:
  -h, --help     Show this help message
  -v, --version  Show version number

Examples:
  npx @whyleonardo/agent-config
  npx @whyleonardo/agent-config init

Learn more: https://github.com/whyleonardo/agent-config
  `);
}

main().catch((err) => {
  console.error('Error:', err);
  process.exit(1);
});
