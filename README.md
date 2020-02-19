## これは?
`Headless Chrome` を使って `Selenium` を動かすサンプルです。<br />
`Selenium` を動かすスクリプトは `ruby` で書いてます。

## 環境
`Docker` と `Docker Compose` を使用してます。<br />
各バージョンは `docker-compose.yml` の `arg` で渡している値で設定しています。

```
      args:
        RUBY_VERSION: 2.6
        CHROME_VERSION: 80.0.3987.106-1
        CHROMIUM_DRIVER_VERSION: 80.0.3987.106
```

## 実行方法

```sh
$ docker-compose up
```
上記コマンドでコンテナ内で `main.rb` を走らせてます。