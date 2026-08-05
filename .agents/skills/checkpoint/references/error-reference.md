# Error Reference

An error record preserves a failure signal, its cause, and its fix when needed to avoid repeating the issue.

## Format

```md
- error: <short semantic meaning of the failure>
  error: <exact compact error signal>
  cause: <short or strongly inferred cause, if known>
  fix: <short fix or resolution in text, command, or code, if any>
```

## Rules

- Keep the record token-efficient.
- Keep the first line semantic and short.
- Keep `error:` exact and compact: exception, status, log line, command output, or observed broken behavior.
- Keep `cause` and `fix` short.
- Omit `cause` when unknown.
- Omit `fix` when no fix was found or applied.
- Use inline code or fenced code blocks only when the exact signal or fix must be preserved.
- Do not include full tracebacks, long logs, full diffs, unrelated output, or narrative context.

## Example

````md
- error: Session payload misses `users`.
  error: `KeyError: users`
  cause: Loader assumed `users` always exists.
  fix: Use safe default before iterating.
  ```
  users = payload.get("users", [])
  ```
````
