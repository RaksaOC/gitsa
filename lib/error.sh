#!/usr/bin/env bash

error(){
    echo -e "${RED}${BOLD}ERROR:${NC} Unknown command: ${YELLOW}$1${NC}"
    echo -e "${BOLD}Usage:${NC} gitsa ${CYAN}[commit | --config | --reset | --help]${NC}"
    echo -e "${CYAN}Use${NC} 'gitsa --help' ${CYAN}for more info.${NC}"
    exit 1
}