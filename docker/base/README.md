# ベースイメージ

開発で使用する各言語のベースイメージ用のDockerfileを保存する。

ディストリビューション、言語、パッケージのバージョンを上げる際はこれらのベースイメージを修正する。

| directory | Linux distribution | Languages | packages |
|:---------:|:------------------:|:---------:|:--------:|
| [Ruby][Ruby] | Debian 12 | Ruby（3.1.4） | node.js（18.16.0）, yarn（1.22.19） |

[Ruby]:https://github.com/tom0418/Setup/tree/main/docker/base/Ruby
