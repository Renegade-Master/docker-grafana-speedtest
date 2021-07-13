#!/usr/bin/env bash

#######################################################################
#   Description:
#       Script to run an Ookla Speedtest CLI run, and upload the result
#       to a Database.
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

    python3 /app/upload_to_database.py "$OUTPUT_FILE"

    printf "\n-- Upload complete.\n"
}


# Reformat the result file
function format_results() {
    printf "\n-- Reformatting file...\n"

    local jq_query='[{
        "type": .type,
        "timestamp": .timestamp,

        "ping_jitter": .ping.jitter,
        "ping_latency": .ping.latency,

        "download_bandwidth": .download.bandwidth,
        "download_bytes": .download.bytes,
        "download_elapsed": .download.elapsed,

        "upload_bandwidth": .upload.bandwidth,
        "upload_bytes": .upload.bytes,
        "upload_elapsed": .upload.elapsed,

        "packetloss": .packetLoss,
        "isp": .isp,

        "result_id": .result.id,
        "result_url": .result.url
    }]'

    jq "$jq_query" "$OUTPUT_FILE.raw" > "$OUTPUT_FILE"

    printf "\n-- Reformat complete.\n"
}


# Run the speedtest, storing the file for later use
function run_speedtest() {
    printf "\n-- Running Speedtest against server: [%s]...\n" "$SERVER"

    # Run the Speedtest against the chosen server, or if one was not found, run a general Speedtest
    if [[ "$SERVER" != "" ]]; then
        speedtest --accept-license --accept-gdpr -v --server-id="$SERVER" --format=json > "$OUTPUT_FILE.raw"
    else
        speedtest --accept-license --accept-gdpr -v --format=json > "$OUTPUT_FILE.raw"
    fi

    printf "\n-- Speedtest complete.\n"
}


# Create variables for use in the script
function create_variables() {
    # DATETIME=$(date +%Y%m%dT%H%M%SZ)

    # Create a directory for the result if it does not already exist
    if [[ ! -e /app/results ]]; then
        mkdir /app/results
    fi

    local output_directory="/app/results"
    local output_filename="speedtest_result.json"
    OUTPUT_FILE="$output_directory/$output_filename"

    # Attempt to read the chosen server from Environment
    local chosen_provider=${SPEEDTEST_SERVER:-""}
    SERVER=$(speedtest --accept-license --accept-gdpr --servers | grep -i "$chosen_provider" | head -n 1 | cut -d ' ' -f 2)

    if [[ "$SERVER" == "" ]]; then
        printf "No server has been set.  Running generic Speedtest.\n"
    fi
}


## Main
create_variables
run_speedtest
format_results
upload_result_to_db
cleanup
