---
name: recall
description: Recall checkpoint context from the checkpoint manifest and checkpoint body.
---

# Recall

Load saved checkpoint context into the current session after compaction, handoff, or agent switch.

The skill loads the latest checkpoint through the skill-local helper when no selector is provided, or reads `.checkpoints/MANIFEST.json` when a specific checkpoint is requested. It then reads the selected checkpoint file and returns the saved context needed to continue work.

## Setup

Treat the current working directory as the project root.

Checkpoint state contains:

- `.checkpoints/MANIFEST.json`
- `.checkpoints/<checkpoint-id>-<checkpoint-name>.md`

If `.checkpoints/MANIFEST.json` is missing, return only:

```text
No checkpoint manifest found.
```

If the manifest has no checkpoints, return only:

```text
No checkpoints found.
```

## Parse arguments

Accepted arguments:

```text
[checkpoint-selector]
```

<checkpoint-selector> is optional.

If omitted, load the latest checkpoint metadata by running the skill-local helper script [scripts/load-latest-checkpoint-meta.sh](scripts/load-latest-checkpoint-meta.sh).

If present, read `.checkpoints/MANIFEST.json` and select the first checkpoint where any of these fields exactly matches <checkpoint-selector>:

- `checkpoint_id` as text;
- `checkpoint_name`;
- `checkpoint_path`.

If no checkpoint matches, return only:

```text
Checkpoint not found.
```

## Load latest checkpoint meta

When <checkpoint-selector> is omitted, run the skill-local helper script [scripts/load-latest-checkpoint-meta.sh](scripts/load-latest-checkpoint-meta.sh).

The script outputs, in order:

```text
<checkpoint-id>
<checkpoint-name>
<checkpoint-path>
<recap>
<state>
<commits>
<knowledge>
```

Use these values as the selected checkpoint metadata.

Do not read `.checkpoints/MANIFEST.json` to recall the latest checkpoint unless the helper output is missing or insufficient.

## Read selected manifest record

When <checkpoint-selector> is present, read `.checkpoints/MANIFEST.json`.

Each manifest checkpoint record contains:

- `checkpoint_id` — actual checkpoint number;
- `checkpoint_name` — short checkpoint name;
- `checkpoint_path` — actual path to the checkpoint file;
- `recap` — compact recap of what was done during that checkpoint;
- `state` — project state when that checkpoint was created;
- `commits` — git commit hashes saved for that checkpoint, when present;
- `knowledge` — knowledge file paths saved for that checkpoint, when present.

Use manifest `state` as the current project state to restore.

Use manifest `recap` as a compact summary of the selected checkpoint.

Use manifest `commits` and `knowledge` only as internal artifact pointers for recall selection and deduplication.

Do not infer extra facts from commits or knowledge paths.

Do not print artifacts separately; relevant artifact pointers already belong in references.

## Read checkpoint body

Read the selected `checkpoint_path`.

A checkpoint file is a flat chronological record of significant session facts followed by an optional `## References` section.

Use the checkpoint body to extract significant recall details needed to continue work.

Do not reprint the checkpoint body verbatim.

Known checkpoint record labels include:

- `state`
- `knowledge`
- `decision`
- `reason`
- `change`
- `result`
- `error`
- `dead-end`
- `constraint`
- `clarification`
- `todo`
- `open-question`
- `request`

Preserve chronological meaning when summarizing recall details.

Do not regroup facts by type in a way that changes the saved context.

Do not omit significant details from the selected checkpoint body that are needed for continuation.

Do not expand references into file contents or commit contents.

Do not treat files contained in saved commits as separate knowledge or reference items.

If the checkpoint file is missing, return manifest state and recap plus an error bullet identifying the missing `checkpoint_path`.

## Output

Return only recalled context.

Do not include reasoning, command commentary, plans, or extra notes.

Keep output concise, but include all significant recall details needed to restore context.

Output format:

```text
Current:
- <manifest state>

Recap:
- <manifest recap>

Recall:
- <significant recall detail>

References:
- <reference pointer>
```

Omit `References` if the checkpoint body has no references or says `None.`.

If the checkpoint file is missing, use:

````text
Current:
- <manifest state>

Recap:
- <manifest recap>

Errors:
- Checkpoint file could not be read.
  reason: Manifest points to a missing checkpoint file.
  ```
  <checkpoint_path>
  ```
````

## Rules

- When no selector is provided, use the skill-local latest-checkpoint helper before reading any manifest content.
- Read `.checkpoints/MANIFEST.json` only when a specific checkpoint selector is provided, or when the latest-checkpoint helper output is missing or insufficient.
- Read only the selected checkpoint file after checkpoint metadata is loaded.
- Recall one checkpoint per invocation.
- Default to the latest checkpoint.
- Use manifest fields exactly as saved.
- Do not rebuild or repair the manifest.
- Do not edit checkpoint files.
- Do not create new checkpoints.
- Do not inspect commits, source files, knowledge files, or references unless explicitly requested after recall.
- Do not print `commits` or `knowledge` as separate artifacts; use references for user-visible artifact pointers.
- Do not treat commit-contained files as separate knowledge or references.
- Preserve the checkpoint body's chronological meaning.
- Include all significant recall details needed for continuation after compaction or agent switch.
- Do not reprint the checkpoint body verbatim.
- Keep references as stable pointers only.
- Return only the defined recall output or exact fallback message.

## Example

Default latest recall:

```text
/recall
```

Recall a specific checkpoint:

```text
/recall 4
/recall checkpoint-completeness
/recall .checkpoints/4-checkpoint-completeness.md
```

Example output:

```text
Current:
- Checkpoint state exists under `.checkpoints` through checkpoint 4.

Recap:
- Preserved checkpoint completeness review and fixes.

Recall:
- User asked to review checkpoint 3 and create checkpoint 4 without missing significant content.
- Checkpoint rules now require reviewing user corrections, assistant mistakes, errors, fixes, knowledge, and unresolved questions before writing.

References:
- git: f7ff15d021a83fba39feb8766a9d01bcfc016c88 — captures the checkpoint reference preference update.
```
