FROM alpine:latest as build

WORKDIR /tmp

# Install dependencies
#RUN apk update --no-cache && apk upgrade --no-cache \
#    && apk add --no-cache alpine-sdk \
#    && apk add --no-cache bash \
#    && apk add --no-cache cargo \
#    && apk add --no-cache git \
#    && apk add --no-cache make \
#    && apk add --no-cache rust

RUN apk update --no-cache && apk upgrade --no-cache
RUN apk add --no-cache alpine-sdk
RUN apk add --no-cache bash
RUN apk add --no-cache cargo
RUN apk add --no-cache clang-libs
RUN apk add --no-cache cmake
RUN apk add --no-cache git
RUN apk add --no-cache linux-headers
RUN apk add --no-cache llvm11
RUN apk add --no-cache openssl-dev
RUN apk add --no-cache python3-dev

# Download the source
RUN git clone https://github.com/RedisJSON/RedisJSON.git \
    && cd RedisJSON \
    && git submodule update --init --recursive \
    && git fetch; git pull origin master --ff-only \
    && git submodule foreach git fetch; git submodule foreach git pull origin master --ff-only

# Build Redis JSON
RUN cd RedisJSON \
    && make -d setup build
#    && make platform OSNICK=armv7l


FROM redis:alpine as run

# Copy the module from the previous step
COPY --from=build /tmp/src/rejson.so /tmp/

# Install the RedisJson module
RUN redis-server --loadmodule /tmp/rejson.so
