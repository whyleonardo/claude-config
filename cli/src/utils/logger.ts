import pc from 'picocolors';

export function log(message: string): void {
  console.log(message);
}

export function success(message: string): void {
  console.log(pc.green(`✓ ${message}`));
}

export function error(message: string): void {
  console.error(pc.red(`✗ ${message}`));
}

export function warn(message: string): void {
  console.warn(pc.yellow(`⚠ ${message}`));
}

export function info(message: string): void {
  console.log(pc.blue(`ℹ ${message}`));
}

export function dim(message: string): string {
  return pc.dim(message);
}

export function bold(message: string): string {
  return pc.bold(message);
}
