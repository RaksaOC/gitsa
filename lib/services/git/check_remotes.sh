#!/usr/bin/env bash

check_matching_remotes(){
    echo -e "${CYAN}[gitsa][git] Checking configured git remotes...${NC}"

    local matched_remote=0
    local num_of_remotes=${#REMOTE_NAMES[@]}

    for i in "${!REMOTE_NAMES[@]}"; do
        name=${REMOTE_NAMES[$i]}
        url=${REMOTE_URLS[$i]}

        # Protect against 'set -e' killing the whole script if a remote name doesn't exist
        remote_url=$(git remote get-url "$name" 2>/dev/null || true)


        if [ "$remote_url" = "$url" ]; then
            matched_remote=$((matched_remote + 1))
            echo -e "  - ${BOLD}${name}${NC}: ${GREEN}OK${NC} (expected: ${YELLOW}${url}${NC})"
        fi
    done

    if [ "$ALLOW_ONE_MATCH" = "true" ]; then
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