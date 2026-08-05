# Reference Reference

A reference is a stable pointer needed to restore, verify, or continue checkpoint context.

## Format

```md
- <reference-type>: <stable pointer> — <why this reference matters>
```

## Rules

- Keep references token-efficient.
- Use only stable, resolvable pointers.
- Keep the reason short and specific.
- Do not store facts, decisions, reasons, todos, explanations, or model opinions in references.
- Do not include incidental links, temporary paths, unresolved guesses, or non-resolvable facts.
- If there are no significant references, write `None.`

## Example

```md
- file: knowledge/docker/docker-note.md — stores Docker knowledge note.
- url: https://zitadel.com/docs — documents machine-key auth.
- git: 1234567 — includes manifest update script.
```
