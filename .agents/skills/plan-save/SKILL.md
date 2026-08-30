---
name: plan-save
description: Save the current planning state as a compact implementation plan under .plan/.
argument-hint: [commentary]
---

# Plan Save

Save the planning state already available in context as a compact implementation plan under `.plan/`.

## Setup

Use:

```text
<plan-root> = <cwd>/.plan/
```

Create `<plan-root>` and the target plan directory when needed.

Do not gather or inspect new planning or implementation context while saving, except for reading the target plan when updating it.

## Arguments

Treat `$ARGUMENTS`, when present, as commentary for this save.

Commentary may constrain the plan scope, emphasize relevant planning state, or request how existing information is represented.

If commentary states a requirement or decision about the planned work, include it in the plan.

Do not copy save-process commentary into the plan unless it also describes the planned work.

## Instructions

Identify the plan represented by the current session and derive a concise kebab-case `<plan-purpose>` describing what it achieves.

Use all context already available to the model that is relevant to that plan, regardless of how it entered context. Planning may be complete or unresolved.

Preserve information whose loss could:

- change the intended implementation;
- remove a requirement, constraint, dependency, fixed value, or architectural boundary;
- make an intentional omission look accidental;
- erase an unresolved question relevant to implementation.

Prefer the latest explicit correction or decision over superseded discussion.

Drop repetition, session narration, discarded exploration, incidental examples, and rationale that does not affect the resulting work.

Do not continue planning while saving. Never resolve an unanswered question, choose an unspecified value, improve, harden, or generalize the design, or invent implementation details.

### Decomposition

Decompose the work into coherent units when useful boundaries exist.

A component is one meaningful implementation outcome that can be implemented from the overview and its own file. Name any component whose outcome it depends on.

Prefer components that can be implemented independently and, when practical, verified independently.

Split distinct responsibilities when each remains meaningful on its own. Do not split merely by file, class, function, test, individual edit, generated value, or technology.

Keep directly related code, configuration, tests, and supporting changes in the component whose outcome they complete. Do not create micro-components for fragments with no useful independent result.

Do not combine independently workable responsibilities merely because they contribute to the same final goal.

If no useful decomposition exists, keep the plan as one unit.

### Layout

Use:

```text
.plan/
  <plan-purpose>/
    00-overview.md
    01-<component>.md
    02-<component>.md
```

Several plans may coexist, so never place a plan directly in `<plan-root>`.

When components exist, `00-overview.md` contains the intended result, plan-wide invariants, component index, required dependency or ordering relationships, and global open questions.

State each invariant once in the overview. Components rely on it without restating it.

If no useful component split exists, place the complete plan in `00-overview.md`.

Omit empty sections.

### Components

Each component states its complete outcome and the component-specific information required to preserve that outcome and its constraints.

Include when relevant:

- affected system area;
- dependencies on other components;
- architecture fixed during planning;
- exact names, values, domains, addresses, protocols, identifiers, or other settled choices;
- required ordering;
- constraints or guards whose removal could look like a valid simplification;
- required privileges, capabilities, ownership, or runtime properties;
- intentional omissions that could otherwise look unfinished;
- contextual relationships that constrain implementation.

Name settled values directly instead of referring to them generically.

Describe the required outcome and constraints, not a task-by-task implementation. Do not specify choices not fixed during planning.

Preserve diagrams or other architectural representations when they are part of the planning state or requested by commentary. Represent only relationships already established.

Code samples are allowed only to preserve a shape explicitly established during planning. Keep them schematic, not implementation-ready.

### Existing plan

If `<plan-root>/<plan-purpose>/` exists, inspect it before writing.

If it represents the same plan:

1. Preserve still-current information.
2. Apply current additions and corrections.
3. Replace superseded decisions.
4. Remove obsolete or duplicated content.
5. Recompute decomposition when useful boundaries changed.
6. Remove obsolete numbered component files.

If the directory represents different work, do not modify it.

Write immediately without an intermediate proposal, diff, or confirmation.

## Output

After a successful write, return only:

```text
Plan saved.
Path: .plan/<plan-purpose>/
Mode: <created|updated>

Files:
- <written file>
```

List exactly the files written.

If no plan can be identified:

```text
No plan found in the available context.
```

If the target belongs to different work:

```text
Plan path already belongs to different work: .plan/<plan-purpose>/.
```

If the directory cannot be created:

```text
Cannot create plan directory: .plan/<plan-purpose>/.
```

If a file cannot be written:

```text
Cannot write plan file: <path>.
```

## Rules

- Use planning context already available to the model.
- Respect optional commentary.
- Preserve all significant plan state and no incidental session history.
- Preserve unresolved questions as unresolved.
- Prefer the latest explicit correction or decision.
- Never continue, complete, improve, harden, or generalize the plan while saving.
- Never invent requirements, values, architecture, dependencies, rationale, or implementation.
- Decompose by coherent implementation outcome, not implementation fragment.
- Prefer independently implementable and, when practical, independently verifiable components.
- Do not force decomposition when no useful boundary exists.
- State plan-wide information once in the overview.
- Keep components dependent only on the overview and explicitly named components.
- Preserve intentional omissions when their absence could look accidental.
- Preserve rationale only when needed to retain a constraint, decision driver, or intentional omission.
- Do not invent acceptance criteria, verification sequences, implementation test plans, or code.
- Keep the plan complete, concise, and token-efficient.
- Do not inspect or modify files outside `<plan-root>`.
- Write without an intermediate proposal, diff, or confirmation.
- Return only the defined Output.
