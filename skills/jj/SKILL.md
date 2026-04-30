---
description: Jujutsu (jj) version control idioms and workflows. Use whenever
  the user mentions jj, jujutsu, bookmarks, revsets, commits, rebasing,
  or any version control operation in this repository.
---

## Core model

- jj has no index/staging area. Every file change is immediately part of
  the current working-copy commit (@).
- Commits are rewritable by default. Amending, rebasing, and reordering
  are normal operations, not exceptional ones.
- Never suggest `git` commands. All VCS operations use `jj`.

## Basic operations

- `jj st` — status
- `jj log` — history (default graph view)
- `jj diff` — diff of working copy
- `jj describe -m "message"` — set commit message for current change
- `jj new` — start a new change on top of @
- `jj squash` — fold working copy into parent
- `jj split` — split current change into two
- `jj edit <rev>` — move @ to an existing commit for amendment

## Bookmarks (not branches)

- jj uses bookmarks, not branches. The concept maps roughly but the
  commands differ.
- `jj bookmark create <name>` — create bookmark at current revision
- `jj bookmark set <name>` — move bookmark to current revision
- `jj bookmark list` — list all bookmarks
- Do not use `git branch` terminology or commands.

## Rebasing and history

- `jj rebase -d <destination>` — rebase current change onto destination
- `jj rebase -s <source> -d <destination>` — rebase a subtree
- `jj abandon <rev>` — discard a change (not `git reset`)
- `jj restore --from <rev> <path>` — restore file from another revision
- After rebase, divergent bookmarks may need: `jj bookmark set <name> -r @`

## Revsets

- jj uses revsets for addressing commits — prefer them over raw hashes.
- `@` — working copy
- `@-` — parent of working copy
- `trunk()` — the main branch equivalent
- `ancestors(@)` — all ancestors
- `bookmarks()` — all bookmark targets
- Use revsets in commands: `jj log -r 'ancestors(@, 5)'`

## Remote operations

- `jj git fetch` — fetch from remote (not `git fetch`)
- `jj git fetch -b <bookmark>` — fetch a specific bookmark from remote
- `jj git push` — push to remote (not `git push`)
- `jj git push --bookmark <name>` — push a specific bookmark
- Force push equivalent: `jj git push --force-with-lease`

## Conflict resolution

- jj materialises conflicts in files rather than halting operations.
- `jj resolve` — open conflict resolver
- Conflicts can be committed and resolved later — this is intentional.
- Do not attempt to resolve conflicts with raw file edits unless the
  conflict markers are simple.

## GPG signing

- If commits require GPG signing, ensure `jj` is configured with the
  correct signing key before pushing.
- `jj config set --user signing.key <keyid>`

## What to avoid

- Never run `git` commands directly in a jj-managed repo except for
  operations jj explicitly delegates (e.g. `jj git push` calls git
  under the hood — do not double-invoke).
- Never use `git commit`, `git add`, `git checkout`, `git branch`.
- Do not suggest `git stash` — use `jj new` to park changes instead.
