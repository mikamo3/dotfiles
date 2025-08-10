# Fcitx5 VS Code 日本語入力の最終的な正しい設定

## 重要な発見
`fcitx5-diagnose` により以下が判明:
- 環境変数は `fcitx` を使用する（`fcitx5` ではない）
- `GTK_IM_MODULE` が設定されていなかった
- VS Codeは正常にWayland frontend (wayland_v2) で認識されている
- Mozcが正しく設定されている

## 正しい設定

### 1. 環境変数設定
**ファイル**: `~/.config/environment.d/00-fcitx.conf`
```
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
XDG_CONFIG_HOME=$HOME/.config
```

**ファイル**: `~/.config/uwsm/env`
```
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
XDG_CONFIG_HOME=$HOME/.config
```

### 2. VS Code設定
**ファイル**: `~/.config/code-flags.conf`
```
# VS Code Wayland support
--enable-features=WaylandWindowDecorations,WebRTCPipeWireCapturer,VaapiVideoDecoder,UseOzonePlatform
--ozone-platform=wayland
--enable-wayland-ime
--gtk-version=4
```

## 適用方法
1. セッションを完全に再起動（ログアウト/ログイン）
2. VS Codeを起動
3. 日本語入力をテスト

## 診断で確認されたポイント
- fcitx5は正常に動作中 (PID 104504)
- VS CodeはWayland frontend (wayland_v2)で認識済み
- Mozcが入力メソッドとして設定済み
- ロケールは ja_JP.UTF-8 で正常

## 重要事項
- Arch Linuxの公式ドキュメントでは環境変数は `fcitx` を使用
- `fcitx5` ではなく `fcitx` が正しい値
- `GTK_IM_MODULE` の設定が最も重要