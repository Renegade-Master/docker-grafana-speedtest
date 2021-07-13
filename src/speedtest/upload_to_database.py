#!/usr/bin/env python3

#######################################################################
#   Description:
#       Script to upload a JSON file to a Postgres Database.
#######################################################################
import sys
from json import load
from sys import exit
from psycopg2 import connect, Error
from datetime import datetime


def upload_to_postgres(filename: str) -> None:
    """
    Upload a JSON file to a Postgres DB.

    :param filename: The path of the JSON results file to load
    :return: None
    """

    # Postgres table name
    table_name = "results"

    print("\ntable name for JSON data:", table_name)

    # use Python's open() function to load the JSON data
    with open(filename) as json_data:
        # use load() rather than loads() for JSON files
        record_list = load(json_data)

    print("\nrecords:", record_list)
    print("\nJSON records object type:", type(record_list))  # should return "<class 'list'>"

    # concatenate an SQL string
    sql_string = f"INSERT INTO {table_name} "

    # if record list then get column names from first key
    if type(record_list) == list:
        first_record = record_list[0]

        columns = list(first_record.keys())
        print("\ncolumn names:", columns)

    # if just one dict obj or nested JSON dict
    else:
        print("Needs to be an array of JSON objects")
        exit()

    # enclose the column names within parenthesis
    sql_string += "(" + ', '.join(columns) + ")\nVALUES "

    # enumerate over the record
    for i, record_dict in enumerate(record_list):

        # iterate over the values of each record dict object
        values = []
        for col_names, val in record_dict.items():

            # Postgres strings must be enclosed with single quotes
            if type(val) == str:
                # escape apostrophes with two single quotations
                val = val.replace("'", "''")
                val = "'" + val + "'"

            # Change Timestamp to Epoch
            # print(col_names)
            # if col_names == "timestamp":
            #     utc_time = datetime.strptime("2009-03-08T00:27:31.807Z", "%Y-%m-%dT%H:%M:%S.%fZ")
            #     val = (utc_time - datetime(1970, 1, 1)).total_seconds()

            # Change PacketLoss to Decimal
            if col_names == "packetloss":
                if val is None:
                    val = 0

            values += [str(val)]

        # join the list of values and enclose record in parenthesis
        sql_string += "(" + ', '.join(values) + "),\n"

    # remove the last comma and end statement with a semicolon
    sql_string = sql_string[:-2] + ";"

    print("\nSQL string:")
    print(sql_string)

    try:
        # declare a new PostgreSQL connection object
        conn = connect(
            dbname="speedtest_data",
            user="postgres",
            host="postgres-db",
            password="password",
            # attempt to connect for 3 seconds then raise exception
            connect_timeout=3
        )

        cur = conn.cursor()
        print("\ncreated cursor object:", cur)

    except (Exception, Error) as err:
        print("\npsycopg2 connect error:", err)
        conn = None
        cur = None

    # only attempt to execute SQL if cursor is valid
    if cur is not None:

        try:
            cur.execute(sql_string)
            conn.commit()

            print('\nfinished INSERT INTO execution')

        except (Exception, Error) as error:
            print("\nexecute_sql() error:", error)
            conn.rollback()

        # close the cursor and connection
        cur.close()
        conn.close()


if __name__ == "__main__":
    """
    Main method
    """

    filename: str = sys.argv[1]

    upload_to_postgres(filename)
