#!/usr/bin/env bash

#######################################################################
#   Description:
#       Script to run an Ookla Speedtest CLI run, and upload the result
#       to a Redis Database.
#######################################################################

# Remove working files to prepare for the next run
function cleanup() {
    printf "\n-- Removing working files...\n"

    rm "$OUTPUT_FILE.raw"
    rm "$OUTPUT_FILE"

    printf "\n-- Files removed.\n"
}


# Upload the result file to Database
function upload_result_to_db() {
    printf "\n-- Uploading result...\n"

    python3 /app/upload_to_database.py

    printf "\n-- Upload Successful.\n"
}


function test_db_connection() {
    printf "\n-- Testing DB Connection...\n"

    redis-cli -h "redis-db" ping

    printf "\n-- Connection Successful.\n"
}


# Reformat the result file
function format_results() {
    printf "\n-- Reformatting file...\n"

    local jq_query="
    [ . | del(.server) | del(.client) ]
    "

    jq "$jq_query" "$OUTPUT_FILE.raw" > "$OUTPUT_FILE"

    printf "\n-- Reformat complete.\n"
}


# Run the speedtest, storing the file for later use
function run_speedtest() {
    printf "\n-- Running Speedtest...\n"

    speedtest --server 38092 --secure --share --json > "$OUTPUT_FILE.raw"

    printf "\n-- Speedtest complete.\n"
}


# Create variables for use in the script
function create_variables() {
    # DATETIME=$(date +%Y%m%dT%H%M%SZ)

    if [[ ! -e /app/results ]]; then
        mkdir /app/results
    fi

    local output_directory="/app/results"
    local output_filename="speedtest_result.json"

    OUTPUT_FILE="$output_directory/$output_filename"
}


## Main
create_variables
run_speedtest
format_results
test_db_connection
upload_result_to_db
cleanup
