export type AgentType = 'claude-code' | 'opencode' | 'kiro';

export type InstallTarget = 'project' | 'global';

export type ConfigApproach = 'preset' | 'custom';

export type PresetType = 'fullstack-react' | 'backend-api' | 'frontend-only' | 'minimal';

export type SkillType = 'typescript' | 'react' | 'software-engineering' | 'writing' | 'reviewing-code';

export type CommandType = 
  | 'create-feature' 
  | 'investigate' 
  | 'investigate-batch' 
  | 'open-pr' 
  | 'review-staged' 
  | 'trim'
  | 'ultra-think'
  | 'create-architecture-documentation'
  | 'generate-tests';

export type CommitStyle = 'conventional' | 'semantic' | 'custom';

export interface ConfigSelection {
  agent: AgentType;
  target: InstallTarget;
  approach: ConfigApproach;
  preset?: PresetType;
  skills: SkillType[];
  commands: CommandType[];
  commitStyle: CommitStyle;
  customGitRules?: string;
}

export interface Preset {
  name: string;
  description: string;
  skills: SkillType[];
  commands: CommandType[];
  commitStyle: CommitStyle;
}

export interface ContentFile {
  path: string;
  content: string;
}

export interface FetchedContent {
  skills: Map<SkillType, string>;
  commands: Map<CommandType, string>;
  baseConfig: string;
}
