## Model usage
- Planning and spec work: prefer extended thinking
- Implementation: proceed without extended thinking unless stuck
- Spec and plan sessions should use Opus; switch model before running /spec or /plan

## File conventions
- SPEC.md: authoritative requirements
- PLAN.md: module breakdown and interfaces
- SPEC_FEAT_<name>.md / PLAN_FEAT_<name>.md: feature work
- CHANGELOG.md: append completed modules/features on session end

## Code discipline
- Touch only what the task requires. Do not improve adjacent code,
  comments, or formatting unless explicitly asked.
- If you notice unrelated dead code or issues, mention them — don't fix them.
- Remove only imports/variables/functions that your changes made unused,
  not pre-existing ones.
- No features, abstractions, or error handling beyond what was asked.
- No single-use abstractions. No speculative flexibility.
- If an implementation exceeds ~2x the minimal line count, reconsider.
