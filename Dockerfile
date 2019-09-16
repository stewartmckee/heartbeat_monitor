FROM ruby:2.6-alpine3.10
WORKDIR /srv/www

COPY . ./
RUN gem install bundler && bundle install

ENTRYPOINT [ "bin/monitor" ]
