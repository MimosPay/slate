FROM ruby:2.6.6-slim

WORKDIR /srv/slate

VOLUME /srv/slate/source
EXPOSE 4567

COPY . /srv/slate

# APT mirror
ADD sources.list sources.list
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && mv sources.list /etc/apt/

# RubyGems mirror
RUN gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
RUN gem sources -l

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        nodejs \
    && gem install bundler

RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.com \
    && bundle install \
    && apt-get remove -y build-essential \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

CMD ["bundle", "exec", "middleman", "server", "--watcher-force-polling", "--verbose"]
