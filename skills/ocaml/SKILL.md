---
description: OCaml-specific idioms and library conventions. Use when writing
  or reviewing OCaml code, or when the user mentions Eio, Lwt, effect handlers,
  GADTs, functors, module types, QCheck, Ortac, or dune.
---

## Type-driven design in OCaml

- The `.mli` is the design artifact. Write it first.
- Use GADTs to enforce protocol states, expression invariants, or capability
  constraints at the type level. Keep constructors close to their eliminator.
- Phantom type parameters name what they represent: `'curvature`, `'perm`,
  `'state` — not `'a`, `'b`.
- Abstract types are the primary encapsulation tool — not naming conventions.
  Do not expose constructors unless construction is part of the public API.
- Use `result` for expected failures, `let*` / `Result.bind` for chaining.
  Never use exceptions for control flow.
- Error types are ADTs with named variants, not strings.
- Polymorphic comparison (`=`, `<`) is forbidden on non-primitive types —
  use `Type.compare` or derive `equal`/`compare` explicitly.

## Concurrency

- Eio is the default for all new code. Never introduce Lwt except in
  MirageOS/unikernel contexts where it is the only option.
- Use structured concurrency: `Eio.Switch` for resource lifetimes,
  `Fiber.fork_promise` for parallel work.
- Do not mix Eio and Lwt in the same module.

## Effect handlers

- Effects are for IO abstraction and dependency injection, not control flow.
- Define effects in a dedicated module; keep the handler close to the entry point.
- Name effects as actions: `Read`, `Write`, `Yield` — not `Effect1`.

## Module system

- Prefer small, focused modules with explicit `.mli` files.
- Use functors for parameterising over implementations, not for code reuse.
- Do not `open` modules at the top level except `Stdlib` extensions.
  Use local opens (`let open M in`) or qualified names.
- Module type aliases (`module type S = M.S`) keep interfaces stable.

## Testing

- Property-based tests with QCheck are preferred over example-based tests
  for pure functions.
- Use QCheck-STM for stateful systems.
- Use Ortac/Gospel for specification and runtime assertion where applicable.
- Never skip tests in hobby or library projects.
- Test file convention: `test/test_<module>.ml`, registered in dune.

## Naming and style

- Type names are lowercase: `t` for the primary type of a module.
- Constructor names are CamelCase.
- Use labeled arguments when a function takes multiple values of the same type.
- Avoid `_opt` suffix variants unless the caller genuinely needs both.

## Build

- dune is the build system. Do not generate Makefile wrappers over dune.
- Libraries go in `lib/`, executables in `bin/`, tests in `test/`.
- Inline tests (`(inline_tests)`) only for trivial sanity checks;
  real tests go in `test/`.

## What to avoid

- `Obj.magic` or any unsafe module.
- `try/with` for control flow — use `result`.
- Mutable state outside of explicit, documented boundaries.
- Lwt outside of MirageOS contexts.
