# Documentation Reference

Documentation describes the externally observable contract of a source declaration.

It must contain enough information for correct use without repeating what is already clear from the declaration.

## Format

Use the documentation format established by the project for the source language and documentation generator.

```text
<concise purpose and result>

<non-obvious behavior, input semantics, errors, side effects, or constraints>
```

Add structured sections, tags, or examples only when they make the contract clearer.

## Significant documentation

Include information when omitting it could cause incorrect use:

- purpose and observable result;
- non-obvious input or field semantics;
- accepted values, formats, paths, units, limits, or null behavior;
- result structure, ordering, or special cases;
- caller-visible errors;
- mutation, external requests, writes, deletions, or other side effects;
- lifecycle, ownership, cancellation, concurrency, or termination constraints;
- contracts imposed by interfaces or abstract declarations.

## Rules

- Keep documentation technically complete, concise, and token-efficient.
- Prefer direct reference-style prose over mechanical section filling.
- Document observable behavior, not implementation steps or history.
- State each fact once.
- Do not restate names, signatures, types, defaults, or obvious behavior.
- Do not document an argument solely because it exists.
- Omit the arguments section when names, types, and defaults make all inputs clear.
- Document only arguments with non-obvious semantics or constraints.
- Omit return and error sections when the summary states the result and no special handling is required.
- Do not invent behavior, guarantees, errors, side effects, or constraints.
- Use examples only when prose and declarations are insufficient.
- Keep examples minimal.
- Follow the source language and established project terminology.
- Exclude secrets, credentials, private URLs, personal data, and irrelevant local paths.

## Example

```python
def normalize_name(name: str) -> str:
    """Return the canonical name used for case-insensitive lookup.

    Applies Unicode normalization before case folding.
    """
```
