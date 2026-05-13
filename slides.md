---
theme: default
title: "Бесплатное использование LLM skills и кодинговых агентов для работы с ClickHouse"
info: |
  UWDC 2026
  Бесплатное использование LLM skills и кодинговых агентов для работы с ClickHouse
drawings:
  persist: false
transition: slide-left
mdc: true
layout: cover
background: /images/uwdc_2026.png
class: text-left
---

# Бесплатное использование LLM skills <br/> и кодинговых агентов <br/> для работы с ClickHouse

<br/>

**UWDC 2026**

<style>
h1 {
  font-size: 1.8em !important;
  line-height: 1.3 !important;
  max-width: 50%;
  text-shadow: 0 2px 12px rgba(0,0,0,0.9), 0 0 4px rgba(0,0,0,0.7);
}
p strong {
  text-shadow: 0 2px 12px rgba(0,0,0,0.9), 0 0 4px rgba(0,0,0,0.7);
}
:global(:not(pre) > code) {
  color: #f97316 !important;
  font-weight: bold;
}
</style>

---
layout: section
---

# Кто я такой и почему об этом рассказываю

---
layout: two-cols
---

# Slach / Евгений Климов

<style>
.slidev-layout { font-size: 0.8em; }
</style>

<v-clicks>

- Спикер UWDC и других конференций
- **Altinity** — разработчик, maintainer и contributor проектов ClickHouse
    - https://github.com/Altinity/altinity-mcp
    - https://github.com/Altinity/Skills
    - https://github.com/Altinity/clickhouse-backup
    - https://github.com/Altinity/clickhouse-grafana
    - https://github.com/Altinity/clickhouse-operator

- GitHub: **https://github.com/Slach**
    - https://github.com/Slach/clickhouse-timeline
    - https://github.com/Slach/clickhouse-dump

Вайб-кожу с 2023 ;)
</v-clicks>

::right::

<img :src="'/images/slach.jpg'" class="rounded-xl shadow-lg mt-12 ml-8" style="max-height: 350px;" />

---
layout: default
---

# 🙋 Поднимите руки, те кто знает

<v-clicks>

- Что такое **LLM**?
- Кто пользуется **агентами**?
- Что такое **MCP**?
- Что такое **Skill**?

</v-clicks>

<div class="absolute bottom-2 left-1/2 -translate-x-1/2" style="pointer-events:none;">
  <img :src="'/images/hads_up.png'" style="height: 280px; opacity: 0.9;" />
</div>


---
layout: default
---

# 📖 Краткий ликбез

<v-clicks>

- **LLM** — языковая модель, генерирующая текст по контексту
- **Кодинговый агент** — программа-ассистент, 
  - работает с моделью, 
  - но может читать и писать в файлы, 
  - давать на вход модели "инструменты" (MCP, Skills) и обрабатывать "вызовы инструментов" со стороны LLM
  - таким образом формируя контекст для продолжения генерации от модели
- **MCP** — строгий протокол подключения внешних инструментов к агенту
- **Skill** — переиспользуемый набор инструкций для агента в виде Markdown SKILL.md и дополнительных файлов скриптов 
- **MCP vs Skill?** 
  - MCP для подключения к внешнему сервису в реальном времени со строгим API
  - Skill — для знаний, правил и работе с cli утилитами

</v-clicks>

---
layout: center
---

# План доклада

<v-clicks>

1. Кодинговые агенты: Claude Code, Claude Code Router, OpenCode
2. Установка Skills для ClickHouse
3. Altinity/Skills — пакеты и сценарии применения
4. ClickHouse/agent-skills — пакеты и сценарии применения
5. Сравнение пакетов между собой
6. Получение API ключей

</v-clicks>

---
layout: section
---

# Кодинговые агенты

---

# Claude Code — AI агент в терминале от Anthropic

<v-clicks>

- Работает с платными моделями Claude (Opus, Sonnet, Haiku) - это можно обойти
- Чтение/запись файлов, выполнение команд, Git, MCP
- Поддержка **Skills** — переиспользуемых навыков для агента
- Интеграция с VS Code, Zed, JetBrains

</v-clicks>

<br/>

<v-click>

### Установка и запуск

```bash
# Установка глобально
bun install -g @anthropic-ai/claude-code

# Запуск
claude

# Или через bunx без установки
bunx @anthropic-ai/claude-code
```

</v-click>

---

# Claude Code Router — используй любую LLM в Claude Code

<v-clicks>

- Прокси между Claude Code и альтернативными провайдерами
- Qwen, Z.ai, OpenRouter, DeepSeek, Ollama, LMStudio, llama.cpp
- Умная маршрутизация: background, reasoning, long context
- Web UI для настройки конфигурации

</v-clicks>

<br/>

<v-click>

### Установка и запуск

```bash
# Через bunx
bunx @musistudio/claude-code-router start

# Web UI для настройки подключений
bunx @musistudio/claude-code-router ui

# Запуск Claude Code через роутер
bunx @musistudio/claude-code-router code

# Переключение модели на лету
/model qwen,qwen3.5-max
```

</v-click>

---

# OpenCode — open-source AI агент для терминала

<v-clicks>

- Полностью open-source и не привязан к одному провайдеру
- Терминальный TUI, desktop app и IDE extension
- Поддержка 75+ провайдеров: OpenRouter, NVIDIA, OpenAI, Anthropic, Gemini, локальные модели
- Build / Plan режимы, MCP, LSP, кастомные агенты и субагенты
- Модель выбирается в формате `provider/model`

</v-clicks>

<br/>

<v-click>

### Установка и запуск

```bash
# Быстрая установка
curl -fsSL https://opencode.ai/install | bash

# Или через пакетный менеджер
bun install -g opencode-ai

# Запуск в проекте
opencode
/init

# Headless режим
opencode run "Проанализируй схему таблицы"
```

