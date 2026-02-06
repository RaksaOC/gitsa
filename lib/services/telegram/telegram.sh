#!/usr/bin/env bash

telegram_send_message() {
    local final_ai_generated_summary="$1"

    local selected_chat_id
    local chats=$(get_chat_names "$CHAT_IDS")

    echo "Select a chat to send to:"
    for i in "${!chats[@]}"; do
        printf "  %d) %s\n" $((i+1)) "${chats[i]%%:*}"
    done

    while true; do
        read -rp "Enter choice: " choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#chats[@]} )); then
            selected_chat_id="${chats[choice-1]#*:}"
            break
        fi
        echo "Invalid selection. Try again."
    done

    payload=$(jq -n \
        --arg chat_id "$selected_chat_id" \
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