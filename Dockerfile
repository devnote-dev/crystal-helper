FROM crystallang/crystal:latest

RUN mkdir /app
COPY . /app
WORKDIR /app
RUN shards build

CMD [ "/bin/crystal", "src/cr-helper.cr" ]
