# Decision Reference

A decision record preserves a settled choice, its reason, and rejected alternative when needed to avoid reopening the same question.

## Format

```md
- decision: <settled choice>
  reason: <short reason, if important>
  rejected: <rejected alternative, if important>
```

## Rules

- Keep the record token-efficient.
- Keep the first line as the final decision.
- Keep `reason` short.
- Omit `reason` when the reason is obvious or not needed later.
- Omit `rejected` when no rejected alternative matters.
- Do not include discussion history.
- Do not describe settled decisions as tentative.

## Example

```md
- decision: Keep checkpoint files as a flat chronological fact stream.
  reason: Sectioned files broke chronological order.
  rejected: Separate `State before`, `Records`, and `Current state` sections.
```
