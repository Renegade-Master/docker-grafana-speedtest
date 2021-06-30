FROM alpine:latest as run

RUN apk update --no-cache && apk upgrade --no-cache \
    && apk add --no-cache bash \
    && apk add --no-cache jq \
    && apk add --no-cache redis \
    && apk add --no-cache speedtest-cli

# Add a more frequent timer to Crontab
RUN echo "*/10   *       *       *       *       /app/run_speedtest.sh" >> /etc/crontabs/root

WORKDIR /app

# Add the source files
COPY ./run_speedtest.sh /app

# Run the cron daemon
CMD ["crond", "-f", "-l", "8"]