</v-click>

---
# Установка Skills для ClickHouse
---

# Установка Skills
<v-clicks>

- https://bun.sh — использую `bunx` вместо `npx` (быстрее и меньше памяти)
- https://skills.sh — использую пакет от `skills.sh` (маркетплейс для skills)
- https://skillsmp.com — наиболее полный каталог skills

</v-clicks>

<br/>

<v-click>

<div class="grid grid-cols-2 gap-2">
<div>

### Altinity/Skills

```bash
# Все skills во все агенты
bunx skills add \
  Altinity/Skills/altinity-expert-clickhouse
bunx skills add \
  Altinity/Skills/altinity-clickhouse-profiler
```

</div>
<div>

### ClickHouse/agent-skills
```bash
# Универсальный installer
bunx skills add ClickHouse/agent-skills
# Через ClickHouse CLI
clickhousectl skills
```

</div>
</div>

### Проверка что все установилось
```bash
find ~/.codex/skills ~/.claude/skills -maxdepth 1 -type d
```

</v-click>

---
layout: default
---

<h2 class="!text-base !mb-0 opacity-60">Пример использования skills</h2>

<div class="absolute left-0 right-0 flex items-center justify-center" style="top: 2rem; bottom: 0;">
  <v-switch>
    <template #1><img :src="'/images/use_skills_1.png'" class="rounded-lg shadow-lg" style="max-width: 95%; max-height: 100%; object-fit: contain;" /></template>
    <template #2><img :src="'/images/use_skills_2.png'" class="rounded-lg shadow-lg" style="max-width: 95%; max-height: 100%; object-fit: contain;" /></template>
    <template #3><img :src="'/images/use_skills_4.png'" class="rounded-lg shadow-lg" style="max-width: 95%; max-height: 100%; object-fit: contain;" /></template>
    <template #4><img :src="'/images/use_skills_5.png'" class="rounded-lg shadow-lg" style="max-width: 95%; max-height: 100%; object-fit: contain;" /></template>
    <template #5><img :src="'/images/use_skills_6.png'" class="rounded-lg shadow-lg" style="max-width: 95%; max-height: 100%; object-fit: contain;" /></template>
  </v-switch>
</div>

---
layout: section
---

# Altinity/Skills — детальный разбор

<div class="absolute bottom-4 left-1/2 -translate-x-1/2 flex flex-col items-center">
  <a href="https://github.com/Altinity/Skills" target="_blank" rel="noopener">
    <img :src="'/images/qr-altinity-skills.png'" class="w-40 h-40" />
  </a>
  <a href="https://github.com/Altinity/Skills" target="_blank" rel="noopener" class="text-xs text-gray-400 mt-1 hover:text-blue-400">github.com/Altinity/Skills</a>
</div>

---

# Altinity/Skills — структура репозитория

<v-clicks>

- `altinity-expert-clickhouse/` — **18** диагностических skills для live ClickHouse
- `altinity-profiler-clickhouse/` — генератор cluster-specific analyst skill
- `helm/skills-agent/` — запуск агента как Kubernetes Job
- `Dockerfile` — image `ghcr.io/altinity/expert` с Claude/Codex/altinity-mcp
- Тесты: `altinity-expert-clickhouse/tests`, локальный ClickHouse через Docker
- Релизы разделены тегами `expert-v*` и `profiler-v*` для skills и `vX.X.X` для helm и docker

</v-clicks>

<br/>

<v-click>

## Иерархия skills, один skill может вызвать другой
```
connection → overview → specialist skills → prioritized report
              ├─ memory / storage / caches
              ├─ merges / mutations / part-log
              ├─ replication / kafka / grants
              └─ schema / index-analysis / reporting / ingestion
```

</v-click>


---

# Altinity/Skills: expert-clickhouse

<v-clicks>

- **18 skills** с единым префиксом `altinity-expert-clickhouse-*`
- **23 SQL-файла**: `checks.sql`, `metrics.sql`, `triage.sql`, `keeper.sql`, `queue.sql`
- `overview` — быстрый health check и маршрутизация к specialist skills
- `connection` — общий вход: проверка доступа и правил диагностики
- `tests/runner` — воспроизводимые проверки через `make validate`, `make test-*`

</v-clicks>

<br/>

<v-click>

## Использование в codex

```bash
$altinity-expert-clickhouse-overview Analyze cluster health
$altinity-expert-clickhouse-memory Why is RAM usage high?
$altinity-expert-clickhouse-replication Check replica lag
```

</v-click>

<v-click>

## Использование в claude/opencode

```bash
/altinity-expert-clickhouse-overview Analyze cluster health
/altinity-expert-clickhouse-memory Why is RAM usage high?
/altinity-expert-clickhouse-replication Check replica lag
```

</v-click>

---
zoom: 0.85
---

# Altinity/Skills — Connection и Overview

<div class="grid grid-cols-3 gap-4 mt-4">

<div class="border border-blue-400/30 rounded-lg p-4 bg-blue-500/5">
  <div class="flex items-center gap-2 text-blue-400 font-bold text-sm">
    <carbon-connection-two-way class="text-xl"/>
    connection
  </div>
  <p class="text-xs mt-2 opacity-80">
    Базовый скил — устанавливает соединение с ClickHouse перед любым анализом
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-connection
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Проверь подключение и покажи список баз данных на кластере"
  </div>
</div>

<div class="border border-green-400/30 rounded-lg p-4 bg-green-500/5">
  <div class="flex items-center gap-2 text-green-400 font-bold text-sm">
    <carbon-activity class="text-xl"/>
    overview
  </div>
  <p class="text-xs mt-2 opacity-80">
    Быстрый обзор здоровья: detached parts, логи, thread pools
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-overview
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Покажи быстрый обзор здоровья этого узла ClickHouse"
  </div>
