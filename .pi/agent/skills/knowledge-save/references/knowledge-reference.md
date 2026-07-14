# Knowledge Reference

A knowledge note is a concise, self-contained explanation of one reusable technical topic extracted from the session.

## Format

```md
---
authors:
  - Anton Petrov
status: <draft|note>
tags:
  - <lowercase-single-word-tag>
---

<short opening paragraph establishing the problem, behavior, or context>

## Prerequisites

<non-obvious requirements needed for reproduction>

## <topic section>

<mechanism, configuration, procedure, evidence, or verification>

> [!warning]
> <important secondary failure, constraint, or dead end>

## References

- [<Title> (<Source>)](url)
```

Use `status: draft` while material questions remain unresolved. Otherwise use `status: note`.

`## Prerequisites` is optional. Use it when reproduction depends on multiple non-obvious local or remote requirements.

`## References` is optional. Omit it when no significant reference exists.

## Rules

- Keep one coherent technical topic per note.
- Make the note understandable and reproducible without the original session.
- Include every fact needed to reproduce the result, understand its mechanism, or avoid a material mistake; omit everything else.
- Preserve relevant prerequisites, final state, project-specific values, decisions and reasons, errors and fixes, verification, constraints, and unresolved limitations.
- Prefer the latest explicit user correction and final observed result over earlier session statements.
- When a plausible alternative failed and explains a non-obvious final choice, preserve only the observed failure, rejected alternative, and working replacement.
- Omit session narration, failed micro-attempts, temporary renames, implementation churn, and obsolete intermediate state.
- Do not present assumptions, rejected alternatives, or unresolved claims as confirmed facts.
- Start with context or observed behavior before instructions or configuration.
- Use noun-based `##` and `###` headings. Never add an `#` heading in the body.
- Keep errors, fixes, limitations, and dead ends inside the section that owns the affected mechanism.
- Do not create standalone `Troubleshooting`, `Problems`, `Solutions`, `Gotchas`, or `FAQ` sections.
- Keep a single secondary prerequisite in the relevant section or callout instead of creating `## Prerequisites`.
- Use callouts only for important information secondary to the main explanation.
- Include code, commands, configuration, and output only when required for understanding, reproduction, or verification.
- Keep code blocks minimal and always provide a language hint.
- State each fact once. Do not repeat explanations around code blocks or callouts.
- Use short, direct paragraphs, consistent terminology, and the source language.
- Do not hard-wrap prose.
- Use `-` for lists and avoid tables when a list is sufficient.
- Never use `→` in prose.
- Never generate a `Summary` section. Add `TL;DR` only when it does not repeat the body.
- Exclude secrets, credentials, private URLs, personal data, and irrelevant local paths.
- Keep reference descriptions short. Use `[[Note Name]]` for internal notes.

## Example

````md
---
authors:
  - Anton Petrov
status: note
tags:
  - coverage
  - asyncio
  - greenlet
---

Coverage numbers are trustworthy only when the tracer sees every executed frame.

**coverage.py** traces per thread. Code crossing an unconfigured greenlet or worker-thread boundary may pass its assertions while appearing uncovered.

## Tracing boundaries

SQLAlchemy async execution crosses a **greenlet** boundary. FastAPI sends synchronous dependencies and endpoints to worker threads.

> [!tip]
> Changing a construction-only dependency to `async def` removes the threadpool boundary but does not fix greenlet tracing.

## Coverage configuration

Declare both concurrency models:

```toml
[tool.coverage.run]
concurrency = ["greenlet", "thread"]
```

Rerun the coverage suite and confirm that the previously missing paths are traced.
````
