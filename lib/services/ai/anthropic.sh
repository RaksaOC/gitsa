#!/usr/bin/env bash

get_anthropic_summary() {
    local prompt="$1"

    local payload
    payload=$(jq -n \
        --arg model "$ANTHROPIC_AI_MODEL" \
        --arg text "$prompt" \
        '{
            model: $model,
            max_tokens: 512,
            messages: [
                {
                    role: "user",
                    content: [
                        { type: "text", text: $text }
                    ]
                }
            ]
        }')

    response=$(curl -s "https://api.anthropic.com/v1/messages" \
        -H "x-api-key: '"$ANTHROPIC_AI_KEY"'" \
        -H "anthropic-version: 2023-06-01" \
        -H "Content-Type: application/json" \
        -d "$payload" \
        -X POST)

    echo "$response" | jq -r '.content[0].text'
}