</div>

<div class="border border-amber-400/30 rounded-lg p-4 bg-amber-500/5">
  <div class="flex items-center gap-2 text-amber-400 font-bold text-sm">
    <carbon-chart-line class="text-xl"/>
    metrics
  </div>
  <p class="text-xs mt-2 opacity-80">
    Мониторинг в реальном времени: нагрузка, соединения, очереди
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-metrics
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Какая сейчас средняя нагрузка и количество соединений?"
  </div>
</div>

</div>

---
zoom: 0.85
---

# Altinity/Skills — Память и хранилище

<div class="grid grid-cols-3 gap-4 mt-4">

<div class="border border-red-400/30 rounded-lg p-4 bg-red-500/5">
  <div class="flex items-center gap-2 text-red-400 font-bold text-sm">
    <carbon-chip class="text-xl"/>
    memory
  </div>
  <p class="text-xs mt-2 opacity-80">
    Диагностика RAM: OOM ошибки, давление памяти, аллокации
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-memory
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Почему ClickHouse упал по OOM? Покажи главных потребителей памяти"
  </div>
</div>

<div class="border border-blue-400/30 rounded-lg p-4 bg-blue-500/5">
  <div class="flex items-center gap-2 text-blue-400 font-bold text-sm">
    <carbon-block-storage class="text-xl"/>
    storage
  </div>
  <p class="text-xs mt-2 opacity-80">
    Использование дисков, эффективность сжатия, размеры частей
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-storage
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Какие таблицы занимают больше всего места на диске? Покажи коэффициент сжатия"
  </div>
</div>

<div class="border border-amber-400/30 rounded-lg p-4 bg-amber-500/5">
  <div class="flex items-center gap-2 text-amber-400 font-bold text-sm">
    <carbon-data-base class="text-xl"/>
    caches
  </div>
  <p class="text-xs mt-2 opacity-80">
    Анализ кэшей: mark cache, uncompressed cache, query cache
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-caches
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Проверь hit ratio mark cache и использование query cache"
  </div>
</div>

</div>

---
zoom: 0.85
---

# Altinity/Skills — Схема и индексы

<div class="grid grid-cols-3 gap-4 mt-4">

<div class="border border-purple-400/30 rounded-lg p-4 bg-purple-500/5">
  <div class="flex items-center gap-2 text-purple-400 font-bold text-sm">
    <carbon-table class="text-xl"/>
    schema
  </div>
  <p class="text-xs mt-2 opacity-80">
    Анализ структуры таблиц, партиционирования, ORDER BY, антипаттернов
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-schema
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Найди анти-паттерны в схеме самых больших MergeTree таблиц"
  </div>
</div>

<div class="border border-blue-400/30 rounded-lg p-4 bg-blue-500/5">
  <div class="flex items-center gap-2 text-blue-400 font-bold text-sm">
    <carbon-magnify class="text-xl"/>
    index-analysis
  </div>
  <p class="text-xs mt-2 opacity-80">
    Эффективность индексов: PRIMARY KEY, ORDER BY, skipping indexes, projections
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-index-analysis
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Используются ли skipping indexes в самых медленных запросах?"
  </div>
</div>

<div class="border border-green-400/30 rounded-lg p-4 bg-green-500/5">
  <div class="flex items-center gap-2 text-green-400 font-bold text-sm">
    <carbon-book class="text-xl"/>
    dictionaries
  </div>
  <p class="text-xs mt-2 opacity-80">
    Внешние словари: конфигурация, потребление памяти, статус загрузки
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-dictionaries
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Проверь какие словари не загрузились и сколько памяти потребляют"
  </div>
</div>

</div>

---
zoom: 0.85
---

# Altinity/Skills — Запросы и вставки

<div class="grid grid-cols-3 gap-4 mt-4">

<div class="border border-green-400/30 rounded-lg p-4 bg-green-500/5">
  <div class="flex items-center gap-2 text-green-400 font-bold text-sm">
    <carbon-meter class="text-xl"/>
    reporting
  </div>
  <p class="text-xs mt-2 opacity-80">
    Производительность SELECT запросов, медленные запросы, оптимизация
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-reporting
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Найди топ-10 самых медленных SELECT запросов за последний час"
  </div>
</div>

<div class="border border-blue-400/30 rounded-lg p-4 bg-blue-500/5">
  <div class="flex items-center gap-2 text-blue-400 font-bold text-sm">
    <carbon-document-import class="text-xl"/>
    ingestion
  </div>
  <p class="text-xs mt-2 opacity-80">
    Производительность INSERT, размер батчей, узкие места
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-ingestion
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Почему вставки медленные? Проверь размеры батчей и скорость создания частей"
  </div>
</div>

<div class="border border-amber-400/30 rounded-lg p-4 bg-amber-500/5">
  <div class="flex items-center gap-2 text-amber-400 font-bold text-sm">
    <carbon-search class="text-xl"/>
    logs
  </div>
  <p class="text-xs mt-2 opacity-80">
    Здоровье системных логов, TTL, размеры на диске
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-logs
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Проверь конфигурацию TTL системных логов и использование диска"
  </div>
</div>

</div>

---
zoom: 0.85
---

# Altinity/Skills — Merges и мутации

<div class="grid grid-cols-3 gap-4 mt-4">

<div class="border border-blue-400/30 rounded-lg p-4 bg-blue-500/5">
  <div class="flex items-center gap-2 text-blue-400 font-bold text-sm">
    <carbon-merge class="text-xl"/>
    merges
  </div>
  <p class="text-xs mt-2 opacity-80">
    Производительность merge, бэклог частей, ошибки "too many parts"
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-merges
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Почему появляется ошибка 'too many parts'? Проверь бэклог merge"
  </div>
