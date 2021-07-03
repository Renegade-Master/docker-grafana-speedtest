FROM alpine:latest as run

# Install dependencies
RUN apk update --no-cache && apk upgrade --no-cache \
    && apk add --no-cache bash \
    && apk add --no-cache gcc \
    && apk add --no-cache jq \
    && apk add --no-cache musl-dev \
    && apk add --no-cache postgresql-dev \
    && apk add --no-cache py3-pip \
    && apk add --no-cache python3-dev \
    && apk add --no-cache speedtest-cli

# Install Python dependencies
RUN python3 -m pip install --upgrade pip \
    && pip install psycopg2

# Add a more frequent timer to Crontab
RUN echo "*/5    *       *       *       *       /app/run_speedtest.sh" >> /etc/crontabs/root

WORKDIR /app

# Add the source files
ADD ./run_speedtest.sh /app/
ADD upload_to_database.py /app/

# Run the cron daemon
CMD ["crond", "-f", "-l", "8"]
