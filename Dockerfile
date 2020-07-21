# Arguments
ARG BUILD_VERSION=0

FROM ruby:2.6.6-slim AS base
WORKDIR /srv/slate
VOLUME /srv/slate/source
EXPOSE 4567
COPY . /srv/slate

FROM base AS slate-version-0
RUN echo "this is original source"
ENV ACTIVE_VERSION='slate-version-0'
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        nodejs \
    && gem install bundler \
    && bundle install \
    && apt-get remove -y build-essential \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
CMD ["bundle", "exec", "middleman", "server", "--watcher-force-polling"]

FROM base AS slate-version-1
RUN echo "this is mirror-enabled source"
ENV ACTIVE_VERSION='slate-version-1'
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

FROM slate-version-${BUILD_VERSION} AS slate-final
RUN echo "this is final source extend ${ACTIVE_VERSION}"
