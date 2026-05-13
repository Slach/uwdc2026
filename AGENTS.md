# UWDC 2026 — Slidev Presentation

## Project Overview

Slidev presentation for UWDC 2026 conference: "Бесплатное использование LLM skills и кодинговых агентов для работы с ClickHouse"

## How to Run

**IMPORTANT: Always use `bun run dev`, NOT `bunx @slidev/cli`**

```bash
bun run dev      # Start dev server (localhost:3030)
bun run build    # Build static SPA
bun run export   # Export to PDF
```

### Why NOT `bunx @slidev/cli`

Running via `bunx` launches Slidev from a temp cache (`/var/folders/.../bunx-501-@slidev/`). The `lz-string` package (used by `shiki-magic-move` for code animations) is a CJS module without `export default`. Vite cannot properly interop it from the bunx cache path, causing all slides with `magic-move` to fail with:

```
SyntaxError: The requested module 'lz-string/libs/lz-string.js' does not provide an export named 'default'
```

Local install (`bun add @slidev/cli lz-string`) resolves this — Vite correctly handles CJS→ESM interop from local `node_modules/`.

## Tech Stack

- **Slidev** v52.x — Markdown-based slides with Vue components
- **Bun** — package manager and runtime
- **Features used:** magic-move (code animations), v-clicks, grid layouts, Vue components, Mermaid diagrams
- **Theme:** `@slidev/theme-default`

## File Structure

- `slides.md` — main presentation file (all slides in one Markdown)
- `old-slides/` — previous versions
- `public/images/` — images, QR codes
- `global-bottom.vue` — global Vue layer

## Slide Content Summary

1. Cover + speaker intro (Slach / Евгений Климов, Altinity)
2. LLM/Agent/MCP/Skill basics
3. Coding agents: Claude Code, Claude Code Router, OpenCode
4. Skills installation for ClickHouse
5. Altinity/Skills — 18 diagnostic skills (card layout with colored grids)
6. ClickHouse/agent-skills — 7 packages (magic-move code animations, card layout)
7. Comparative analysis (tables)
8. API keys: OpenRouter, NVIDIA build.nvidia.com
9. Summary + links + QR codes

## Conventions

- Prompts in skill cards are in Russian
- QR codes are wrapped in `<a>` links (clickable)
- GitHub URLs in signatures are clickable links, not plain text
- SQL examples use `❌` / `✅` markers
- Rule badges: `<Badge type="danger">CRITICAL</Badge>`, `<Badge type="warning">HIGH</Badge>`, `<Badge type="info">MEDIUM</Badge>`
- Skill card grid: 3 cards per row, colored borders (blue/green/red/amber/purple), zoom: 0.85