</div>

<div class="border border-red-400/30 rounded-lg p-4 bg-red-500/5">
  <div class="flex items-center gap-2 text-red-400 font-bold text-sm">
    <carbon-dna class="text-xl"/>
    mutations
  </div>
  <p class="text-xs mt-2 opacity-80">
    ALTER UPDATE/DELETE, застрявшие мутации, производительность
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-mutations
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Найди застрявшие мутации ALTER UPDATE которые не выполняются"
  </div>
</div>

<div class="border border-amber-400/30 rounded-lg p-4 bg-amber-500/5">
  <div class="flex items-center gap-2 text-amber-400 font-bold text-sm">
    <carbon-list class="text-xl"/>
    part-log
  </div>
  <p class="text-xs mt-2 opacity-80">
    Анализ system.part_log: создание частей, merge, мутации, скачивание
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-part-log
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Покажи всплески создания частей и неожиданные удаления за последние 24 часа"
  </div>
</div>

</div>

---
zoom: 0.85
---

# Altinity/Skills — Репликация и Kafka

<div class="grid grid-cols-3 gap-4 mt-4">

<div class="border border-green-400/30 rounded-lg p-4 bg-green-500/5">
  <div class="flex items-center gap-2 text-green-400 font-bold text-sm">
    <carbon-sync-settings class="text-xl"/>
    replication
  </div>
  <p class="text-xs mt-2 opacity-80">
    Здоровье репликации, Keeper, лаг реплик, очередь
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-replication
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Проверь лаг репликации и доступность Keeper для всех реплик"
  </div>
</div>

<div class="border border-blue-400/30 rounded-lg p-4 bg-blue-500/5">
  <div class="flex items-center gap-2 text-blue-400 font-bold text-sm">
    <carbon-message-queue class="text-xl"/>
    kafka
  </div>
  <p class="text-xs mt-2 opacity-80">
    Kafka engine: статус consumer, thread pool, лаг топиков
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-kafka
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Покажи лаг Kafka consumer и насыщенность thread pool"
  </div>
</div>

<div class="border border-amber-400/30 rounded-lg p-4 bg-amber-500/5">
  <div class="flex items-center gap-2 text-amber-400 font-bold text-sm">
    <carbon-key class="text-xl"/>
    grants
  </div>
  <p class="text-xs mt-2 opacity-80">
    Диагностика прав доступа и ошибок аутентификации после обновлений
  </p>
  <div class="mt-3 text-xs font-mono bg-black/30 rounded px-2 py-1">
    /altinity-expert-clickhouse-grants
  </div>
  <div class="mt-2 text-xs opacity-60 italic">
    "Пользователь 'analyst' получает 'Not enough privileges' — каких прав не хватает?"
  </div>
</div>

</div>

---

# Altinity/Skills: clickhouse-profiler

<v-clicks>

- Профилирует live cluster через MCP `execute_query`
- Генерирует отдельный `<cluster-name>-analyst/` skill под конкретный кластер
- Пишет **6 markdown-файлов**: `SKILL.md`, `catalog.md`, `patterns.md`, `pipeline.md`, `glossary.md`, `README.md`
- Жесткое правило: только read-only `SELECT`, `SHOW`, `DESCRIBE`, `EXPLAIN`
- Каждое нетривиальное утверждение должно быть `verified` или `inferred` или `unverified`
- Нужен не для инцидента, а для долговременной "карты знаний" о кластере

</v-clicks>

<br/>

<v-click>

## Использование в codex

```bash
$clickhouse-profiler профилируй текущий кластер и создай специфичный для этого кластера скилл
```

</v-click>

<v-click>

## Использование в claude code/opencode

```bash
/clickhouse-profiler профилируй текущий кластер и создай специфичный для этого кластера скилл
```

</v-click>

---

# Altinity/Skills: Docker + Helm

<div class="grid grid-cols-2 gap-6">
<div>

### Docker image

```bash
docker pull ghcr.io/altinity/expert:latest
```

<v-clicks>

- Внутри: Claude Code, Codex CLI, `altinity-mcp`
- Удобно для CI и воспроизводимых аудитов
- Можно запускать один skill non-interactive командой

</v-clicks>

</div>
<div>

### Helm chart

```bash
helm install my-audit \
 oci://ghcr.io/altinity/skills-helm-chart/altinity-expert \
 --set skillName=altinity-expert-clickhouse-overview \
 --set prompt="найди что нужно починить сейчас"
```

<v-clicks>

- Агент как Kubernetes Job
- `agent=claude` или `agent=codex`
- Результаты можно складывать в S3 через `storeResults`

</v-clicks>

</div>
</div>

---
layout: section
---

# ClickHouse/agent-skills — детальный разбор

<div class="absolute bottom-4 left-1/2 -translate-x-1/2 flex flex-col items-center">
  <a href="https://github.com/ClickHouse/agent-skills" target="_blank" rel="noopener">
    <img :src="'/images/qr-clickhouse-agent-skills.png'" class="w-40 h-40" />
  </a>
  <a href="https://github.com/ClickHouse/agent-skills" target="_blank" rel="noopener" class="text-xs text-gray-400 mt-1 hover:text-blue-400">github.com/ClickHouse/agent-skills</a>
</div>

---

# ClickHouse/agent-skills — структура

<v-clicks>

- Репозиторий официальных skills от ClickHouse Inc
- Сейчас найдено **7 `SKILL.md` packages**
- `clickhouse-best-practices` — 31 правило для schema/query/insert/agent workflow
- `clickhouse-architecture-advisor` — 5 decision frameworks
- `chdb-datastore` и `chdb-sql` — локальная аналитика на chDB
- `clickhousectl-local-dev` и `clickhousectl-cloud-deploy` — workflow вокруг CLI
- `clickhouse-js-node-troubleshooting` — диагностика `@clickhouse/client` в Node.js

