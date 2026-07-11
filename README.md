# dotagents

Dotfiles-style configuration and extensions for AI coding agents.

## Pi agent skills

### `commit-message`

Creates a brief commit message from the staged git diff.

- Inspects only `git diff --staged`.
- Returns an exact fallback when Git is unavailable or no changes are staged.
- Keeps output limited to the commit message.

### `checkpoint`

Creates append-only handoff records under `.checkpoints/`.

- Writes one checkpoint file per invocation.
- Appends checkpoint metadata to `.checkpoints/MANIFEST.json`.
- Tracks current state, recap, relevant commits, and knowledge metadata.
- Keeps significant recall facts in the checkpoint body.
- Prefers commit references for committed changes.
- Avoids duplicating files from referenced commits as separate knowledge or file references unless they are independently needed for direct recall.

### `recall`

Restores checkpoint context after compaction, handoff, or agent switch.

- Uses the latest-checkpoint helper by default.
- Can recall a checkpoint by id, name, or path.
- Returns current state, recap, significant recall details, and references.
- Does not reprint checkpoint bodies verbatim.
- Does not print commit or knowledge artifacts separately; references carry user-visible artifact pointers.

## Checkpoint state

Checkpoint records are stored in `.checkpoints/`:

- `.checkpoints/MANIFEST.json` stores ordered checkpoint metadata.
- `.checkpoints/<checkpoint-id>-<checkpoint-name>.md` stores chronological significant session facts.

The current checkpoint state covers:

- local Pi agent skill setup;
- staged-diff commit message generation;
- append-only checkpoint creation;
- checkpoint commit and knowledge metadata tracking;
- commit-first references;
- explicit completeness review before writing checkpoints;
- recall workflow for restoring context.
