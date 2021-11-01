# 開発環境セットアップ

Docker Compose を使用して Rails6（APIモード） / MySQL 8.0.27 の開発環境をセットアップ〜起動する手順です。

## はじめに

開始する前に、[Docker Desktopをインストール][1]します。

## セットアップ

### Rails6 + MySQL5.7

1. Rails プロジェクトを作成

    ```shell
    $ docker compose run api rails new . --api --force --database=mysql --skip-bundle --skip-test
    ```

1. database.yml を編集

    ```yaml:database.yml
    default: &default
      adapter: mysql2
      encoding: utf8mb4
      pool: <%= ENV.fetch('RAILS_MAX_THREADS') { 5 } %>
      username: <%= ENV.fetch('MYSQL_USERNAME') { 'root' } %>
      password: <%= ENV.fetch('MYSQL_PASSWORD') { 'password' } %>
      host: <%= ENV.fetch('MYSQL_HOST') { 'db' } %>
    ```

1. application.rb の module を作成したいプロジェクトの名前に変更

1. database.yml の development, test の database を手順3に合わせて変更

1. Docker Image を構築

    ```shell
    $ docker compose build --no-cache
    ```

1. 必要な Gem と Webpacker をインストール

    プロジェクトに合わせて、Gemfile を編集してから以下を実行してください。

    ```shell
    # bundle install
    $ docker compose run --rm api bundle install

    # webpacker install
    $ docker compose run --rm api rails webpacker:install
    ```

1. コンテナを立ち上げる

    ```shell
    $ docker compose up
    ``````

1. データベースを作成

    ```shell
    $ docker compose run --rm api rails db:create
    ```

1. 起動確認

    ブラウザで localhost:3000 にアクセスしてください。

[1]:https://docs.docker.com/install/
