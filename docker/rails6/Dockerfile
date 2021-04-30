# 2021.04.29 時点での最新安定板
FROM ruby:2.7.3

# ロケール環境変数をセット
ENV LANG C.UTF-8

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       default-mysql-client \
                       imagemagick

# 作業ディレクトリの作成
RUN mkdir /app
ENV APP_ROOT /app
WORKDIR $APP_ROOT

# ローカルの Gemfile, Gemfile.lock を作業ディレクトリにコピーする
COPY ./Gemfile* $APP_ROOT/

# bundle install
RUN bundle install --jobs=4

# ローカルのプロジェクトを作業ディレクトリにコピーする
COPY . $APP_ROOT