</v-clicks>

<br/>

<v-click>

`.claude-plugin` marketplace сейчас публикует два plugin-пакета: `clickhouse-best-practices` и `clickhouse-architecture-advisor`.

</v-click>

---

# ClickHouse package: best-practices

<style>
table { font-size: 0.78em; line-height: 1.15; }
td { padding: 0.18em 0.35em !important; }
th { padding: 0.22em 0.35em !important; }
</style>

| Блок правил | Count | Приоритет |
|---|---:|---|
| Primary Key Selection | 4 | CRITICAL |
| Data Type Selection | 5 | CRITICAL |
| JOIN Optimization | 5 | CRITICAL |
| Insert Batching / Mutations | 3 | CRITICAL |
| Partitioning Strategy | 4 | HIGH |
| Skipping Indices / Materialized Views | 3 | HIGH |
| Async Inserts / Native format / OPTIMIZE | 4 | HIGH |
| JSON Usage | 1 | MEDIUM |
| Agent Connectivity / Discovery / Safety | 3 | CRITICAL/HIGH |

<br/>

<v-click>

**Итого:** 31 rule file. Это design-time и review-time пакет: агент обязан прочитать применимые rules и цитировать их в ответе.

</v-click>

---

# ClickHouse/agent-skills — Проектирование PRIMARY KEY <Badge type="danger">CRITICAL</Badge>

<div class="grid grid-cols-2 gap-4 text-sm">
<div>

### Правила

<v-clicks>

- `schema-pk-plan-before-creation` — планируй ORDER BY **до** создания таблицы, он неизменяем
- `schema-pk-cardinality-order` — колонки от **низкой** кардинальности к **высокой**
- `schema-pk-prioritize-filters` — часто фильтруемые колонки **первыми**
- `schema-pk-filter-on-orderby` — фильтры должны использовать **префикс** ORDER BY

</v-clicks>

</div>
<div>

### До → После

````md magic-move
```sql
-- ❌ Произвольный порядок
CREATE TABLE events (
  ts DateTime,
  user_id UInt64,
  event String
) ENGINE = MergeTree()
ORDER BY (user_id, ts, event);
```
```sql
-- ✅ По частоте фильтрации,
--    от низкой к высокой кардинальности
CREATE TABLE events (
  ts DateTime,
  user_id UInt64,
  event String
) ENGINE = MergeTree()
ORDER BY (toDate(ts), event, user_id);
```
````

</div>
</div>

---

# ClickHouse/agent-skills — Типы данных <Badge type="danger">CRITICAL</Badge>

<div class="grid grid-cols-2 gap-4 text-sm">
<div>

### Правила

<v-clicks>

- `schema-types-native-types` — нативные типы вместо `String` для всего
- `schema-types-minimize-bitwidth` — `UInt8` вместо `Int64` где возможно
- `schema-types-lowcardinality` — `LowCardinality(String)` для строк <10K уникальных
- `schema-types-enum` — `Enum` для конечных наборов с валидацией
- `schema-types-avoid-nullable` — используй `DEFAULT` вместо `Nullable`

</v-clicks>

</div>
<div>

### До → После

````md magic-move
```sql
-- ❌ String, Int64, Nullable
CREATE TABLE t (
  status String,
  count Int64,
  name Nullable(String)
);
```
```sql
-- ✅ Нативные типы, минимальная разрядность
CREATE TABLE t (
  status LowCardinality(String),
  count UInt32,
  name String DEFAULT ''
);
```
````

</div>
</div>

---

# ClickHouse/agent-skills — Партиционирование <Badge type="warning">HIGH</Badge>

<div class="grid grid-cols-2 gap-4 text-sm">
<div>

### Правила

<v-clicks>

- `schema-partition-lifecycle` — партиции для **управления жизненным циклом** данных, НЕ для запросов
- `schema-partition-low-cardinality` — 100–1000 партиций максимум
- `schema-partition-start-without` — начинай **без** партиционирования
- `schema-json-when-to-use` <Badge type="info">MEDIUM</Badge> — `JSON` для динамических, типизированные для известных схем

</v-clicks>

</div>
<div>

### До → После

````md magic-move
```sql
-- ❌ Слишком гранулярное партиционирование
CREATE TABLE events (
  ts DateTime,
  data String
) ENGINE = MergeTree()
PARTITION BY toHour(timestamp)
ORDER BY ts;
```
```sql
-- ✅ Месячное партиционирование для lifecycle
CREATE TABLE events (
  ts DateTime,
  data String
) ENGINE = MergeTree()
PARTITION BY toYYYYMM(ts)
ORDER BY ts;
```
````

</div>
</div>

---

# ClickHouse/agent-skills — Оптимизация JOIN <Badge type="danger">CRITICAL</Badge>

<div class="grid grid-cols-2 gap-4 text-sm">
<div>

### Правила

<v-clicks>

- `query-join-choose-algorithm` — выбирай алгоритм JOIN по размеру таблиц
- `query-join-filter-before` — фильтруй **ДО** соединения
- `query-join-use-any` — `ANY JOIN` если нужно одно совпадение
- `query-join-consider-alternatives` — словари или денормализация вместо JOIN

</v-clicks>

</div>
<div>

### До → После

````md magic-move
```sql
-- ❌ Фильтрация ПОСЛЕ JOIN
SELECT *
FROM big_table b
JOIN small_table s ON b.id = s.id
WHERE b.date = today();
```
```sql
-- ✅ Фильтрация ДО JOIN
SELECT *
FROM (
  SELECT * FROM big_table
  WHERE date = today()
) b
JOIN small_table s ON b.id = s.id;
```
````

