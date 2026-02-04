#!/usr/bin/env bash

reset(){
    echo -e "${YELLOW}[WARNING]${NC} All config will be cleared in ${YELLOW}$CONFIG${NC}."
    echo "
    # Telegram
    TELEGRAM_BOT_TOKEN=""
    CHAT_ID=""
    
    # AI
    SUMMARY_AI_KEY=""
    
    # Git remote validation
    REMOTE_NAMES=()
    REMOTE_URLS=()
    ALLOW_ONE_MATCH="false"
    " > "$CONFIG"
    echo -e "${MAGENTA}Config file reset successfully.${NC}"
}
