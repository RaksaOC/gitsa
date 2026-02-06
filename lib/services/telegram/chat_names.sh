#!/usr/bin/env bash

get_chat_names(){
    local chat_ids="$1"
    local chat_names=()
    for chat_id in $chat_ids; do
        local chat_name=$(curl -s "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/getChat?chat_id=${chat_id}" | jq -r '.result.title')
        chat_names+=("${chat_name (${chat_id})}")
    done

    echo "${chat_names[@]}"
}