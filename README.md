# .agent

Personal Coding Harness configuration (Claude Code, Opencode, Pi) —
global settings and skills symlinked into each harness's config directory.

## Structure

```
dotagent/
├── CLAUDE.md          # Global workflow and code discipline instructions (used by all harnesses)
├── settings.json      # Claude Code settings (model, hooks, permissions, theme)
├── install            # Install all harnesses
├── install-claude     # Claude Code: symlinks + plugin install
├── install-opencode   # Opencode: symlinks
├── install-pi         # Pi: symlinks
└── skills/
    ├── jj/            # Jujutsu VCS idioms and workflows
    ├── ocaml/         # OCaml idioms, Eio, dune, testing conventions
    ├── tiger-style/   # Tiger Style naming and API design conventions
    └── type-driven/   # Type-driven design and railway-oriented programming
```

## Install

```sh
./install            # all harnesses
./install-claude     # Claude Code only
./install-opencode   # Opencode only
./install-pi         # Pi only
```

## Harness config locations

| Harness | Context file | Skills | Settings |
|---|---|---|---|
| Claude Code | `~/.claude/CLAUDE.md` | `~/.claude/skills/` | `~/.claude/settings.json` |
| Opencode | `~/.config/opencode/CLAUDE.md` | `~/.config/opencode/skills/` | — |
| Pi | `~/.pi/agent/AGENTS.md` | `~/.pi/agent/skills/` | `~/.pi/agent/settings.json` |

## Plugins (Claude Code)

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