</div>
</div>

---

# ClickHouse/agent-skills — Индексы и Materialized Views <Badge type="warning">HIGH</Badge>

<div class="grid grid-cols-2 gap-4 text-sm">
<div>

### Правила

<v-clicks>

- `query-index-skipping-indices` — data skipping indices для колонок **вне** ORDER BY
- `query-mv-incremental` — инкрементальные MV для агрегаций в реальном времени
- `query-mv-refreshable` — refreshable MV для сложных JOIN и batch-задач

</v-clicks>

</div>
<div>

### Пример: skipping index + MV

````md magic-move
```sql
-- Skipping index для колонки вне ORDER BY
ALTER TABLE events
ADD INDEX idx_user user_id
TYPE bloom_filter GRANULARITY 4;
```
```sql
-- Инкрементальная Materialized View
CREATE MATERIALIZED VIEW events_hourly_mv
ENGINE = SummingMergeTree()
ORDER BY (date, hour, event_type)
AS SELECT
  toDate(ts) date,
  toHour(ts) hour,
  event_type,
  count() cnt,
  sum(value) total
FROM events
GROUP BY date, hour, event_type;
```
````

</div>
</div>

---

# ClickHouse/agent-skills — Стратегия вставок <Badge type="danger">CRITICAL</Badge>

<div class="grid grid-cols-2 gap-4 text-sm">
<div>

### Правила

<v-clicks>

- `insert-batch-size` — батчи **10K–100K** строк на INSERT
- `insert-async-small-batches` <Badge type="warning">HIGH</Badge> — async inserts для мелких потоков
- `insert-mutation-avoid-update` — используй `ReplacingMergeTree` вместо `ALTER UPDATE`
- `insert-mutation-avoid-delete` — lightweight DELETE или `DROP PARTITION`
- `insert-optimize-avoid-final` <Badge type="warning">HIGH</Badge> — не трогай `OPTIMIZE TABLE FINAL`

</v-clicks>

</div>
<div>

### До → После

````md magic-move
```sql
-- ❌ По одной строке — создаст тысячи parts
INSERT INTO t VALUES (1, 'a');
INSERT INTO t VALUES (2, 'b');
INSERT INTO t VALUES (3, 'c');
```
```sql
-- ✅ Async insert — буферизуется автоматически
SET async_insert = 1;
SET wait_for_async_insert = 1;

INSERT INTO t VALUES (1, 'a');
INSERT INTO t VALUES (2, 'b');
INSERT INTO t VALUES (3, 'c');
```
````

</div>
</div>

---

# Best-practices — Agent workflow

<div class="grid grid-cols-3 gap-4 mt-4">

<div class="border border-blue-400/30 rounded-lg p-4 bg-blue-500/5">
  <div class="flex items-center gap-2 text-blue-400 font-bold text-sm">
    <carbon-plug class="text-xl"/>
    agent-connect-mcp
  </div>
  <p class="text-xs mt-2 opacity-80">
    Подключение через MCP/CLI, credentials и output format
  </p>
</div>

<div class="border border-green-400/30 rounded-lg p-4 bg-green-500/5">
  <div class="flex items-center gap-2 text-green-400 font-bold text-sm">
    <carbon-search class="text-xl"/>
    agent-discovery-schema
  </div>
  <p class="text-xs mt-2 opacity-80">
    Обязательная схема discovery перед любыми запросами
  </p>
</div>

<div class="border border-amber-400/30 rounded-lg p-4 bg-amber-500/5">
  <div class="flex items-center gap-2 text-amber-400 font-bold text-sm">
    <carbon-warning-alt class="text-xl"/>
    agent-query-safety
  </div>
  <p class="text-xs mt-2 opacity-80">
    `LIMIT`, `max_execution_time`, progressive exploration
  </p>
</div>

</div>

<br/>

<v-click>

> **Discovery chain:** databases → tables → columns → sort keys → skip indexes → sample → `EXPLAIN`

</v-click>

---

# ClickHouse package: architecture-advisor

<v-clicks>

- Дополняет best-practices: отвечает **когда, почему и какой tradeoff**
- Сначала определяет workload: observability, SIEM, product analytics, IoT, market data, mixed OLAP
- Требует классифицировать рекомендации как `official`, `derived` или `field`
- Decision rules:
  - ingestion strategy
  - join/enrichment path
  - late-arriving data and upserts
  - time-series partitioning
  - real-time pre-aggregation
- В `examples/` есть образцы для finserv, observability и SIEM

</v-clicks>

---

# ClickHouse package: chdb-datastore

<v-clicks>

- Pandas-compatible API поверх chDB
- Основной прием: `import chdb.datastore as pd`
- Lazy execution: операции компилируются в SQL и выполняются при materialize
- 209 DataFrame methods
- 16+ источников: MySQL, PostgreSQL, S3, ClickHouse, MongoDB, Iceberg, Delta Lake
- 10+ форматов: Parquet, CSV, JSON, Arrow, ORC и др.
- Killer feature: cross-source joins в DataFrame стиле

</v-clicks>

<br/>
<v-clicks>

## Пример сгенерированного кода

```python
import chdb.datastore as pd
orders = pd.DataStore.from_file("orders.parquet")
customers = pd.DataStore.from_mysql(host="db:3306", database="crm", table="customers")
result = orders.join(customers, left_on="customer_id", right_on="id")
```

</v-clicks>

---

# ClickHouse package: chdb-sql

<v-clicks>

- In-process ClickHouse SQL engine для Python
- `chdb.query()` для one-off запросов без сервера
- `Session` для stateful analytical pipelines
- DB-API 2.0 через `chdb.connect()` / `dbapi`
- Table functions: `file()`, `s3()`, `mysql()`, `postgresql()`, `iceberg()`, `deltaLake()`
- Параметризованные запросы, UDFs, streaming, разные output formats

