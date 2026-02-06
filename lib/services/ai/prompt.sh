#!/usr/bin/env bash

get_base_prompt() {
    local commit_message="$1"
    local commit_author="$2"
    local current_branch="$3"
    local commit_hash="$4"
    local commit_date="$5"
    local diff="$6"

    BASE_PROMPT="Summarize this git commit in plain text format. Use emojis as section headers and special characters like bullet points (• or ○). Follow this exact structure:

    🎉 NEW COMMIT!

    ===============
    📋 Commit Details
    ===============

    Message: $commit_message
    Author: $commit_author
    Branch: $current_branch
    Hash: $commit_hash
    Date: $commit_date

    ===============
    📝 Description
    ===============

    Provide a concise but medium-short-length summary of what this commit does. Focus on:
    • The purpose of the commit
    • Features added or bugs fixed
    • Any relevant context

    ===============
    🔧 File Changes & Technical Details 
    ===============

    • List the key files affected (based on the diff)
    • Describe important technical changes in plain language (new functions, methods, interfaces, or logic updates)
    • You may mention a single line, variable name, or statement if relevant, but NEVER include code blocks or large code snippets
    • Use bullet points (• or ○) for clarity
    • Describe code changes in natural simple concise language, not code

    Diff (for reference, don't include in the output):
    $diff

    **Strict Instructions:**
    1. Output ONLY plain text - no Markdown, no backticks, no code blocks
    2. Use emojis for section headers (📋, 📝, 🔧, etc.)
    3. Use bullet points with • characters
    4. Never include code snippets - only describe changes in natural language
    5. You may mention a variable name, function name, or single statement if relevant, but keep it minimal 
    6. Always follow this structure exactly - do not omit sections
    7. Medium short length output, assume the reader is a developer
    8. Use regular newlines for readability
    9. Never use Unicode escapes - output raw characters directly, never use \u00a0 or \u00a1 or any other unicode escape characters just pure plain text

    Output the entire response as plain text only."

    echo "$BASE_PROMPT"
}

