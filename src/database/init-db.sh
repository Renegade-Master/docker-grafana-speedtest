#!/usr/bin/env bash

#######################################################################
#   Description:
#       Script to setup and configure a Postgres Database.
#######################################################################

psql -U postgres <<-EOSQL
    CREATE DATABASE speedtest_data;

    \connect speedtest_data

    BEGIN;
        CREATE TABLE results (
            type VARCHAR(128),
            timestamp timestamptz,

            ping_jitter DECIMAL,
            ping_latency DECIMAL,

            download_bandwidth INTEGER,
            download_bytes INTEGER,
            download_elapsed INTEGER,

            upload_bandwidth INTEGER,
            upload_bytes INTEGER,
            upload_elapsed INTEGER,

            packetloss DECIMAL,

            isp VARCHAR(128),

            result_id VARCHAR(128) PRIMARY KEY,
            result_url VARCHAR(128)
        );
    COMMIT;
EOSQL
