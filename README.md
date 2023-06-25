# flaper
flatpakでのソフトのインストール、実行、更新、文字化け改善に対応。

# 対応環境
ディストリに依存しないことを目標にしています。

今のところ下記でのみ動作確認しています。
- debian12
- ubuntu22.04
- openSUSE Tumbleweed
- openSUSE Leap 15.5（15.4も多分大丈夫）
- Garuda
- manjaro
- Alter
- Fedora38


# 準備
```
./setup.sh
```

# 実行
```
./flaper.sh
```

# 機能
- flatpakでインストール
- flatpacで探してインストール
- flatpakのソフト起動※
- flatpakのソフト更新※
- flatpakの全ソフト更新
- flatpakの文字化け改善※
- flatpakのソフト削除※

※の機能はflaperでインストールしたソフトにのみ対応しています。

# TODO
- [ ] RedHat系対応
- [ ] Arch系対応
- [X] Fedora系対応  
