FROM crystallang/crystal:latest

RUN mkdir /app
COPY . /app
WORKDIR /app
RUN shards build
