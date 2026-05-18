---
name: explain
description: Use when the user asks for a detailed explanation, walkthrough, codebase tour, app overview, service overview, operational guide, or durable Markdown/HTML documentation generated from an answer.
---

# Explain

## Overview

Create a durable answer: write the full explanation to Markdown in the current project, render it to HTML with Pandoc and the shared CSS, then open the HTML page in the default browser.

Do not put the full explanation in chat. The chat response is only a short artifact summary.

## When to Use

Use for requests such as:

- "explain this codebase"
- "give me a detailed walkthrough of this app"
- "walk me through this service"
- "explain how to work with jj"
- "write a guide for xyz"

Do not use for short conversational answers where the user did not ask for a durable explanation, walkthrough, guide, or document.

## Output Contract

Write generated files inside the project where the question is asked:

```text
docs/explain/<YYYY-MM-DD>-<topic>.md
docs/explain/<YYYY-MM-DD>-<topic>.html
```

The Markdown file is authoritative. The HTML file is derived from it.

## Workflow

1. Treat the text after the skill invocation as the question or command to answer.
2. Research the current project or requested subject enough to answer accurately.
3. Choose `<topic>`:
   - If the prompt has an obvious subject, create a lowercase hyphenated slug from it.
   - If the prompt is vague, ask the user for a short title or topic before writing files.
4. Create `docs/explain/` in the current project if needed.
5. Write the complete answer to `docs/explain/<YYYY-MM-DD>-<topic>.md`.
6. Check `command -v pandoc`.
7. If Pandoc is missing, ask whether to install it before running any install command.
8. If the user declines installation or Pandoc cannot be installed, stop after Markdown and report that HTML was not generated.
9. Render and open the page with:

```bash
skills/explain/scripts/render.sh docs/explain/<YYYY-MM-DD>-<topic>.md
```

10. Reply only with:
    - Markdown path
    - HTML path, if generated
    - Whether the browser was opened

## Pandoc Installation

Never install Pandoc without explicit user approval.

If Pandoc is missing, ask first. After approval, use the available package manager:

```bash
sudo apt-get update && sudo apt-get install -y pandoc
```

or:

```bash
brew install pandoc
```

If neither package manager is available, tell the user to install Pandoc manually and keep the Markdown artifact.

## Document Quality

The Markdown answer should be useful as a standalone document:

- Start with a clear title.
- Include a short summary before details.
- Use headings that match the user's question.
- Include code, commands, file paths, diagrams, or tables when they make the explanation clearer.
- Prefer concrete project evidence over generic advice.
- State assumptions and limitations when relevant.

## Common Mistakes

| Mistake                          | Correct behavior                                            |
| -------------------------------- | ----------------------------------------------------------- |
| Answering fully in chat          | Write the full answer to Markdown and keep chat short       |
| Writing into the dotagent repo   | Write into the current project where the question was asked |
| Rendering before Markdown exists | Write Markdown first, then render HTML                      |
| Installing Pandoc automatically  | Ask for approval before installing                          |
| Skipping browser open            | Use the render helper, which opens the HTML page            |
| Using one-off CSS                | Use `skills/explain/assets/style.css` through the helper    |
