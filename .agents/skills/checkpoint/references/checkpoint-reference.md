# Checkpoint Reference

A checkpoint is a flat chronological record of significant session facts.

## Format

```md
# <checkpoint-name>

- state: <relevant project state>
- knowledge: <useful information, concept, or explanation>
- decision: <settled choice>
- reason: <reason behind a decision, change, rejection, constraint, error, or fix>
- change: <implementation, artifact, file, contract, process, or workflow change>
- result: <meaningful outcome>
- error: <important failure, broken behavior, exception, incorrect output, or blocker>
- dead-end: <failed path that should not be repeated>
- constraint: <active rule, limitation, preference, requirement, or boundary>
- clarification: <requirement, term, concept, or behavior made precise>
- todo: <concrete follow-up work>
- open-question: <unresolved question>

## References

- <reference-type>: <stable pointer> — <why this reference matters>
```

## Reference loading

Use record-specific references only when matching records are present:

- [Error Reference](references/error-reference.md)
- [Decision Reference](references/decision-reference.md)
- [Dead-end Reference](references/dead-end-reference.md)
- [Reference Reference](references/reference-reference.md)

## Rules

- Keep the checkpoint token-efficient.
- Preserve facts in chronological order.
- Use one bullet per significant fact.
- Do not group facts by type.
- Do not add sections between the title and `## References`.
- Include only facts needed to resume work, avoid repeated mistakes, or preserve settled decisions.
- Omit record types that have no significant facts.
- Load record-specific references according to `Reference loading`.
- Use `## References` only for stable pointers.
- If there are no significant references, write `None.`

## Example

```md
# checkpoint-skill-format

- state: Checkpoints are stored as append-only files under `.checkpoints/`.
- decision: Keep checkpoint files as a flat chronological fact stream.
  reason: Sectioned files broke chronological order.
  rejected: Separate `State before`, `Records`, and `Current state` sections.
- change: `update-manifest` appends checkpoint metadata to the manifest.
- error: Manifest loading read nonexistent global latest fields.
  error: `.latest_checkpoint_id // 0`
  cause: Manifest stores metadata only inside `checkpoints`.
  fix: Read the last checkpoint entry from `.checkpoints[-1]`.
- result: Latest checkpoint metadata is loaded from the last manifest entry.

## References

- file: .checkpoints/MANIFEST.json — stores ordered checkpoint metadata.
- file: scripts/update-manifest — appends checkpoint metadata.
- git: 1234567 — includes manifest loading fix.
```
