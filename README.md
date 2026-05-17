# .agent

Personal Coding Harness configuration (Claude Code, Opencode) — 
global settings and skills symlinked into `~/.claude`, `~/.config/opencode`.

## Structure

```
dotagent/
├── CLAUDE.md          # Global workflow and code discipline instructions
├── settings.json      # Claude Code settings (model, hooks, permissions, theme)
├── install            # Symlink script + plugin installer
└── skills/
    ├── jj/            # Jujutsu VCS idioms and workflows
    ├── ocaml/         # OCaml idioms, Eio, dune, testing conventions
    ├── tiger-style/   # Tiger Style naming and API design conventions
    └── type-driven/   # Type-driven design and railway-oriented programming
```

## Install

```sh
./install
```

Symlinks `CLAUDE.md`, `settings.json`, and all skills into `~/.claude`, then installs Claude plugins.

## Plugins

| Plugin | Purpose |
|---|---|
| `superpowers` | Workflow skills: spec, plan, checkpoint, TDD, debugging, brainstorming, etc. |
| `frontend-design` | Production-grade UI component generation |

## Skills

| Skill | Trigger |
|---|---|
| `jj` | Any jj/jujutsu VCS operation |
| `ocaml` | OCaml code, Eio, Lwt, GADTs, dune |
| `tiger-style` | Naming functions, types, designing APIs |
| `type-driven` | Modelling errors, designing interfaces, ADTs, ROP |
