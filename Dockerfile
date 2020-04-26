FROM elixir:1.10

RUN apt-get update
RUN apt-get install --yes build-essential inotify-tools postgresql-client

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force

RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs

WORKDIR /app
EXPOSE 4000

