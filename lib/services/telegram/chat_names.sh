#!/usr/bin/env bash

get_chat_names(){
    local chat_names=()
    for chat_id in "${CHAT_IDS[@]}"; do
        response=$(curl -s "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/getChat?chat_id=${chat_id}")
        chat_type=$(echo "$response" | jq -r '.result.type // empty')
        
        if [ -z "$chat_type" ]; then
            echo -e "${YELLOW}[gitsa][telegram] Warning: Could not fetch chat info for ${chat_id}${NC}" >&2
            continue
        fi
        
        if [ "$chat_type" = "private" ]; then
            chat_name=$(echo "$response" | jq -r '.result.first_name // empty')
        else
            chat_name=$(echo "$response" | jq -r '.result.title // empty')
        fi
        
        if [ -n "$chat_name" ] && [ "$chat_name" != "null" ]; then
            chat_names+=("${chat_name}:${chat_id}")
        else
            echo -e "${YELLOW}[gitsa][telegram] Warning: Could not get name for chat ${chat_id}${NC}" >&2
        fi
    done

    printf '%s\n' "${chat_names[@]}"
}