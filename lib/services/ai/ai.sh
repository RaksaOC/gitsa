#!/usr/bin/env bash

get_ai_summary() {
    local commit_message="$1"
    local commit_author="$2"
    local current_branch="$3"
    local commit_hash="$4"
    local commit_date="$5"
    local diff="$6"

    echo -e "${CYAN}[ai] Requesting AI summary for commit ${YELLOW}${commit_hash}${NC} on branch ${YELLOW}${current_branch}${NC}..." >&2

    local prompt
    prompt="$(get_base_prompt "$commit_message" "$commit_author" "$current_branch" "$commit_hash" "$commit_date" "$diff")"

    case "$AI_PROVIDER" in
        gemini)
            source "$GITSA_DIR/lib/services/ai/gemini.sh"
            summary="$(get_gemini_summary "$prompt")"
            ;;
        openai)
            source "$GITSA_DIR/lib/services/ai/openai.sh"
            summary="$(get_openai_summary "$prompt")"
            ;;
        anthropic)
            source "$GITSA_DIR/lib/services/ai/anthropic.sh"
            summary="$(get_anthropic_summary "$prompt")"
            ;;
        *)
            error "Unknown AI_PROVIDER: $AI_PROVIDER"
            ;;
    esac

    echo -e "${CYAN}[gitsa][ai] AI response received.${NC}" >&2
    echo "$summary"
}