# Global agent instructions

This file is the single source of truth for every coding agent on this machine.
It is symlinked into place for Claude, Codex, and opencode, so edit it once and
all three pick it up.

## Rules

- Prefer quality, simplicity, robustness, and long-term maintainability over
  development cost.
- For one-off or infrequent operational work, take the simplest direct
  end-to-end path. Do not add wrappers, control planes, policy layers, or
  automation until a concrete blocker or repeated need justifies them.
- When fixing a bug, reproduce it end-to-end first, as close to how a real
  user hits it as possible.
- Be picky about UI and pixel-level correctness. If something looks off, fix it.
- Apply the same bar to lint, tests, and flakiness: if you see a failure, fix it
  even if it is not caused by the change in progress.
- Before using "dynamic workflows", "ultra code", or any feature that spawns a
  large swarm of subagents, explain the tradeoffs and get explicit approval first.
- Never hand-edit auto-generated files (lockfiles, CHANGELOG, etc.).
- Do not add yourself as a co-author to commit messages.

## Personalize

These rules are a starting point. Delete what you disagree with and add your own
project-specific conventions here.
