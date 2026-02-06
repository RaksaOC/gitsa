#!/usr/bin/env bash

get_git_data(){
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    commit_hash=$(git log -1 --pretty=format:"%H")
    commit_author=$(git log -1 --pretty=format:"%an")
    commit_date=$(git log -1 --pretty=format:"%ad")
    commit_message=$(git log -1 --pretty=format:"%s")
    diff=$(git diff HEAD~1 HEAD | tr -d '\000-\031' | head -c 5000 )

    echo -e "${CYAN}[gitsa][git] Collected latest commit data:${NC}"
}