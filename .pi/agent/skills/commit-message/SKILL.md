---
name: commit-message
description: Create a brief commit message from git diff.
---

# Commit Message

Create a brief commit message that reflects only the essence of the selected git diff.

## Setup

Use shell only to inspect the staged diff.

Do not run a separate git availability check.

Do not announce, explain, or narrate tool use.

If the diff command fails because `git` is unavailable, return only:

Git is not available.

## Instructions

## Instructions

Inspect staged diff by calling:

```sh
git diff --staged
```

Run this command silently; do not write any preamble, intent evaluation, progress text, or command commentary.

If nothing is staged, return the no-changes message.

Summarize the essence of the change set. The exact changes are already available in the commit diff.

Do not include code samples, line-level implementation details, secrets, credentials, private URLs, local paths, or other sensitive values.

Do not list every changed file unless the file itself is the change.

## Output

Return only the commit message in this format:

```text
<Commit message title>

- <A particular significant change title>
- <A particular significant change title>
- <A particular significant change title>
```

Use only as many bullets as needed.

## Rules

- The title must be one line and reflect the whole diff.
- Use bullets only for significant changes, not every single change.
- Prefer 1 to 5 bullets.
- Omit bullets when the title fully describes the only significant change.
- Add more than 5 bullets only if omitting them would misrepresent the diff.
- Each bullet must describe one particular change.
- Keep the whole message brief.
- Do not add explanations, reasoning, notes, markdown fences, or sign-offs.

## Example

```
Initialize local Incus provisioning

- Add Terraform setup for Incus provider
- Create base Incus project for local infrastructure
- Add basic Make targets and repository ignores
```