</v-clicks>

<br/>

<v-clicks>

## Пример сгенерированного кода

```python
import chdb
chdb.query("""
SELECT country, sum(amount)
FROM file('orders.parquet', Parquet)
GROUP BY country
ORDER BY sum(amount) DESC
""", "DataFrame")
```

</v-clicks>

---

# ClickHouse package: clickhousectl workflows

<div class="grid grid-cols-2 gap-8">
<div>

### `clickhousectl-local-dev`

<v-clicks>

- Установка `clickhousectl`
- `local install stable`
- `local init` с каталогами `tables/`, `queries/`, `seed/`
- Запуск локального сервера
- Применение SQL файлов и seed data

</v-clicks>

</div>
<div>

### `clickhousectl-cloud-deploy`

<v-clicks>

- ClickHouse Cloud signup и auth
- OAuth read-only vs API key для mutating operations
- Создание cloud service
- Миграция local schema и materialized views
- Connection strings для Python, Node.js, Go

</v-clicks>

</div>
</div>

---

# ClickHouse package: JS troubleshooting

<v-clicks>

- Для `@clickhouse/client` в **Node.js runtime**
- Не применять к browser, Web Workers, Edge runtime, Cloudflare Workers
- Issue index:
  - socket hang-up / `ECONNRESET`
  - типы данных и precision
  - read-only users + compression
  - proxy pathname confusion
  - TLS, compression, logging
  - query params и SQL injection safety
- License отличается от остальных: MIT

</v-clicks>

<br/>

<v-clicks>

## Пример сгенерированного кода

```ts
import { createClient } from '@clickhouse/client'
const client = createClient({ url: 'https://host:8443' })
```

</v-clicks>

---
layout: section
---

# Сравнительный анализ

---

# Карта пакетов

<style>
table { font-size: 0.74em; line-height: 1.12; }
td { padding: 0.16em 0.32em !important; }
th { padding: 0.22em 0.32em !important; font-size: 1.05em !important; }
</style>

| Репозиторий | Package | Основной сценарий | Нужен live CH |
|---|---|---|---|
| Altinity | `altinity-expert-clickhouse` | production diagnostics, audit, incident report | Да |
| Altinity | `clickhouse-profiler` | создать cluster-specific analyst skill | Да, read-only |
| Altinity | Docker / Helm | запуск skills в CI/K8s | Обычно да |
| ClickHouse | `clickhouse-best-practices` | DDL/query/insert/code review | Нет |
| ClickHouse | `clickhouse-architecture-advisor` | workload-aware architecture decisions | Нет |
| ClickHouse | `chdb-datastore` | pandas-style local analytics | Нет, chDB |
| ClickHouse | `chdb-sql` | SQL over files/db/cloud from Python | Нет, chDB |
| ClickHouse | `clickhousectl-*` | local dev и Cloud deployment workflow | Частично |
| ClickHouse | `clickhouse-js-node-troubleshooting` | Node.js client failures | Нет |

---

# Итоговое сравнение

<style>
table { font-size: 0.78em; line-height: 1.15; }
td { padding: 0.16em 0.32em !important; }
th { padding: 0.22em 0.32em !important; font-size: 1.05em !important; }
</style>

| Характеристика | Altinity/Skills | ClickHouse/agent-skills |
|---|---|---|
| **Позиционирование** | Операционная экспертиза и live diagnostics | Официальные design/dev skills |
| **Найдено skills** | 18 expert + 1 profiler | 7 `SKILL.md` packages |
| **Главный вход** | `overview`, потом specialist skills | auto-activation по контексту задачи |
| **Источник фактов** | `system.*`, logs, metrics, query_log, Keeper/Kafka state | rule files, official docs, examples, CLI workflow |
| **Подключение к CH** | Обычно обязательно | Нужно только для clickhousectl/cloud или реального теста |
| **Сила** | RCA: "почему сломалось/медленно прямо сейчас" | Prevention: "как спроектировать/написать правильно" |
| **Артефакт** | Диагностический отчет или analyst skill | Рекомендации, чеклист, код/CLI steps |
| **Доставка** | skills, release zips, Docker, Helm | skills installer, clickhousectl, Claude plugin metadata |

---

# Пересечение и различия

<style>
table { font-size: 0.78em; line-height: 1.12; }
td { padding: 0.16em 0.32em !important; }
th { padding: 0.22em 0.32em !important; }
</style>

| Тема | Altinity | ClickHouse |
|---|---|---|
| Schema / ORDER BY | Анализирует существующие таблицы и анти-паттерны | Правила до создания таблицы |
| Query performance | Ищет slow queries и фактические планы | Проверяет JOIN, filters, indexes, MV |
| Inserts | Находит batch/part bottlenecks в кластере | Предотвращает tiny inserts и плохой format |
| Mutations | Диагностирует stuck mutations | Советует избегать heavy UPDATE/DELETE |
| Replication / Keeper | Глубокая диагностика | Нет отдельного пакета |
| Kafka Engine | Есть отдельный skill | Нет отдельного пакета |
| chDB / pandas / files | Нет | Два отдельных пакета |
| ClickHouse Cloud onboarding | Через Helm/Docker опосредованно | `clickhousectl-cloud-deploy` |
| JS client | Нет | Node.js troubleshooting package |

---

# Когда использовать какой?

<div class="grid grid-cols-2 gap-8">
<div>

### Altinity/Skills

<v-clicks>

- Production инциденты
- "Почему медленно?" / "Почему OOM?"
- Нужно проверить `system.*`, `query_log`, Keeper, Kafka, replication
- Нужно запустить аудит как Job в Kubernetes
- Нужно сгенерировать analyst skill под конкретный кластер

