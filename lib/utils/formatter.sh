#!/usr/bin/env bash

# Function to remove backticks from a string
remove_backticks() {
    # Usage: remove_backticks "input string"
    echo "${1//\`/}"
}