FROM alpine:latest

WORKDIR /app

# Install dependencies
RUN apk update --no-cache \
    && apk add --no-cache bash \
    && apk add --no-cache coreutils \
    && apk add --no-cache jq \
    && apk add --no-cache speedtest-cli

# Add a more frequent timer to Crontab
RUN echo "*      *       *       *       *       /app/run_speedtest.sh" >> /etc/crontabs/root

# Add the source files
COPY ./run_speedtest.sh /app

# Run the cron daemon
CMD ["crond", "-f", "-l", "8"]
