FROM elixir:1.10

WORKDIR /app

RUN apt-get update
RUN apt-get install --yes build-essential inotify-tools postgresql-client

RUN mix local.rebar --force && \
    mix local.hex --force

COPY mix.* ./

RUN mix deps.get && \
    mix deps.compile

RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs

EXPOSE 4000
CMD ["start"]

