# dotagents

Dotfiles-style configuration and extensions for AI coding agents.

## Install

Installation uses GNU Stow, so `stow` must be available on your system and commands should be run from this repository root.

Install links into `$HOME`:

```sh
make stow
```

This symlinks the tracked agent configuration from this repository into the matching paths under your home directory.

Remove those links from `$HOME`:

```sh
make unstow
```

Other useful maintenance commands are documented in the `Makefile`.

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

### `knowledge-list`

Lists reusable technical knowledge candidates from the current session.

- Uses only the current session as input.
- Returns concise candidate names and scopes.
- Does not read files, invoke other skills, or save notes.

### `knowledge-save`

Saves one coherent reusable technical note under `.knowledge/`.

- Captures significant prerequisites, mechanisms, decisions, errors, fixes, verification, constraints, and unresolved limitations.
- Writes concise self-contained notes that can be reused without the original conversation.
- Follows the skill reference format for note structure and omission rules.

### `code-documentation`

Updates source-bound documentation without changing implementation behavior.

- Works from the current session or an explicit scope.
- Updates only documentation for resolved in-scope declarations.
- Preserves existing documentation conventions and avoids unrelated formatting changes.

## Knowledge notes

Reusable knowledge notes are stored under `.knowledge/` when created with `knowledge-save`.

Each note should be self-contained, technically complete, and free of session narration or sensitive values.

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
- recall workflow for restoring context;
- reusable knowledge listing and saving;
- scoped source documentation updates.
