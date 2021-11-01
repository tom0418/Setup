FROM t0m0418/ruby:3.0.2-bullseye

# 必要なパッケージのインストール
# imagemagick など適宜インストールする

# 作業ディレクトリの作成
RUN mkdir /project_name
ENV API_ROOT /project_name
WORKDIR $API_ROOT

# ローカルの Gemfile, Gemfile.lock を作業ディレクトリにコピーする
COPY ./Gemfile* $API_ROOT/

# bundle install
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --jobs=4

# ローカルのプロジェクトを作業ディレクトリにコピーする
COPY . $API_ROOT
