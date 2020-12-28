# 浮動小数点を二つの10進数からなる文字列("3.14"のような)に変換する (Erlang)

```
iex(1)> :io.format("~.10f", [3.14])
3.1400000000
```

# オペレーションシステムの環境変数を取り出す (Elixir)

```
iex(3)> System.get_env("LANG")
"C.UTF-8"
```

# ファイル名の拡張子を取り出す ("dave/test.exs"なら.exsを返す) (Elixir)

```
iex(4)> Path.extname("dave/test.exs")
".exs"
```

# プロセスの現在の作業ディレクトリを返す (Elixir)

```
$ cd /var/tmp/
$ iex
Erlang/OTP 23 [erts-11.1.4] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1]

Interactive Elixir (1.11.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> File.cwd()
{:ok, "/var/tmp"}
```

# JSON文字列を、Elixirのデータ構造に変換する (見つけるだけで、インストールしないでいい)

https://github.com/michalmuskala/jason

# オペレーションシステムのシェルでコマンドを実行する

```
iex(1)> System.cmd("which", ["who"])  
{"/usr/bin/who\n", 0}
```
