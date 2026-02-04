#!/usr/bin/env bash

check_matching_remotes(){
    echo -e "${CYAN}[gitsa][git] Checking configured git remotes...${NC}"

    local matched_remote=0
    local num_of_remotes=${#REMOTE_NAMES[@]}

    for i in "${!REMOTE_NAMES[@]}"; do
        name=${REMOTE_NAMES[$i]}
        url=${REMOTE_URLS[$i]}
        remote_url=$(git remote get-url "$name" 2>/dev/null)
        if [ "$remote_url" == "$url" ]; then
            matched_remote=$((matched_remote + 1))
            echo -e "  - ${BOLD}${name}${NC}: ${GREEN}OK${NC} (expected: ${YELLOW}${url}${NC})"
        else
            echo -e "  - ${BOLD}${name}${NC}: ${RED}MISMATCH${NC}"
            echo -e "      expected: ${YELLOW}${url}${NC}"
            echo -e "      actual:   ${CYAN}${remote_url:-<none>}${NC}"
        fi
    done

    if [ "$ALLOW_ONE_MATCH" == "true" ]; then
        if [ "$matched_remote" -lt 1 ]; then
            echo -e "${RED}${BOLD}ERROR:${NC} No remotes matched expected URLs. Please review your remote URLs in ${YELLOW}gitsa_config.sh${NC}"
            exit 1
        fi
    else
        if [ "$matched_remote" -ne "$num_of_remotes" ]; then
            echo -e "${YELLOW}${BOLD}WARNING:${NC} Remote URL mismatch. Please review your remote URLs in ${YELLOW}gitsa_config.sh${NC}"
            exit 1
        fi
    fi

    echo -e "${CYAN}[gitsa][git] Remote check complete. Matched ${matched_remote}/${num_of_remotes} remotes.${NC}"
}

get_git_data(){
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    commit_hash=$(git log -1 --pretty=format:"%H")
    commit_author=$(git log -1 --pretty=format:"%an")
    commit_date=$(git log -1 --pretty=format:"%ad")
    commit_message=$(git log -1 --pretty=format:"%s")
    diff=$(git diff HEAD~1 HEAD | tr -d '\000-\031' | head -c 5000 )

    echo -e "${CYAN}[gitsa][git] Collected latest commit data:${NC}"
}