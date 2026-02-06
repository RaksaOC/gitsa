#!/usr/bin/env bash

telegram_send_message() {
    local final_ai_generated_summary="$1"

    payload=$(jq -n \
        --arg chat_id "$CHAT_ID" \
        --arg text "$final_ai_generated_summary" \
        '{
            "chat_id": $chat_id,
            "text": $text
        }'
    )

    echo -e "${CYAN}[gitsa][telegram] Sending to Telegram...${NC}"

    local response
    response=$(curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
        -H "Content-Type: application/json" \
        -d "$payload")

    if [ -n "$response" ]; then
        local ok chat_title
        ok=$(echo "$response" | jq -r '.ok // "false"' 2>/dev/null)
        chat_title=$(echo "$response" | jq -r '.result.chat.title // empty' 2>/dev/null)

        if [ "$ok" = "true" ]; then
            echo -e "${GREEN}[gitsa][telegram] Sent successfully to Telegram!${NC}"
            echo -e "${GREEN}[gitsa][telegram] Chat: ${YELLOW}${chat_title}${NC}"
        else
            echo -e "${RED}[gitsa][telegram] Failed to send message to Telegram.${NC}"
        fi
    else
        echo -e "${YELLOW}[gitsa][telegram] No response received from Telegram API.${NC}"
    fi
}