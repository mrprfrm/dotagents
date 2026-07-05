---
name: checkpoint
description: Create an append-only checkpoint of significant session changes.
---

# Checkpoint

Create an append-only handoff artifact for resuming work later.

The skill writes one checkpoint file under `.checkpoints/` and appends its metadata to `.checkpoints/MANIFEST.json`.

## Setup

Treat the current working directory as the project root.

Checkpoint state contains:

- `.checkpoints/MANIFEST.json`
- `.checkpoints/<checkpoint-id>-<checkpoint-name>.md`

If `.checkpoints/` or `.checkpoints/MANIFEST.json` is missing, initialize checkpoint state.

## Initialize checkpoint state

Check whether `.checkpoints/` and `.checkpoints/MANIFEST.json` exist.

If either is missing, run the skill-local helper script [scripts/init-checkpoints.sh](scripts/init-checkpoints.sh).

Do not run initialization when both already exist.

## Parse arguments

Accepted arguments:

```text
[checkpoint-name] [-- scope]
```

Arguments are the text passed after the skill command.

Parse by the first `--`.

<checkpoint-name> is optional. If present, convert it to a short kebab-case filename stem.

<scope> is optional commentary that narrows which significant session changes to preserve.

## Load latest checkpoint meta

Run the skill-local helper script [scripts/load-latest-checkpoint-meta.sh](scripts/load-latest-checkpoint-meta.sh).

The script outputs, in order:

```text
<latest-checkpoint-id>
<latest-recap>
<latest-state>
```

Set <current-checkpoint-id> to <latest-checkpoint-id> + 1.

Use <latest-state> as previous project state.

Use <latest-recap> only as context about the latest checkpoint.

Do not read previous checkpoint files unless manifest state or recap is missing or insufficient.

## Determine checkpoint name

If <checkpoint-name> was provided, use it.

Otherwise define it from the essence of the significant changes since the latest checkpoint.

Keep <checkpoint-name> short:

- prefer 1 to 3 words;
- use 5 words maximum;
- base it on the changes being saved.

## Create checkpoint

Create exactly one checkpoint file:

```text
.checkpoints/<current-checkpoint-id>-<checkpoint-name>.md
```

Use [the checkpoint reference](references/checkpoint-reference.md) for checkpoint structure, record-specific formats, and reference entries.

Capture only significant information since the latest checkpoint: facts needed to resume work, preserve project state, avoid repeated mistakes, or avoid reopening settled decisions.

Write facts in chronological order.

Do not group facts by type.

Do not include long logs, full diffs, full tracebacks, full code bodies, repeated discussion, speculation, or conversational filler.

Short exact snippets are allowed only when the checkpoint reference requires them.

## Create references

Create checkpoint references only for significant stable context needed to restore, verify, or continue the saved work.

Do not add files from this skill package as references when they were used only to execute the skill.

Skill package files include:

- this `SKILL.md`
- files under `references/`
- files under `scripts/`
- files under `assets/`

Include skill package files as checkpoint references only when the user task explicitly edits, reviews, or discusses those files as the subject of work.

Do not include incidental files, helper scripts, reference format files, or internal execution artifacts that did not affect the saved task state.

## Create recap

Create <current-recap> for the current checkpoint.

<current-recap> must summarize what changed, was clarified, decided, fixed, or preserved.

Keep it compact, concrete, and focused on this checkpoint only.

Do not include details that belong only in the checkpoint body.

## Create current state

Create <current-state> from <latest-state> plus the new checkpoint.

<current-state> must describe what is currently true after applying this checkpoint.

Focus on active project state, implemented behavior, constraints, unresolved questions, and remaining follow-up work.

Do not write <current-state> as a changelog.

Keep it compact.

## Update manifest

After writing the checkpoint, <current-recap>, and <current-state>, run the skill-local helper script [scripts/update-manifest.sh](scripts/update-manifest.sh) with arguments:

```text
<current-checkpoint-id>
<checkpoint-name>
<current-recap>
<current-state>
```

Pass <current-recap> and <current-state> as one argument each.

The script appends the current checkpoint metadata to `.checkpoints/MANIFEST.json`.

Do not rebuild the manifest from checkpoint files.

Do not rewrite unrelated manifest entries.

## Output

If the checkpoint file is written and the manifest update succeeds, return only <current-state> and <current-recap>.

Do not print the checkpoint body, manifest JSON, references, reasoning, preambles, plans, progress updates, command commentary, intermediate notes, or extra status text.

Write output as short readable bullets.

Each bullet must contain one clear point.

Success output format:

```text
Current:
- <current-state bullet>

Recap:
- <current-recap bullet>
```

If the skill fails before the checkpoint and manifest are both written, return only the error output.

Each error bullet must include the failure and the reason it happened.

Include a fenced snippet only when a short exact error, command, path, or code identifies the failure.

Error output format:

````text
Errors:
- <failure>
  reason: <why it happened>
  ```
  <short exact error, command, path, or code>
  ```
````

Omit `snippet` when no exact snippet is useful.

## Rules

- Create exactly one new checkpoint file.
- Never edit existing checkpoint files.
- Do not modify project source code or unrelated files.
- Use only significant information from the current checkpoint range.
- Do not duplicate information already covered by <latest-state>, <latest-recap>, or earlier checkpoints.
- Ground every saved fact in the current session, inspected artifacts, observed outputs, or explicit user commentary.
- Do not invent facts, decisions, reasons, errors, fixes, references, or project state.
- Preserve checkpoint records in chronological order.
- Do not group checkpoint records by type.
- Each checkpoint record must describe one significant fact.
- Keep each saved fact complete enough to restore context, but no longer than needed.
- Keep <current-recap> focused on this checkpoint.
- Keep <current-state> focused on what is currently true after this checkpoint.
- Keep references as stable pointers only.
- Do not use references to store decisions, rationale, todos, explanations, or model opinions.
- Do not reference skill package files unless they are the explicit subject of the saved work.
- Required helper scripts are skill-local; do not resolve them from the project root.
- If the runtime cannot execute a required skill-local script, return error output instead of searching for replacement scripts.
- Do not include conversational filler, speculation, repeated discussion, long logs, full tracebacks, full diffs, full code bodies, or decorative snippets.
- Allow short exact snippets only when required by the checkpoint reference or error output.
- Return only the success or error output defined in `Output` unless explicitly requested otherwise.
- Do not return success output until the checkpoint file is written and the manifest update succeeds.
- Return only error output if the skill fails before the checkpoint and manifest are both written.
- Stop instead of creating a checkpoint if required information is missing and cannot be safely inferred.

## Example

Successful output:

```text
Current:
- Checkpoint skill writes append-only checkpoint files and updates manifest metadata.
- Checkpoint output returns only current state and recap.

Recap:
- Finalized token-efficient output format.
- Switched checkpoint structure to reference-driven flat chronological records.
```

Error output:

````text
Errors:
- Checkpoint reference file could not be read.
  reason: Skill path used misspelled `chekcpoint` location instead of `checkpoint`.
  ```
  /Users/antion/.pi/agent/skills/chekcpoint/references/chekcpoint-reference.md: No such file or directory
  ```
````
