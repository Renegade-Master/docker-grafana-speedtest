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
            timestamp timestamptz PRIMARY KEY,
            download DECIMAL,
            upload DECIMAL,
            ping DECIMAL,
            bytes_sent INTEGER,
            bytes_received INTEGER,
            share VARCHAR(128)
        );
    COMMIT;
EOSQL
