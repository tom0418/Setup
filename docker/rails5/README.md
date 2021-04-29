# 開発環境セットアップ

Docker Compose を使用して Rails5 / MySQL5.7 のアプリをセットアップ〜起動する手順です。

## はじめに

開始する前に、[Docker Desktopをインストール][1]します。

## セットアップ

### Rails5 + MySQL5.7

1. Rails プロジェクトを作成

    ```shell
    $ docker-compose run web rails new . --force --database=mysql --skip-bundle --skip-test
    ```

1. database.yml を編集

    ```yaml:database.yml
    default: &default
      adapter: mysql2
      encoding: utf8mb4
      pool: <%= ENV.fetch('RAILS_MAX_THREADS') { 5 } %>
      username: <%= ENV.fetch('MYSQL_USER') { 'root' } %>
      password: <%= ENV.fetch('MYSQL_PASSWORD') { 'password' } %>
      host: <%= ENV.fetch('MYSQL_HOST') { 'db' } %>
    ```

1. Docker Image を構築

    ```shell
    $ docker-compose build --no-cache
    ```

1. 必要な Gem と Webpacker をインストール

    プロジェクトに合わせて、Gemfile を編集してから以下を実行してください。

    ```shell
    # bundle install
    $ docker-compose run --rm web bundle install

    # webpacker install
    $ docker-compose run --rm web rails webpacker:install
    ```

1. webpacker.yml を編集

    ./config/webpacker.yml の以下項目を、docker-compose.yml で定義したservice 名に合わせて設定してください。

     ```yaml:webpacker.yml
    dev_server:
      ...
      host: webpacker
      ...
      ...
    ```

1. コンテナを立ち上げる
   ```
    $ docker-compose up
    ``````

1. データベースを作成

    ```shell
    $ docker-compose run --rm web rails db:create
    ```

1. 起動確認

    ブラウザで localhost:3000 にアクセスしてください。

[1]:https://docs.docker.com/install/
