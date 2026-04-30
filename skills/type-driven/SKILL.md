---
description: Type-driven design and railway-oriented programming. Use when
  designing modules, modelling errors, defining interfaces, or when the user
  mentions ADTs, phantom types, GADTs, illegal states, ROP, or result chaining.
---

## Philosophy

Types are specifications. The compiler is the first test suite.
Design so that illegal states cannot be constructed, not so that they are
caught at runtime.

## Illegal states

- Model domain constraints in types, not in validation functions.
- If a function can only be called in a certain context, encode that context
  as a phantom type or abstract type — don't document it.
- Prefer a precise type over a general type with a runtime check.

## Error handling

- Use the language's result/either type for expected failures. Never use
  exceptions for control flow.
- Chain results — do not unwrap and rewrap manually.
- Error types should be ADTs with named variants. Each variant is a
  distinct case, not a string.
- If a function cannot fail, its return type must not suggest it can.
- Do not use option/maybe where a result type carries useful error information.

## Phantom types and indexed types

- Use phantom type parameters to encode capabilities, states, or invariants
  that must be tracked across call sites.
- Phantom parameters should name what they represent, not how they are used:
  `'curvature`, `'perm`, `'state` — not `'a`, `'b`.
- Use indexed or dependent types where the language supports them to eliminate
  entire classes of runtime error.

## Interface design

- The interface is the design artifact. Write it before the implementation.
- Abstract types are the primary encapsulation tool — not naming conventions.
- Every exposed function should have a clear postcondition expressible in its
  type. If it cannot, consider whether the type is precise enough.
- Do not expose constructors unless construction is part of the public API.

## What to avoid

- Unsafe casts or any escape from the type system.
- Exceptions as a substitute for result types.
- Boolean parameters where a sum type would name the cases.
- Stringly-typed data that has known structure.
- Nullable/optional returns where the absence case is actually an error.
