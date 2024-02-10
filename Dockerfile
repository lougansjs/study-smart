FROM ruby:3.1.2
MAINTAINER lougansjs <lougans.lougans99@gmail.com>

ENV NODE_VERSION 12
ENV INSTALL_PATH /opt/app

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends nano postgresql-client \
      locales

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN export LC_ALL="en_US.utf8"

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle install

COPY . $INSTALL_PATH