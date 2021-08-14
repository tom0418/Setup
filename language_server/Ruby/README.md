# solargraph-docker

Solargraph runs in Docker container

Rubyの言語サーバ、SolargraphをDocker container上で動かす。

## Setup

1. Build docker image

```shell
$ cp YOUR_PROJECT_FOLDER/Gemfile YOUR_PROJECT_FOLDER/Gemfile.lock YOUR_PROJECT_FOLDER/.rubocop.yml
$ docker build -t vscode-solargraph:x.x.x .
```

2. Start docker container

```shell
$ docker run -d --rm -p 7658:7658 --name solargraph vscode-solargraph
```
3. Setup Visual Studio Code

```json
"solargraph.transport": "external",
"solargraph.externalServer": {
    "host": "localhost",
    "port": 7658
}
```
