# Apache Commons Daemo 試しと残骸

## Jsvcは何者？
UNIX Daemon と Java を取り持つモジュール。
Jsvcは、JavaアプリケーションをUNIX上でより簡単に実行するためのライブラリとアプリケーションのセットです。
Jsvcはアプリケーション（例えばTomcat）がrootとしていくつかの特権操作（例えば1024未満のポートにバインド）を実行し、
それから身元を特権のないユーザに切り替えることを可能にします。
また、Cygwinエミュレーション層を介してWin32上で実行することができますが、Win32ユーザーは代わりにprocrunを使用することをお勧めします。
これにより、アプリケーションをWindowsサービスとして実行できます。
https://commons.apache.org/proper/commons-daemon/jsvc.html

## jsvcのビルド
### ビルドには下記が必要
* GNU AutoConf (at least version 2.53)
* An ANSI-C compliant compiler (GCC is good)
* GNU Make
* A Java Platform 2 compliant SDK

```bash
$ sudo apt-get install autoconf
```

### ビルド実行
```bash
$ cd commons-daemon-x.x.x-src/src/native/unix/
$ sh support/buildconf.sh
$ export JAVA_HOME=/usr/lib/jvm/java-x.x.x-openjdk-amd64
$ ./configure
*** All done ***
Now you can issue "make"
$ make
```

## Daemonの実行
```bash
$ sudo SampleDaemon.sh start

$ sudo SampleDaemon.sh stop

$ sudo SampleDaemon.sh restart
$ sudo SampleDaemon.sh start
```
# メモ
## ライブラリダウンロード、libディレクトリに出力
```
mvn dependency:copy-dependencies -DoutputDirectory=target\lib
```


# 参考URL
* [Apache Commons Daemonを使ってJavaのデーモンプログラムを作る](https://www.task-notes.com/entry/20150408/1428462000)
* [VPS にデーモンを常駐させて遊ぶ](https://another.maple4ever.net/archives/1651/)
