#!/bin/bash

INPUT_FILE="$1"
ALLOW_LIST="$2"
BLOCK_LIST="$3"

while IFS=',' read -r line; do
    if ! [[ ${line} =~ $ALLOW_LIST ]] || [[ ${line} =~ $BLOCK_LIST ]]; then
        echo $line >>blocked_licenses.csv
    else
        echo $line >>allowed_licenses.csv
    fi
done < <(sed 1d "$INPUT_FILE")
