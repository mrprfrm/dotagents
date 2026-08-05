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
<latest-commits>
<latest-knowledge>
```

Set <current-checkpoint-id> to <latest-checkpoint-id> + 1.

Use <latest-state> as previous project state.

Use <latest-recap> only as context about the latest checkpoint.

Use <latest-commits> to avoid recording git commits already saved by previous checkpoints.

Use <latest-knowledge> to avoid recording knowledge files already saved by previous checkpoints.

Do not compare commits and knowledge as one combined artifact list.

Do not read previous checkpoint files unless manifest state, recap, commits, or knowledge are missing or insufficient.

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

Capture all significant information since the latest checkpoint: facts needed to resume work after compaction or agent switch, preserve project state, avoid repeated mistakes, or avoid reopening settled decisions.

Put significant context in the checkpoint body, not only in references, recap, state, commits, or knowledge metadata.

Write facts in chronological order.

Do not group facts by type.

Do not include long logs, full diffs, full tracebacks, full code bodies, repeated discussion, speculation, or conversational filler.

Short exact snippets are allowed only when the checkpoint reference requires them.

## Create references

Create checkpoint references only for significant stable pointers needed to restore, verify, or continue the saved work.

Every <current-commits> item must appear in checkpoint references with a short reason.

Every <current-knowledge> item must appear in checkpoint references with a short reason.

Do not put facts, decisions, rationale, todos, errors, fixes, or recall details only in references.

When a referenced git commit already contains changed files, do not also add those files as file references or knowledge items.

Add a file reference contained in a referenced git commit only when the file itself is a primary artifact of the checkpoint and needs direct recall independent of the commit.

Do not add files from this skill package as references when they were used only to execute the skill.

Skill package files include:

- this `SKILL.md`
- files under `references/`
- files under `scripts/`
- files under `assets/`

Include skill package files as checkpoint references only when the user task explicitly edits, reviews, or discusses those files as the subject of work.

Do not include incidental files, helper scripts, reference format files, internal execution artifacts, unrelated recent commits, or file references already covered by recorded commits.

## Create current recap

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

## Create current commits

Create <current-commits> for the current checkpoint.

<current-commits> contains git commit hashes relevant to the current checkpoint range.

If the project root is a git worktree, inspect recent commits silently:

```sh
git log --format="%H" -n 20
```

Include only commits that are both:

- relevant to the current checkpoint range;
- absent from <latest-commits>.

Use full commit hashes.

Do not include commits merely because they are recent.

If the project root is not a git worktree, git is unavailable, or no relevant new commits exist, set <current-commits> to an empty list.

## Create current knowledge

Create <current-knowledge> for the current checkpoint.

<current-knowledge> contains stable knowledge file paths created or materially updated during the current checkpoint range that are not already contained in referenced commits.

Include only files that are all of these:

- created or materially updated during the current checkpoint range;
- absent from <latest-knowledge>;
- independently useful for recall outside <current-commits>;
- not contained in any referenced <current-commits> item.

Do not include files that were only read, inspected, used to execute the skill, or already captured by a referenced commit.

Do not include skill package files unless the user task explicitly edits, reviews, or discusses those files as the subject of work.

If no relevant knowledge files exist, set <current-knowledge> to an empty list.

## Update manifest

After writing the checkpoint, <current-recap>, <current-state>, <current-commits>, and <current-knowledge>, run the skill-local helper script [scripts/update-manifest.sh](scripts/update-manifest.sh) with arguments:

```text
<current-checkpoint-id>
<checkpoint-name>
<current-recap>
<current-state>
<current-commits>
<current-knowledge>
```

Pass <current-recap> and <current-state> as one argument each.

Pass <current-commits> and <current-knowledge> as JSON arrays.

The script appends the current checkpoint metadata to `.checkpoints/MANIFEST.json`.

Do not rebuild the manifest from checkpoint files.

Do not rewrite unrelated manifest entries.

## Output

All user-visible prose emitted while this skill runs counts as output.

Before the final success or error output, optional status text is allowed only as one short sentence that states the current execution step or blocking reason.

Use tool calls silently.

If the checkpoint file is written and the manifest update succeeds, return only <current-state> and <current-recap>.

Do not print the checkpoint body, manifest JSON, references, dense reasoning, plans, intent evaluation, decision rationale, command commentary, analysis, intermediate notes, or extra status text.

Write final output as short readable bullets.

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

Omit the fenced snippet when no exact snippet is useful.

## Rules

- Create exactly one new checkpoint file.
- Never edit existing checkpoint files.
- Do not modify project source code or unrelated files.
- Use only significant information from the current checkpoint range.
- Before writing the checkpoint, review the current checkpoint range for significant user requests, user corrections, applied changes, generated outputs, errors, fixes, missing facts, knowledge, and unresolved questions.
- Do not omit significant assistant mistakes or user corrections that affect how the work should continue.
- Do not duplicate information already covered by <latest-state>, <latest-recap>, <latest-commits>, <latest-knowledge>, or earlier checkpoints.
- Ground every saved fact in the current session, inspected artifacts, observed outputs, or explicit user commentary.
- Do not invent facts, decisions, reasons, errors, fixes, references, commits, knowledge files, or project state.
- Preserve checkpoint records in chronological order.
- Do not group checkpoint records by type.
- Each checkpoint record must describe one significant fact.
- Keep each saved fact complete enough to restore context, but no longer than needed.
- Keep <current-recap> focused on this checkpoint.
- Keep <current-state> focused on what is currently true after this checkpoint.
- Keep references as stable pointers only.
- Keep recall facts in the checkpoint body, not only in references or manifest metadata.
- Prefer git commit references over file references when the commit already contains the file changes.
- Do not add file references or knowledge items for files already contained in a referenced <current-commits> item unless the file itself is a primary artifact needing direct recall independent of the commit.
- Do not use references to store decisions, rationale, todos, explanations, errors, fixes, recall details, or model opinions.
- Do not reference skill package files unless they are the explicit subject of the saved work.
- Required helper scripts are skill-local; do not resolve them from the project root.
- If the runtime cannot execute a required skill-local script, return error output instead of searching for replacement scripts.
- Do not include conversational filler, speculation, repeated discussion, long logs, full tracebacks, full diffs, full code bodies, or decorative snippets.
- Allow short exact snippets only when required by the checkpoint reference or error output.
- Treat all user-visible prose during skill execution as output, not only the final response.
- Keep pre-output status text optional, rare, and limited to one short sentence.
- Use pre-output status text only to state the current execution step or blocking reason.
- Do not print multi-sentence reasoning, plans, intent evaluation, decision rationale, command commentary, analysis, intermediate notes, the checkpoint body, manifest JSON, or references unless explicitly requested.
- Pre-output status text must not affect checkpoint content, manifest content, <current-state>, <current-recap>, <current-commits>, or <current-knowledge>.
- Return only the success or error output defined in `Output` unless explicitly requested otherwise.
- Do not return success output until the checkpoint file is written and the manifest update succeeds.
- Return only error output if the skill fails before the checkpoint and manifest are both written.
- Stop instead of creating a checkpoint if required information is missing and cannot be safely inferred.

## Example

Successful output:

```text
Current:
- Checkpoint skill writes append-only checkpoint files and updates manifest metadata.
- Checkpoint manifest tracks current state, recap, commits, and knowledge files.

Recap:
- Added manifest tracking for new commit hashes and knowledge files.
- Kept checkpoint references as the detailed source for why each artifact matters.
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
