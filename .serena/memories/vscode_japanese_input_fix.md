# VS Code 日本語入力問題の完全修正

## 問題
VS Codeで日本語入力ができない

## 原因
1. VS Codeの`code-flags.conf`で`--enable-wayland-ime`フラグが有効になっていた（すでに修正済み）
2. 環境変数でGTK_IM_MODULEが設定されていなかった
3. fcitx5を使用しているのに環境変数がfcitxになっていた

## 修正方法

### 1. VS Codeフラグ設定（すでに修正済み）
**ファイル**: `~/.config/code-flags.conf`
```
# VS Code Wayland support
--enable-features=WaylandWindowDecorations,WebRTCPipeWireCapturer,VaapiVideoDecoder
--ozone-platform=wayland
--gtk-version=4
```
（`--enable-wayland-ime`フラグは削除済み）

### 2. 環境変数の設定
**ファイル**: `~/.config/environment.d/00-fcitx.conf`
```
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=@im=fcitx5
XDG_CONFIG_HOME=$HOME/.config
```

**ファイル**: `~/.config/uwsm/env`
```
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=@im=fcitx5
XDG_CONFIG_HOME=$HOME/.config
```

## 適用方法
1. セッションを再起動（またはログアウト/ログイン）
2. VS Codeを起動
3. 日本語入力をテスト

## 重要なポイント
- `GTK_IM_MODULE=fcitx5`が必要（GTKアプリケーション用）
- `QT_IM_MODULE=fcitx5`も更新（fcitx5用）
- `XMODIFIERS=@im=fcitx5`も更新
- VS Codeの`--enable-wayland-ime`フラグは無効にする