#!/usr/bin/env bash

help(){
    echo -e "${BOLD}Usage:${NC} gitsa ${CYAN}[commit | --config | --reset | --help]${NC}\n"
    echo -e "${BOLD}Commands:${NC}"
    echo -e "  ${CYAN}commit${NC}   - Get an AI-generated summary of your latest commit and send it to your Telegram bot"
    echo -e "  ${CYAN}--config${NC}  - Open the configuration file in an editor"
    echo -e "  ${CYAN}--reset${NC}   - Reset your configuration file to default (empty)"
    echo -e "  ${CYAN}--help${NC}    - Show this help information"
}