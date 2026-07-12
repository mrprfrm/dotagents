---
name: knowledge-save
description: Extract significant reusable knowledge from the current session and save it as a concise note.
argument-hint: <name-or-relative-path> [-- <commentary>]
---

# Knowledge Save

Save one coherent body of reusable technical knowledge from the current session under the project-local knowledge directory.

## Setup

Use:

```text
<knowledge-root> = <cwd>/.knowledge/
<knowledge-reference> = <skill-directory>/references/note.md
```

Create `<knowledge-root>` and missing target directories when needed.

Read `<knowledge-reference>` before composing the note. If it is unavailable, stop with the corresponding Output error.

## Arguments

Parse `$ARGUMENTS` by the first standalone `--`:

```text
<name-or-relative-path> -- <commentary>
```

- `<name-or-relative-path>` is required.
- `<commentary>` is optional and constrains or clarifies the knowledge to capture.
- Without `--`, treat the complete argument as `<name-or-relative-path>`.
- Trim both values.
- Reject absolute paths and paths outside `<knowledge-root>`.

Resolve the target under `<knowledge-root>`:

- A value ending in `.md` identifies an explicit note path.
- A directory path identifies where to create a note with a filename derived from the topic.
- Any other value is a rough note name or relative path; preserve its directories, derive a concise filename, and append `.md`.
- For a rough name without directories, use an existing topical directory only when the match is unambiguous; otherwise use `<knowledge-root>`.

## Instructions

Determine the topic from the target, commentary, and current session.

Extract the smallest complete chain required to understand and reproduce the result:

- non-obvious local and remote prerequisites, including required tools, packages, runtimes, plugins, modules, and collections;
- mechanisms and technical explanations;
- final project-specific configuration, commands, procedures, decisions, corrections, and active constraints;
- material errors or warnings, their causes, fixes, and verification results;
- dead ends, security decisions, and unresolved limitations only when they affect correct future use.

A fact is significant when omitting it could cause an incorrect decision, repeated failure, missing prerequisite, irreproducible result, or repeated question.

When a non-obvious final tool, package, command, or value was chosen because a plausible alternative failed, preserve the minimal distinguishing chain:

1. observed failure;
2. rejected alternative;
3. working replacement.

Omit unrelated setup history and failed micro-attempts.

Prefer the latest explicit user correction and final observed state over earlier discussion. Preserve final project-specific values instead of generic examples when they affect reproduction and are not sensitive.

If the target note exists:

1. Compare its content with the extracted facts.
2. Preserve accurate knowledge that improves understanding or reproducibility.
3. Add missing significant facts.
4. Replace superseded facts and remove duplication.
5. Leave unrelated content unchanged.

Compose the note according to `<knowledge-reference>`.

Before writing:

1. Verify that every reproducible result includes its non-obvious prerequisites, final values, and confirming check when one occurred.
2. Verify that every non-obvious final choice retains the failure or constraint that distinguishes it from a plausible alternative.
3. Verify that every included material error has its observed behavior, cause, and resolution when known.
4. Remove repeated facts, session narration, incidental renames, temporary churn, failed micro-attempts, and explanations duplicated around code blocks.
5. Write the note immediately.

## Output

After a successful write, return only:

```text
Knowledge saved.
Path: <path relative to knowledge root>
Mode: <created|updated>
Topic: <one-line topic>

Sections:
- <created or materially updated section>: <short description>
```

List only sections created or materially updated.

If the target is missing:

```text
Knowledge name or relative path is required.
```

If the target is invalid:

```text
Invalid knowledge path: <provided path>.
```

If the reference cannot be read:

```text
Cannot read knowledge reference.
```

If a required directory cannot be created:

```text
Cannot create knowledge directory: <path>.
```

If the note cannot be written:

```text
Cannot write knowledge note: <path>.
```

If no significant reusable knowledge exists:

```text
No significant reusable knowledge found.
```

## Rules

- Capture knowledge from the current session only.
- Respect the requested topic and optional commentary.
- Produce one coherent technical note.
- Include all significant knowledge and no incidental session history.
- Preserve non-obvious prerequisites required for reproduction.
- Preserve a failed alternative only when it explains a non-obvious final choice or prevents repeated wasted work.
- Never invent facts, causes, commands, results, or rationale.
- Never present assumptions, rejected approaches, or unresolved claims as confirmed.
- Prefer the latest explicit user correction and final observed state.
- State each fact once.
- Keep the note technically complete, concise, and token-efficient.
- Exclude secrets, credentials, private URLs, personal data, and irrelevant local values.
- Follow `<knowledge-reference>` exactly.
- Do not inspect or modify files outside `<knowledge-root>`, except for reading `<knowledge-reference>`.
- Write without an intermediate proposal, diff, or confirmation.
- Return only the defined Output.

## Example

Input:

```text
deployment/ansible-vault -- preserve prerequisites and resolved Vault errors
```

Output:

```text
Knowledge saved.
Path: deployment/ansible-vault.md
Mode: updated
Topic: Ansible Vault setup for staging deployment

Sections:
- Prerequisites: records required local and remote components
- Staging configuration: preserves final deployment values
- Vault execution: records distinguishing failures, fixes, and verification
```
