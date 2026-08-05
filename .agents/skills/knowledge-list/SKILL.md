---
name: knowledge-list
description: List all significant reusable technical knowledge available in the current session.
argument-hint: [-- <commentary>]
---

# Knowledge List

Identify every coherent technical knowledge candidate that can be extracted from the current session.

## Setup

Use the current session as the only knowledge source.

Do not load other skills, read knowledge references, or inspect or modify files.

## Arguments

`$ARGUMENTS` is optional and accepts only:

```text
-- <commentary>
```

- Without arguments, inspect the complete session.
- Use `<commentary>` to constrain, prioritize, or exclude topics.
- Reject any other argument form.

## Instructions

Review the selected session scope and identify every significant reusable technical topic.

Consider:

- non-obvious prerequisites and environment requirements;
- mechanisms and technical explanations;
- final configuration, commands, procedures, and implementation results;
- decisions, corrections, and active constraints;
- material errors, causes, fixes, and verification;
- failed alternatives that explain a final choice or prevent repeated wasted work;
- security considerations and unresolved limitations.

A candidate is significant when preserving it could prevent an incorrect decision, repeated failure, missing prerequisite, irreproducible result, or repeated investigation.

Merge facts that belong to the same mechanism or workflow. Split topics only when each result is independently understandable and reusable.

For each candidate, derive:

- a concise human-readable note name or relative Markdown path;
- a brief scope containing the significant facts that belong in the knowledge.

Use title-style filenames with spaces and the `.md` extension. Add a topical directory only when the session or commentary makes the grouping clear.

Before returning, verify that every technical thread containing a final result, explicit correction, non-obvious prerequisite, material failure, fix, decision, verification, or active limitation is represented or intentionally merged.

## Output

Return only:

```text
Potential knowledge:
- <name-or-relative-path> -- <brief scope>
- <name-or-relative-path> -- <brief scope>
```

Order candidates by their first meaningful appearance in the session.

If no significant technical knowledge exists, return only:

```text
No significant technical knowledge found.
```

If the arguments are invalid, return only:

```text
Invalid arguments. Use: knowledge-list [-- <commentary>]
```

## Rules

- List candidates only; do not draft or save knowledge.
- Capture technical knowledge from the current session only.
- Respect optional commentary without expanding its scope.
- Include every significant technical topic and no incidental session history.
- Produce one candidate per coherent reusable topic, not one candidate per fact.
- Preserve enough scope to prevent significant details from being lost without reproducing the future note.
- Prefer the latest explicit user correction and final observed state over earlier discussion.
- Include non-obvious prerequisites, distinguishing failures, and confirming checks when they affect the candidate.
- Exclude acknowledgements, planning chatter, temporary renames, failed micro-attempts, and implementation churn without reusable value.
- Never invent facts, causes, results, decisions, or taxonomy.
- Keep names and scopes concise, distinct, and token-efficient.
- Do not load, invoke, or depend on another skill.
- Return only the defined Output.

## Example

Input:

```text
-- deployment and Ansible topics
```

Output:

```text
Potential knowledge:
- deployment/ansible-vault -- local and remote prerequisites, why ansible-core is required, required collections, Vault-backed variables, and syntax verification
- deployment/ansible-interpreter -- remote Python discovery, raw-module verification, interpreter pinning, and relevant warning conditions
```
