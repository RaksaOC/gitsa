# gitsa

A CLI tool that automatically generates AI-powered summaries of your git commits and sends them to Telegram. Perfect for keeping your team informed about code changes without manual effort.

## What It Does

gitsa connects your git workflow to Telegram by analyzing your latest commit, generating a concise summary using AI, and posting it directly to your team chat. This makes it easy to track changes, collaborate, and stay updated on project progress without leaving your terminal.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/RaksaOC/gitsa.git
   cd gitsa
   ```

2. Make the install script executable:
   ```bash
   chmod +x install.sh
   ```

3. Run the installer (requires sudo):
   ```bash
   sudo ./install.sh
   ```

The installer will:
   - Copy gitsa to `/usr/local/lib/gitsa`
   - Create a symlink in `/usr/local/bin` so you can run `gitsa` from anywhere
   - Set up your configuration directory at `~/.config/gitsa/`

## Configuration

After installation, configure gitsa with your credentials:

```bash
gitsa --config
```

This opens your config file in nano. You'll need to provide:

- **Telegram Bot Token**: Create a bot via [@BotFather](https://t.me/botfather) on Telegram and get your bot token
- **AI Provider**: Choose which AI service to use (`gemini`, `openai`, or `anthropic`)
- **AI Provider Credentials**: 
  - **For Gemini**: Get your API key from [Google AI Studio](https://makersuite.google.com/app/apikey)
  - **For OpenAI**: Get your API key from [OpenAI Platform](https://platform.openai.com/api-keys)
  - **For Anthropic**: Get your API key from [Anthropic Console](https://console.anthropic.com/)
- **Telegram Chat IDs**: An array of chat IDs where summaries can be sent (can be groups or private chats).  
  You can get chat IDs by calling the `getUpdates` endpoint on the Telegram Bot API, for example:
  `https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates`.  
  For private groups, add the bot to the group, send a message, then call `getUpdates` and look for the negative `chat.id` value.
- **Git Remote Configuration**: Configure your repository remotes for validation.  
  `REMOTE_NAMES` and `REMOTE_URLS` are parallel arrays: each name at index `i` must match the URL at index `i`.  
  For example, if you have two remotes, `origin` and `backup`, make sure both arrays line up in the same order.

Example configuration:
```bash
TELEGRAM_BOT_TOKEN="your_telegram_bot_token"
CHAT_IDS=("chat_id_1" "chat_id_2")

# AI Provider Configuration (choose one)
AI_PROVIDER="gemini"
GEMINI_AI_KEY="your_gemini_api_key"
GEMINI_AI_MODEL="gemini-2.5-flash"

# OR use OpenAI
# AI_PROVIDER="openai"
# OPEN_AI_KEY="your_openai_api_key"
# OPEN_AI_MODEL="gpt-4o"

# OR use Anthropic
# AI_PROVIDER="anthropic"
# ANTHROPIC_AI_KEY="your_anthropic_api_key"
# ANTHROPIC_AI_MODEL="claude-3-5-sonnet-20240620"

REMOTE_NAMES=("origin")
REMOTE_URLS=("https://github.com/username/repository.git")
ALLOW_ONE_MATCH="false"
```

Make sure to save the file with your correct credentials before using the tool.

## Usage

Generate and send a summary of your latest commit:

```bash
gitsa commit
```

Other commands:
- `gitsa --config` - Open configuration file for editing
- `gitsa --reset` - Reset configuration file to default
- `gitsa --help` - Show help information

## How It Works

When you run `gitsa commit`, the tool follows these steps:

1. **Remote Validation**: Checks that your git remotes match the configured URLs to ensure you're working with the correct repository
2. **Commit Data Collection**: Extracts commit details including hash, author, date, message, branch, and the diff of changes
3. **AI Summary Generation**: Sends the commit information and diff to your selected AI provider (Gemini, OpenAI, or Anthropic) with a carefully crafted prompt that requests a structured, developer-friendly summary
4. **Text Cleanup**: Processes the AI response to remove any formatting artifacts and extract the plain text summary
5. **Chat Selection**: If multiple Telegram chats are configured, presents an interactive menu to select which chat to send the summary to
6. **Telegram Delivery**: Sends the formatted summary to your selected Telegram chat

The entire process is logged to the console so you can see each step as it happens.

## Features

- **Multiple AI Providers**: Choose from Gemini, OpenAI, or Anthropic Claude
- **Multiple Telegram Chats**: Configure multiple chats and select which one to use for each commit
- **Interactive Chat Selection**: When multiple chats are configured, choose interactively which chat to send to
- **Flexible Remote Validation**: Configure multiple remotes with optional "allow one match" mode for multi-repo workflows
- **Clean Text Output**: Automatically processes AI responses to remove formatting artifacts

## Limitations

gitsa is designed to be simple and focused. Current limitations include:

- **Fixed Summary Format**: No options for summary length, modes, or format customization
- **Single Repository**: Works with one repository at a time
- **No History**: Does not cache or store previous summaries

These limitations keep the tool lightweight and easy to use, but they may be addressed in future updates.

## Future Work

Potential enhancements for future versions:

- Customizable summary formats and lengths
- Multi-repository support
- Summary history and caching
- Custom prompt templates
- Batch processing for multiple commits

## Updating gitsa

To update gitsa to the latest version:

1. Navigate to the installation directory:
   ```bash
   cd /usr/local/lib/gitsa
   ```

2. Pull the latest changes:
   ```bash
   sudo git pull
   ```

Your configuration file remains untouched during updates, so you won't need to reconfigure.

## Contributing

Contributions are welcome! Whether it's bug fixes, new features, documentation improvements, or suggestions, your input helps make gitsa better.

Feel free to open issues for bugs or feature requests, and submit pull requests for any improvements you'd like to contribute.

## TL;DR

Quick install and usage summary:

```bash
# 1. Clone the repo
git clone https://github.com/RaksaOC/gitsa.git
cd gitsa

# 2. Make installer executable
chmod +x install.sh

# 3. Install (system-wide, requires sudo)
sudo ./install.sh

# 4. Configure your credentials (opens nano)
gitsa --config
# - Set TELEGRAM_BOT_TOKEN (from BotFather)
# - Set AI_PROVIDER (gemini, openai, or anthropic)
# - Set provider-specific API keys and models
# - Set CHAT_IDS array (from Telegram getUpdates)
# - Set REMOTE_NAMES and REMOTE_URLS in matching pairs

# 5. Use it in your repo to send summary of latest commit to Telegram
gitsa commit
```
