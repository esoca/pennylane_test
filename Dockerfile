FROM ruby:3.1.3

MAINTAINER esoca123@gmail.com

RUN rm -rf /var/cache/apk/*

ENV APP_PATH /opt/app
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

COPY . .

EXPOSE 3000
