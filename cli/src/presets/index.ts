import type { Preset } from '../types/index.js';

export const presets: Record<string, Preset> = {
  'fullstack-react': {
    name: 'Full-Stack React',
    description: 'Complete setup for React/Next.js full-stack development',
    skills: ['typescript', 'react', 'software-engineering', 'reviewing-code'],
    commands: ['create-feature', 'investigate', 'review-staged', 'open-pr', 'ultra-think', 'generate-tests'],
    commitStyle: 'conventional',
  },
  'backend-api': {
    name: 'Backend API',
    description: 'Optimized for Node.js backend and API development',
    skills: ['typescript', 'software-engineering', 'reviewing-code'],
    commands: ['create-feature', 'investigate', 'review-staged', 'trim', 'create-architecture-documentation', 'generate-tests'],
    commitStyle: 'conventional',
  },
  'frontend-only': {
    name: 'Frontend Only',
    description: 'Focused on frontend development with React',
    skills: ['typescript', 'react', 'writing'],
    commands: ['create-feature', 'review-staged', 'open-pr', 'generate-tests'],
    commitStyle: 'conventional',
  },
  'minimal': {
    name: 'Minimal',
    description: 'Bare essentials for any TypeScript project',
    skills: ['typescript', 'software-engineering'],
    commands: ['investigate', 'investigate-batch'],
    commitStyle: 'conventional',
  },
};

export function getPreset(type: string): Preset | undefined {
  return presets[type];
}

export function listPresets(): Preset[] {
  return Object.values(presets);
}
