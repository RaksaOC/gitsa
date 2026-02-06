#!/bin/bash

# Telegram Configuration
TELEGRAM_BOT_TOKEN="your_telegram_bot_token"
CHAT_IDS=("your_telegram_chat_id_1" "your_telegram_chat_id_2")

# AI Provider Configuration (choose one)
AI_PROVIDER="gemini"
GEMINI_AI_KEY="your_gemini_api_key"
GEMINI_AI_MODEL="gemini-2.5-flash"

# OpenAI Configuration (uncomment to use OpenAI instead)
# AI_PROVIDER="openai"
# OPEN_AI_KEY="your_openai_api_key"
# OPEN_AI_MODEL="gpt-4o"

# Anthropic Configuration (uncomment to use Anthropic instead)
# AI_PROVIDER="anthropic"
# ANTHROPIC_AI_KEY="your_anthropic_api_key"
# ANTHROPIC_AI_MODEL="claude-3-5-sonnet-20240620"

# Git Remote Validation
REMOTE_NAMES=("origin")
REMOTE_URLS=("https://github.com/username/repository.git")
ALLOW_ONE_MATCH="false"
