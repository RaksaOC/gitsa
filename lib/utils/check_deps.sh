#!/usr/bin/env bash

check_deps(){
    if [ -z "$TELEGRAM_BOT_TOKEN" ] || [ -z "$SUMMARY_AI_KEY" ] || [ -z "$CHAT_ID" ] || [ -z "$REMOTE_NAMES" ] || [ -z "$REMOTE_URLS" ] || [ -z "$ALLOW_ONE_MATCH" ]; then
        echo -e "${RED}${BOLD}ERROR:${NC} Missing required dependencies in ${YELLOW}gitsa_config.sh${NC}"
        echo -e "${MAGENTA}→ Please use ${CYAN}gitsa --config${NC} ${MAGENTA}to complete your configuration.${NC}"
        exit 1
    fi
}