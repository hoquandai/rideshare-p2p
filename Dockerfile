FROM ruby:2.6.3
# RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
# RUN apt-get install -y mcrypt libmcrypt-dev nodejs

# Install bare dependencies
RUN apt-get update -qq && \
  apt-get install -y \
  apt-utils \
  build-essential \
  nodejs \
  default-libmysqlclient-dev \
  libpq-dev \
  postgresql \
  vim nano 

ENV RAILS_ROOT /app

RUN mkdir $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile* ./
RUN gem install bundler && bundle install -j 20 -r 5

COPY . $RAILS_ROOT

EXPOSE 3000

ENV DB_HOST=db \
    DB_PORT=3306 \
    DB_USER=root \
    DB_PASS=12345678 \
    DB_NAME=moneyworld_dev

ENTRYPOINT ["bundle", "exec"]

CMD ["rails", "server", "-b", "0.0.0.0"]

