#!/usr/bin/env bash

config(){
    if [ -f "$CONFIG" ]; then
        echo -e "${CYAN}Opening existing ${YELLOW}$CONFIG${CYAN} for editing...${NC}"
        nano "$CONFIG"
    else 
        echo -e "${CYAN}Creating new ${YELLOW}$CONFIG${CYAN}...${NC}"
        touch "$CONFIG"
        nano "$CONFIG"
    fi
}

