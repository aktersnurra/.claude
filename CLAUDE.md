# Workflow

## Context discipline
- Always read SPEC.md and PLAN.md at session start before writing any code
- On completing each module: summarize what was done, then ask user to /compact
- Never implement across module boundaries in a single session
- If implementing a module reveals an adjacent module's interface must change,
  stop. Describe what needs to change and why, then wait for user decision.

## Model usage
- Planning and spec work: prefer extended thinking
- Implementation: proceed without extended thinking unless stuck
- Spec and plan sessions should use Opus; switch model before running /spec or /plan

## File conventions
- SPEC.md: authoritative requirements
- PLAN.md: module breakdown and interfaces
- SPEC_FEAT_<name>.md / PLAN_FEAT_<name>.md: feature work
- CHANGELOG.md: append completed modules/features on session end

## Verification
- Before marking any task complete, run the relevant build or test command
  and observe actual output. Do not assert correctness without evidence.
- Never say "this should work" — show that it works.

## Debugging
- Form a hypothesis, test it, observe the result. One change at a time.
- After 3 failed attempts on the same problem: stop, summarise what was
  tried and what is still uncertain, then ask the user.
- Do not make speculative edits hoping something will fix it.

## Code discipline
- Touch only what the task requires. Do not improve adjacent code,
  comments, or formatting unless explicitly asked.
- If you notice unrelated dead code or issues, mention them — don't fix them.
- Remove only imports/variables/functions that your changes made unused,
  not pre-existing ones.
- No features, abstractions, or error handling beyond what was asked.
- No single-use abstractions. No speculative flexibility.
- If an implementation exceeds ~2x the minimal line count, reconsider.
