FROM ruby:3.4-slim

RUN apt-get update -qq && \
  apt-get install -y \
  build-essential \
  sqlite3 \
  libsqlite3-dev \
  pkg-config \
  git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v 2.6.5 && \
  bundle config set --local build.sqlite3 "--with-sqlite3-dir=/usr/lib/x86_64-linux-gnu" && \
  bundle install

COPY . .

CMD ["ruby", "lib/cli.rb"]
