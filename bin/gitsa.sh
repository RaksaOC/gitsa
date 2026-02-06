#!/usr/bin/env bash

set -e

# Resolve the real path of this script, even if it's symlinked
CONFIG="${HOME}/.config/gitsa/gitsa_config.sh"

# check if config consists of all required config
if [ ! -f "$CONFIG" ]; then
    echo -e "${RED}${BOLD}ERROR:${NC} Configuration file not found at ${YELLOW}$CONFIG${NC}"
    echo -e "${MAGENTA}→ Please run: ${CYAN}gitsa --config${NC} ${MAGENTA}to generate your config file.${NC}"
    exit 1
fi

SOURCE="${BASH_SOURCE[0]}"

while [ -L "$SOURCE" ]; do
  DIR="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done

GITSA_DIR="$(cd -P "$(dirname "$SOURCE")/.." >/dev/null 2>&1 && pwd)"


source "$GITSA_DIR/lib/error.sh"
source "$GITSA_DIR/lib/config.sh"
source "$GITSA_DIR/lib/reset.sh"
source "$GITSA_DIR/lib/help.sh"
source "$GITSA_DIR/lib/commit.sh"

source "$GITSA_DIR/lib/services/ai/ai.sh"
source "$GITSA_DIR/lib/services/ai/prompt.sh"
source "$GITSA_DIR/lib/services/ai/gemini.sh"
source "$GITSA_DIR/lib/services/ai/openai.sh"
source "$GITSA_DIR/lib/services/ai/anthropic.sh"

source "$GITSA_DIR/lib/services/telegram/telegram.sh"
source "$GITSA_DIR/lib/services/telegram/chat_names.sh"

source "$GITSA_DIR/lib/services/git/git_data.sh"
source "$GITSA_DIR/lib/services/git/check_remotes.sh"

source "$GITSA_DIR/lib/utils/color.sh"
source "$GITSA_DIR/lib/utils/check_deps.sh"
source "$GITSA_DIR/lib/utils/formatter.sh"

# source the config
source "$CONFIG"

if [ "$1" == "commit" ]; then
    check_deps
    commit
elif [ "$1" == "--config" ]; then
    config
elif [ "$1" == "--reset" ]; then
    reset
elif [ "$1" == "--help" ]; then
    help
else
    error "$1"
fi