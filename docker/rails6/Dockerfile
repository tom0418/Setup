# 2021.04.29 時点での最新安定板
FROM ruby:2.7.3

# ロケール環境変数をセット
ENV LANG C.UTF-8

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       default-mysql-client \
                       imagemagick \
                       apt-transport-https

# 作業ディレクトリの作成
RUN mkdir /app
ENV APP_ROOT /app
WORKDIR $APP_ROOT

# ローカルの Gemfile, Gemfile.lock を作業ディレクトリにコピーする
COPY ./Gemfile* $APP_ROOT/

# yarn をインストール
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs yarn
RUN gem uninstall bundler && gem install -N bundler

# bundle install
RUN bundle install --jobs=4

# ローカルのプロジェクトを作業ディレクトリにコピーする
COPY . $APP_ROOT
