#!/usr/bin/env bash

commit(){
    echo -e "${CYAN}[gitsa] Generating commit summary...${NC}"

    check_matching_remotes
    get_git_data

    ai_generated_summary=$(get_ai_summary "$commit_message" "$commit_author" "$current_branch" "$commit_hash" "$commit_date" "$diff")
    
    # Additional check to clean backticks which breaks telegram
    final_ai_generated_summary=$(remove_backticks "$ai_generated_summary")

    telegram_send_message "$final_ai_generated_summary"

    echo -e "${CYAN}[gitsa][ai] AI summary:${NC}"
    echo "--------------------------------------------------"
    echo "$final_ai_generated_summary"
    echo "--------------------------------------------------"
}