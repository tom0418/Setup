# プロジェクトに合わせてRUBY_VERSIONを指定する
ARG RUBY_VERSION=2.7.4

FROM ruby:$RUBY_VERSION-alpine

ENV APP_ROOT /usr/src/app

# プロジェクトのGemをインストールするために必要なパッケージのインストール
RUN apk add --no-cache --virtual build-deps \
        build-base && \
        linux-headers \
        libxml2-dev \
        make \
        gcc \
        libc-dev \
        mariadb-dev \
        tzdata && \
    rm -rf /usr/lib/libmysqld* && \
    rm -rf /usr/bin/mysql*

WORKDIR $APP_ROOT

COPY ./Gemfile* ./.rubocop* ./rails.rb $APP_ROOT
RUN gem install bundler
RUN bundle install --jobs=4

# solargraphのインストール
RUN gem install solargraph yard
RUN yard gems
RUN solargraph bundle

# Gemのインストール完了後、パッケージを削除する
RUN apk del build-deps

EXPOSE 7658

CMD [ "solargraph", "socket", "--host=0.0.0.0", "--port=7658" ]
