#!/usr/bin/env bash

get_openai_summary() {
    local prompt="$1"

    local payload
    payload=$(jq -n \
        --arg model "$OPEN_AI_MODEL" \
        --arg content "$prompt" \
        '{
            model: $model,
            messages: [
                {
                    role: "user",
                    content: $content
                }
            ],
            max_tokens: 512
        }')

    response=$(curl -s "https://api.openai.com/v1/chat/completions" \
        -H "Authorization: Bearer '"$OPEN_AI_KEY"'" \
        -H "Content-Type: application/json" \
        -d "$payload" \
        -X POST)

    echo "$response" | jq -r '.choices[0].message.content'
}