#!/usr/bin/env bash

get_gemini_summary() {
    local prompt="$1"

    payload=$(jq -n \
        --arg text "$prompt" \
        '{
            "contents": [
                {
                    "parts": [
                        {
                            "text": $text
                        }
                    ]
                }
            ]
        }'
    )

    response=$(curl -s "https://generativelanguage.googleapis.com/v1beta/models/$GEMINI_AI_MODEL:generateContent" \
        -H "x-goog-api-key: $GEMINI_AI_KEY" \
        -H "Content-Type: application/json" \
        -X POST \
        -d "$payload")

    echo "$response" | jq -r '.candidates[0].content.parts[0].text'
}