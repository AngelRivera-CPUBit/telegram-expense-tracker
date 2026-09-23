# Telegram Expense Tracker Bot

A no-code/low-code automation that lets you log personal expenses by sending a simple text message to a Telegram bot. Built as a hands-on project to practice workflow automation, API integration, and data pipelines.

## The problem

Manually tracking daily expenses (in notebooks or inconsistent apps) is tedious enough that most people give up on it within a week. This project removes the friction: logging an expense takes one message, no app to open, no form to fill.

## How it works

```
Telegram message  →  n8n Telegram Trigger  →  Code node (parses text)  →  Google Sheets (append row)  →  Telegram confirmation reply
```

1. **Telegram Trigger** — listens for any message sent to the bot.
2. **Code node (JavaScript)** — splits the raw text (e.g. `"Comida 200 tacos"`) into structured fields: `category`, `amount`, `description`, and a timestamp.
3. **Google Sheets** — appends the parsed data as a new row in a spreadsheet, acting as the database.
4. **Telegram response** — the bot replies confirming the entry was logged, so the user gets instant feedback.

## Example

**Input (sent to the bot):**
```
Comida 200 tacos
```

**Output (new row in Google Sheets):**
| category | amount | description | date |
|----------|--------|--------------|------|
| Comida   | 200    | tacos        | 2026-09-23T01:13:18.096Z |

**Bot reply:**
```
✅ Registrado: Comida - $200 (tacos)
```

## Tech stack

- **n8n** — workflow automation / orchestration
- **Telegram Bot API** — user input interface
- **Google Sheets API** — lightweight data storage
- **JavaScript** — data parsing logic (Code node)

## Setup

1. Create a bot via [@BotFather](https://t.me/botfather) on Telegram and save the API token.
2. Create a free [n8n](https://n8n.io) account and start a new workflow.
3. Add a **Telegram Trigger** node, set it to trigger on `Message`, and connect it using your bot token.
4. Add a **Code** node that parses `message.text` into `category`, `amount`, and `description`.
5. Add a **Google Sheets** node (`Append Row` operation) mapped to a sheet with matching column headers.
6. Add a final **Telegram – Send Message** node to reply to `{{ $('Telegram Trigger').item.json.message.chat.id }}`.
7. Activate the workflow.

## Planned improvements

- Weekly automated summary (scheduled trigger that totals expenses by category every Sunday).
- Input validation (handle malformed messages gracefully instead of returning `null`/empty values).
- Multi-user support so family members can log shared expenses, tagged by sender.
- Budget alerts when a category approaches a set weekly/monthly limit.

## What I learned

- Core concepts of workflow automation and event-driven triggers.
- Integrating third-party APIs (Telegram, Google Sheets) without writing a backend from scratch.
- Basic JavaScript for parsing and transforming unstructured text into structured data.
- Debugging a live data pipeline step-by-step using intermediate execution outputs.
