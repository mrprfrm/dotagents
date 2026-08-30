---
name: plan-interview
description: Interview the user to build plan-ready implementation context from the task supplied with the skill invocation.
---

# Plan Interview

Build enough context for a capable executor to implement the supplied task without inventing significant requirements.

The interview enriches the current model context. It does not save or decompose plan artifacts.

## Setup

Use the task supplied with the skill invocation and relevant available context as the starting context.

Identify significant decision areas that may still need to be settled. When there is more than one, open with their titles only; when there is one, ask it directly; when there are none, finish the interview.

```text
- Deployment model
- Persistent state
- Authentication
- CI integration
```

Add at most one short framing sentence when it materially clarifies how the task was understood.

The list is an interview map, not a questionnaire. The user may answer any part, add context, or redirect before questions begin.

## Instructions

Build planning context one significant question at a time:

```text
Q<N>: <question title>

<brief, meaning-exhaustive context needed to decide>
```

Use `Q<N>b`, `Q<N>c`, and so on for follow-ups within the same decision.

Interpret user input semantically and incorporate any planning-relevant context it adds: direct answers, multiple answers, out-of-order answers, postponed questions, broader context, code, configuration, references, revised decisions, or questions about the topic. Do not force the original order.

After each exchange, reassess the full accumulated context before deciding whether another question is needed. Drop resolved or irrelevant questions, derive direct consequences from established context, and add newly exposed significant questions only when needed. Never ask again for information or a decision already established.

Treat explicit user decisions and rejections as settled. Reopen one only when new information conflicts with a required capability, dependency, invariant, or another settled decision. State the conflict and concrete consequence before asking whether the decision should change.

When the user provides code, configuration, an existing implementation, or another example, determine what it establishes. Preserve it as implementation guidance when the user intends it to shape the implementation. If it settles a question, move on; if it leaves a significant ambiguity, clarify only that ambiguity.

When the user asks about the current question, answer first. Return to the unresolved question only if it still needs a decision.

Present tradeoffs only when alternatives differ materially. A shared cost or consequence is not a tradeoff.

When asked for a recommendation, give one preferred option and why it wins for the established context.

Use established available context, explicitly supplied material, and the model’s reliable knowledge. Do not invent facts or broaden the interview into research. If an uncertainty can materially change the plan and cannot be resolved from that context, ask the user. Investigate beyond supplied context only when the user explicitly requests it.

## Output

End the interview when the accumulated context is sufficient for a capable executor to implement the task without returning to the user for significant decisions.

Then return a brief completion summary covering only:

- what is being built;
- the few significant decisions, constraints, or implementation directions that materially shape it.

Do not restate the interview, enumerate every settled detail, or preview the saved plan.

The completed interview leaves the current model context ready for a separate plan-saving stage.

## Rules

- Ask only significant questions.
- A question is significant when different answers can materially affect functionality, capabilities, quality of life, operational behavior, a concrete problem or requirement, product surface, architecture, implementation direction, dependencies, integrations, security, constraints, or substantial implementation work.
- Significance does not require an architectural change.
- Raise unrequested capabilities only when they can materially affect value, product surface, problem solving, or implementation; do not enumerate capabilities merely because the technology provides them.
- Do not ask about equivalent local implementation choices that a capable executor can safely decide without materially changing the plan.
- Keep one significant decision or tightly coupled decision area in focus at a time. Never ask two questions at once.
- Keep questions brief and meaning-exhaustive.
- Prefer a compact code sample, config fragment, schema, or tree when it communicates the decision more directly than prose.
- Avoid background, examples, diagrams, tables, or implementation detail unless they materially help settle the current decision.
- Do not add opinions, positioning, or lectures; do not repeat settled context or rejected options; do not reprint the interview map unless the user asks.
- If new context materially changes the interview direction, state the consequence briefly only when needed to make the next question understandable.
- Do not narrate interview state or ask procedural questions when the next useful action is clear.
- Treat the supplied task and explicitly provided scope as enough context to proceed without procedural confirmation.
- Do not inspect repositories, modules, documentation, or external sources to fill missing context unless the user explicitly requests investigation.
- Assume a capable executor. Do not turn the interview into exhaustive implementation instructions or resolve ordinary engineering details.
- Do not write plan files or perform plan decomposition for persistence.
- Spend tokens only on information that helps produce plan-ready context.

## Example

Initial map:

```text
- Service capabilities
- Authentication
- Persistent state
- CI integration
```

Question:

```text
Q1: Built-in CI

Forgejo includes Actions, while the platform already uses external CI.

Do we keep Actions for any workloads or disable them and use external CI exclusively?
```

Bad question:

```text
SSH port 22 vs 2222
```

Not significant when both choices require the same SSH configuration and no requirement depends on the port.

Conflict follow-up:

```text
Q3b: SSH requirement

You excluded SSH, but the selected Ansible provisioning path requires it.

Keep SSH disabled and change provisioning, or allow SSH?
```

Completion:

```text
Interview complete.

We are adding Forgejo as a platform service using the established deployment lifecycle and external CI.

Built-in Actions stay disabled, native Git and SSH remain available, and persistent state follows the existing platform storage model.
```
