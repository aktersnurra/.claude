# .agent

Personal Coding Harness configuration (Claude Code, Opencode) — 
global settings, slash commands, and skills symlinked into `~/.claude`, `~/.config/opencode`.

## Structure

```
dotagent/
├── CLAUDE.md          # Global workflow and code discipline instructions
├── settings.json      # Claude Code settings (model, hooks, permissions, theme)
├── install            # Symlink script
├── commands/
│   ├── checkpoint.md  # /checkpoint — summarise session and prompt /compact
│   ├── plan.md        # /plan — generate module-by-module implementation plan
│   └── spec.md        # /spec — iterate on requirements and write SPEC.md
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

Symlinks `CLAUDE.md`, `settings.json`, all commands, and all skills into `~/.claude`.

## Skills

| Skill | Trigger |
|---|---|
| `jj` | Any jj/jujutsu VCS operation |
| `ocaml` | OCaml code, Eio, Lwt, GADTs, dune |
| `tiger-style` | Naming functions, types, designing APIs |
| `type-driven` | Modelling errors, designing interfaces, ADTs, ROP |

## Commands

| Command | Purpose |
|---|---|
| `/spec` | Iterate on requirements → write `SPEC.md` |
| `/plan` | Generate module plan → write `PLAN.md` |
| `/checkpoint` | Summarise session → append to `SESSION_SUMMARY.md` |
