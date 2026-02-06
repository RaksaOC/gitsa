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
- **Gemini API Key**: Get your API key from [Google AI Studio](https://makersuite.google.com/app/apikey)
- **Telegram Chat ID**: The ID of the chat where summaries will be sent (can be a group or private chat).  
  You can get this by calling the `getUpdates` endpoint on the Telegram Bot API, for example:
  `https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates`.  
  For private groups, add the bot to the group, send a message, then call `getUpdates` and look for the negative `chat.id` value.
- **Git Remote Configuration**: Configure your repository remotes for validation.  
  `REMOTE_NAMES` and `REMOTE_URLS` are parallel arrays: each name at index `i` must match the URL at index `i`.  
  For example, if you have two remotes, `origin` and `backup`, make sure both arrays line up in the same order.

Example configuration:
```bash
TELEGRAM_BOT_TOKEN="your_telegram_bot_token"
SUMMARY_AI_KEY="your_gemini_api_key"
CHAT_IDS=("your_chat_id")

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
3. **AI Summary Generation**: Sends the commit information and diff to Gemini AI with a carefully crafted prompt that requests a structured, developer-friendly summary
4. **Text Cleanup**: Processes the AI response to remove any formatting artifacts and extract the plain text summary
5. **Telegram Delivery**: Sends the formatted summary to your configured Telegram chat

The entire process is logged to the console so you can see each step as it happens.

## Limitations

gitsa is designed to be simple and focused. Current limitations include:

- **Single Chat Only**: Messages are sent to one configured Telegram chat
- **Gemini AI Only**: Uses Google's Gemini API exclusively (no other AI providers)
- **No Chat Selection**: Cannot choose different chats per commit
- **Fixed Summary Format**: No options for summary length, modes, or format customization

These limitations keep the tool lightweight and easy to use, but they may be addressed in future updates.

## Future Work

Potential enhancements for future versions:

- Support for multiple Telegram chats
- Integration with other AI providers (OpenAI, Claude, etc.)
- Customizable summary formats and lengths
- Interactive chat selection
- Multi-repository support
- Summary history and caching
- Custom prompt templates

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
# - Set SUMMARY_AI_KEY (from Google AI Studio)
# - Set CHAT_IDS (from Telegram getUpdates)
# - Set REMOTE_NAMES and REMOTE_URLS in matching pairs

# 5. Use it in your repo to send summary of latest commit to Telegram
gitsa commit
```
