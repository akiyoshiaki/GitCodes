# Docker上でRailsプロジェクトを作る

[前回の記事のDocker超入門チュートリアル]()に引き続き、Docker上でRailsプロジェクトを作ってみたいと思います。

ではDockerfileを編集し、Rails本体と、Gemパッケージ管理ツールであるBundlerをインストールしてみましょう。

``` Dockerfile
BASE ruby:2.4.1

CMD gem install bundler
CMD gem install rails 5.0.0???
```

CMDはベースイメージ内で選択されているOS上にコマンドを発行することができます。
（正確にはDockerイメージやコンテナ自体にはカーネルは含みません。これがVMとの最大の違いだとは思いますがスキップします。）

さて、Railsプロジェクトの作成に必要なコマンドを先に書いてしまいましょう。


``` Dockerfile
BASE ruby:2.4.1

CMD gem install bundler
CMD gem install rails 5.0.0???
```
