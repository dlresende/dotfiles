# AGENTS.md

Instructions for AI agents working in this repo.

## Commits

- Conventional commits, no scope: `<type>: <subject>`.
- Types:
  - `feat` / `feat!`: adding or removing apps, or changes that slightly alter
    script behaviour or how users interact with elements of this repo.
  - `fix`: fixing broken things, bugs.
  - `docs`: publicly facing docs, such as the README.
  - `chore`: everything else (ci, internal docs, refactorings).
- Breaking changes append `!` to the type (e.g. `feat!`): the installed
  toolset is this repo's API, so removing or replacing a tool is breaking
  for every machine that runs the install.