</v-clicks>

</div>
<div>

### ClickHouse/agent-skills

<v-clicks>

- Проектирование таблиц и архитектуры
- Review `CREATE TABLE`, `JOIN`, ingestion strategy
- chDB вместо pandas или SQL по файлам без сервера
- Локальный dev / ClickHouse Cloud onboarding через `clickhousectl`
- Troubleshooting Node.js client

</v-clicks>

</div>
</div>

<br/>

<v-click>

> Коротко: ClickHouse/agent-skills снижает вероятность ошибок до запуска, Altinity/Skills быстрее объясняет фактическое поведение после запуска.

</v-click>

---

# Рекомендуемый совместный workflow

<v-clicks>

1. На этапе проектирования: `clickhouse-architecture-advisor`
2. Перед merge request: `clickhouse-best-practices`
3. Для локальной аналитики/прототипа: `chdb-datastore` или `chdb-sql`
4. Для первого запуска: `clickhousectl-local-dev`
5. Для production rollout: `clickhousectl-cloud-deploy`
6. После запуска: `altinity-expert-clickhouse-overview`
7. При деградации: specialist skills Altinity
8. Для больших кластеров с постоянными вопросами аналитиков: `clickhouse-profiler`

</v-clicks>

---
layout: section
---

# Получение API ключей

---

# OpenCode + build.nvidia.com как провайдер

Лучший из бесплатных вариантов прямо сейчас (раньше был qwen-code), 40 запросов в минуту, хорошая скорость генерации tokens/secs
<v-clicks>

- `build.nvidia.com` дает cloud endpoints NVIDIA NIM и модели Nemotron / open models
- В OpenCode NVIDIA уже есть как провайдер: достаточно добавить API ключ
- Ключ хранится в `~/.local/share/opencode/auth.json` или берется из `NVIDIA_API_KEY`

</v-clicks>

<br/>

<v-click>

```bash
# Интерактивно в TUI
opencode
/connect   # выбрать NVIDIA и вставить ключ
/models    # выбрать модель

# Или из CLI / env
export NVIDIA_API_KEY="nvapi-..."
opencode models nvidia --refresh
opencode run --model nvidia/MODEL_ID "Проверь SQL запрос"
```

</v-click>

---

# API ключ NVIDIA build.nvidia.com

### Регистрация и получение ключа:

<v-clicks>

1. Откройте **NVIDIA API Catalog**: https://build.nvidia.com/explore/discover
2. Войдите или зарегистрируйтесь в NVIDIA Developer Program
3. Выберите NIM / LLM модель и нажмите **Get API Key**
4. Нажмите **Generate Key**, скопируйте ключ и сохраните его как секрет
5. Для NGC / self-hosted NIM: создайте Personal Key с `NGC Catalog` и `Public API Endpoints`
6. В OpenCode: `/connect` → **NVIDIA** или `export NVIDIA_API_KEY="nvapi-..."`

</v-clicks>

<br/>

<v-click>

```bash
export NVIDIA_API_KEY="nvapi-..."
opencode models nvidia --refresh
opencode --model nvidia/MODEL_ID
```

</v-click>

---

# API ключ OpenRouter

### Регистрация и получение ключа:

<v-clicks>

1. Откройте **OpenRouter**: https://openrouter.ai
2. Войдите через GitHub / Google / email или создайте аккаунт
3. Перейдите в **Keys**: https://openrouter.ai/settings/keys
4. Нажмите **Create API Key**, задайте имя и при необходимости лимит расходов
5. Скопируйте ключ `sk-or-v1-...` — он показывается один раз
6. В OpenCode: `/connect` → **OpenRouter** или `opencode auth login --provider openrouter`

</v-clicks>

<br/>

<v-click>

```bash
opencode auth login --provider openrouter
opencode models openrouter --refresh
opencode run --model openrouter/MODEL_ID "Найди риск в миграции"
```

</v-click>

---
layout: center
---

# Итого

<v-clicks>

- **Claude Code / OpenCode** — мощные AI агенты в терминале
- **Claude Code Router** — подключай любую LLM, включая бесплатные
- **OpenRouter + NVIDIA build.nvidia.com** — готовые внешние провайдеры для OpenCode
- **Altinity/Skills** — 18 live-diagnostics skills + profiler, Docker и Helm
- **ClickHouse/agent-skills** — 7 packages: 31 rules, architecture, chDB, clickhousectl, JS troubleshooting
- Всё это можно комбинировать и использовать **бесплатно**

</v-clicks>

---
layout: center
---

# Ссылки

| Проект | URL |
|---|---|
| Claude Code | https://github.com/anthropics/claude-code |
| OpenCode | https://github.com/anomalyco/opencode |
| Claude Code Router | https://github.com/musistudio/claude-code-router |
| OpenRouter | https://openrouter.ai |
| NVIDIA API Catalog | https://build.nvidia.com/explore/discover |
| Altinity Skills | https://github.com/Altinity/Skills |
| ClickHouse agent-skills | https://github.com/ClickHouse/agent-skills |

---
layout: end
---

<div class="absolute top-16 left-1/2 -translate-x-1/2 text-center">
  <h1>Спасибо!<br>С удовольствием отвечу на вопросы</h1>
  <p>UWDC 2026</p>
</div>

<div class="absolute bottom-8 left-1/2 -translate-x-1/2 flex flex-col items-center">
  <a href="https://t.me/bloodjazman" target="_blank" rel="noopener">
    <img :src="'/images/qr-telegram.png'" class="w-40 h-40" />
  </a>
  <a href="https://t.me/bloodjazman" target="_blank" rel="noopener" class="text-xs text-gray-400 mt-1 hover:text-blue-400">t.me/bloodjazman</a>
</div>
