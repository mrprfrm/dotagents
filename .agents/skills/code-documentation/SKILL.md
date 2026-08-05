---
name: code-documentation
description: Update source-bound documentation within the current session or an explicitly provided scope.
---

# Code Documentation

Update documentation for the resolved source without changing implementation behavior.

## Arguments

The skill accepts one optional scope:

```text
-- <scope>
```

The scope may identify a commit, diff, file, directory, declaration, or natural-language restriction.

If omitted, derive the scope from the current session.

## Setup

Load and follow:

- [Documentation Reference](references/documentation-reference.md)

Resolve the source before inspecting files.

For session scope, use only files and declarations related to work performed or discussed in the current session.

For explicit scope, use only the specified source. Explicit scope overrides broader session context. Apply multiple restrictions by intersection.

If no concrete source can be resolved, return only:

```text
Documentation source is not specified.
```

Use git only for commit- or diff-based scope.

Inspect the smallest set of files required to resolve the scope and understand the affected contracts.

## Instructions

For a commit or diff:

1. Inspect its changed files and hunks.
2. Identify declarations added, changed, or made inaccurately documented by those changes.
3. Update documentation only for those declarations.
4. Do not update unrelated declarations in the same files.

For a file or declaration, inspect and update only that source.

For a directory, treat the path as the permitted boundary, not as a requirement to process every file. Narrow the work according to the supplied scope.

Inspect related declarations or callers only when required to determine an in-scope contract. Do not modify files inspected only for context.

Before editing a file, identify its existing documentation convention.

If the file uses a consistent convention:

1. Preserve its section names, tags, ordering, indentation, and prose style.
2. Update existing documentation in that convention.
3. Use the Documentation Reference to determine which information is significant.
4. Do not convert the file to another documentation format.

If the file has no consistent convention, use the project convention. If neither defines one, follow the Documentation Reference and the native convention supported by the source language and documentation generator.

For each in-scope declaration:

1. Compare existing documentation with current observable behavior.
2. Determine the significant documentation required for correct use.
3. Add, correct, shorten, or remove documentation as required.
4. Remove summaries, sections, argument entries, return entries, or error entries that only repeat the declaration, types, defaults, or obvious behavior.
5. Document an argument only when its semantics are not evident, including matching mode, accepted format, resolution rules, limits, side effects, or other behavior required for correct use.
6. Omit structured sections when concise prose preserves the complete contract more clearly.
7. Apply the Documentation Reference.
8. Preserve implementation behavior and unrelated source content.

## Output

After changing documentation, return only:

```text
Updated documentation:

- <file>: <changed declarations>
```

If no documentation changes are required, return only:

```text
Documentation is up to date.
```

Do not output complete files, diffs, unchanged files, or out-of-scope findings.

## Rules

- Apply required documentation changes directly.
- Update existing documentation as well as add missing documentation.
- Do not inspect or modify files unrelated to the resolved scope.
- Do not expand session scope beyond work performed or discussed in the current session.
- Do not expand commit- or diff-based scope beyond affected declarations.
- Do not perform a repository-wide documentation update unless explicitly requested.
- Preserve a consistent documentation convention already established in the file.
- Use the project convention only when the file does not establish one.
- Do not normalize unrelated documentation or convert an entire file to another convention.
- Do not modify implementation logic, signatures, types, defaults, decorators, or runtime behavior.
- Do not introduce unrelated formatting changes.
- Do not modify files inspected only for context.
- Load and follow the Documentation Reference before making changes.

## Example

```text
Updated documentation:

- src/storage.py: NoteStorage.read_note, NoteStorage.write_note
- src/search.py: search_notes
```
