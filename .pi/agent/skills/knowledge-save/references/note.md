# Knowledge Reference

A knowledge note preserves one coherent, reusable technical concept extracted from the session.

It must contain enough information to understand, reproduce, and correctly reuse the result without access to the original conversation.

## Format

```md
---
authors:
  - Anton Petrov
status: <Draft|Note>
tags:
  - <lowercase-single-word-tag>
---

<short opening paragraph that establishes the problem, behavior, or context>

## <topic section>

<explanation, evidence, configuration, or procedure>

> [!warning]
> <important secondary error, limitation, or dead end>

## <topic section>

<working result or remaining relevant knowledge>

## References

- <stable reference with a short explanation of why it matters>
```

Use `status: Draft` when material questions remain unresolved. Use `status: Note` when the captured knowledge is complete.

`## References` is optional. Omit it when no significant stable reference exists.

## Significant knowledge

Include a fact when omitting it would cause a future reader or agent to:

- make an incorrect decision;
- repeat a material error or dead end;
- miss a required prerequisite;
- lose the ability to reproduce the result;
- misunderstand why the result behaves as observed;
- treat an unresolved claim as confirmed;
- ask again for information already established.

Relevant knowledge may include:

- final state;
- underlying mechanism;
- non-obvious local or remote prerequisites;
- implementation or configuration;
- decision and its reason;
- error, confirmed cause, and fix;
- distinguishing failure and working replacement behind a non-obvious final choice;
- dead end and preferred alternative;
- active constraint or limitation;
- meaningful verification result;
- unresolved question that affects correct use.

## Structure

- Keep one coherent topic per note.
- Start with context or observed behavior before instructions or configuration.
- Organize the body with `##` and `###` headings.
- Use noun-based descriptive headings.
- Add `## Prerequisites` when reproduction depends on multiple non-obvious tools, packages, runtimes, plugins, modules, collections, or remote dependencies.
- Keep a single secondary prerequisite in the relevant section or callout.
- Keep errors, fixes, limitations, and dead ends inside the section that owns the affected mechanism.
- Do not create standalone `Troubleshooting`, `Problems`, `Solutions`, `Gotchas`, or `FAQ` sections.
- Use callouts only for important information secondary to the main narrative.
- Preserve chronology only when it explains causality, diagnosis, or reproduction.

## Rules

- Keep the note technically complete, concise, and token-efficient.
- Preserve all significant knowledge and omit session narration.
- State each fact once.
- Preserve a failed alternative only when it explains a non-obvious final choice or prevents repeated wasted work.
- When such an alternative matters, keep only the minimal distinguishing chain: observed failure, rejected alternative, and working replacement.
- Do not present assumptions, rejected approaches, or unresolved claims as confirmed facts.
- Prefer the final observed result and the latest explicit user correction over earlier session statements.
- Prefer an explicit project-specific value over a generic example when it affects reproduction and is not sensitive.
- Include commands, code, configuration, and output only when required for understanding, reproduction, or verification.
- Keep code examples to the smallest fragment that preserves the mechanism.
- Give every fenced code block a language hint.
- Use short, direct sentences and one thesis per paragraph.
- Do not hard-wrap prose.
- Preserve the source language.
- Use consistent terminology for the same concept.
- Use `-` for unordered lists.
- Avoid tables when a list is sufficient.
- Never use `→` in prose.
- Never add an `#` heading in the note body.
- Never generate a `Summary` section.
- Do not add `TL;DR` when it would only repeat the body.
- Exclude secrets, credentials, tokens, private URLs, personal data, and irrelevant local paths.

## References

External sources use:

```md
[Title (Source)](https://example.com)
```

Internal notes use:

```md
[[Note Name]]
[[Note Name|Display Text]]
```

Keep each reference description to one short clause unless more context is required to distinguish its purpose.

Keep the full explanation in the note that owns the topic. Related notes should contain only the locally required context and a cross-reference.

## Example

````md
---
authors:
  - Anton Petrov
status: Note
tags:
  - coverage
  - asyncio
  - greenlet
---

Coverage numbers are only trustworthy when the tracer sees every frame that runs.

**coverage.py** installs its trace hook per thread. Code executed across an unconfigured greenlet or worker-thread boundary may pass its assertions while appearing uncovered.

## Tracing boundaries

SQLAlchemy async execution crosses a **greenlet** boundary. FastAPI also sends synchronous dependencies and endpoints to a worker thread.

> [!tip]
> Changing a construction-only dependency to `async def` removes the threadpool boundary. It does not fix greenlet tracing.

## Coverage configuration

Declare both concurrency models:

```toml
[tool.coverage.run]
concurrency = ["greenlet", "thread"]
```

Rerun the coverage suite and confirm that the previously missing execution paths are traced.
````
