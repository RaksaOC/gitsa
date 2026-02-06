#!/usr/bin/env bash

check_deps(){
    if [ -z "$TELEGRAM_BOT_TOKEN" ] || [ -z "$AI_PROVIDER" ] || [ -z "$CHAT_ID" ] || [ -z "$REMOTE_NAMES" ] || [ -z "$REMOTE_URLS" ] || [ -z "$ALLOW_ONE_MATCH" ]; then
        echo -e "${RED}${BOLD}ERROR:${NC} Missing required dependencies in ${YELLOW}gitsa_config.sh${NC}"
        echo -e "${MAGENTA}→ Please use ${CYAN}gitsa --config${NC} ${MAGENTA}to complete your configuration.${NC}"
        exit 1
    fi

    case "$AI_PROVIDER" in
        gemini)
            if [ -z "$GEMINI_AI_KEY" ] || [ -z "$GEMINI_AI_MODEL" ]; then
                echo -e "${RED}${BOLD}ERROR:${NC} Missing required dependencies in ${YELLOW}gitsa_config.sh${NC}"
                echo -e "${MAGENTA}→ Please use ${CYAN}gitsa --config${NC} ${MAGENTA}to complete your configuration.${NC}"
                exit 1
            fi
        ;;

        openai)
            if [ -z "$OPEN_AI_KEY" ] || [ -z "$OPEN_AI_MODEL" ]; then
                echo -e "${RED}${BOLD}ERROR:${NC} Missing required dependencies in ${YELLOW}gitsa_config.sh${NC}"
                echo -e "${MAGENTA}→ Please use ${CYAN}gitsa --config${NC} ${MAGENTA}to complete your configuration.${NC}"
                exit 1
            fi
        ;;
        anthropic)
            if [ -z "$ANTHROPIC_AI_KEY" ] || [ -z "$ANTHROPIC_AI_MODEL" ]; then
                echo -e "${RED}${BOLD}ERROR:${NC} Missing required dependencies in ${YELLOW}gitsa_config.sh${NC}"
                echo -e "${MAGENTA}→ Please use ${CYAN}gitsa --config${NC} ${MAGENTA}to complete your configuration.${NC}"
                exit 1
            fi
        ;;
        *)
            echo -e "${RED}${BOLD}ERROR:${NC} Unknown AI provider: ${YELLOW}$AI_PROVIDER${NC}"
            echo -e "${MAGENTA}→ Please use ${CYAN}gitsa --config${NC} ${MAGENTA}to complete your configuration.${NC}"
            exit 1
        ;;
    esac
}