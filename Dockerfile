FROM ruby:2.6.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
WORKDIR /myapp

ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN gem update --system
RUN gem install bundler
RUN bundle update --bundler
RUN bundle install
ADD . /myapp

