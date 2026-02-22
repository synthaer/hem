/**
 * @synthaer/hem — Hedonistic Engineering Method
 * Node wrapper around HEM shell scripts.
 */

import { execSync } from 'child_process';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const BIN = join(__dirname, 'bin', 'hem.sh');

export const version = '4.0.0';

export function hem(command, args = [], options = {}) {
  const cmd = `bash "${BIN}" ${command} ${args.join(' ')}`;
  const result = execSync(cmd, {
    cwd: options.cwd || process.cwd(),
    encoding: 'utf-8',
    env: { ...process.env, ...options.env },
    timeout: options.timeout || 30000,
  });
  return result.trim();
}

export function classify(projectDir = '.') {
  return hem('classify', [projectDir]);
}

export function backfill(mode = '--dry-run') {
  return hem('backfill', [mode]);
}

export function listProfiles() {
  return hem('profile', ['list']);
}

export function showProfile() {
  return hem('profile', ['show']);
}

export default { version, hem, classify, backfill, listProfiles, showProfile };
