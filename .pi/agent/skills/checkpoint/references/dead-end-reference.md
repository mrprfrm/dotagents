# Dead-end Reference

A dead-end record preserves a failed path and the better alternative when needed to avoid repeating wasted work.

## Format

```md
- dead-end: <short description of the failed path>
  cause: <short reason of failure, if known>
  alternative: <working or preferred path, if known>
```

## Rules

- Keep the record token-efficient.
- Keep the first line as the failed path.
- Keep `cause` and `alternative` short.
- Omit `cause` when unknown.
- Omit `alternative` when no working or preferred path exists.
- Do not include every failed micro-attempt.
- Save only dead ends that could waste time or cause repeated mistakes later.
- Do not include discussion history or narrative context.

## Example

```md
- dead-end: Making Terraform create the first Zitadel machine key.
  cause: Terraform needs credentials before managing Zitadel.
  alternative: Create the first machine key during bootstrap.
```
