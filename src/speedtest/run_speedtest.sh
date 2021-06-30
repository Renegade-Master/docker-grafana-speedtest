#!/usr/bin/env bash

#######################################################################
#   Description:
#       Script to run an Ookla Speedtest CLI run, and upload the result
#       to a Redis Database.
#######################################################################

# Test the DB connection
function test_db_connection() {
    printf "\n-- Testing DB Connection...\n"

    redis-cli -h "redis-db" ping

    printf "\n-- Connection Successful.\n"
}

# Run the speedtest, storing the file for later use
function run_speedtest() {
    printf "\n-- Running Speedtest...\n"

    speedtest --server 38092 --secure --json  > "$OUTPUT_FILE"

    printf "\n-- Speedtest complete.\n"
}

# Create variables for use in the script
function create_variables() {
    DATETIME=$(date +%Y%m%dT%H%M%SZ)

    if [[ ! -e /app/results ]]; then
        mkdir /app/results
    fi

    local output_directory="/app/results"
    local output_filename="speedtest_result-$DATETIME.json"

    OUTPUT_FILE="$output_directory/$output_filename"
}

## Main
create_variables
run_speedtest
test_db_connection
