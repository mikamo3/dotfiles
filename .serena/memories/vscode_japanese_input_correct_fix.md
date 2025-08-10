# VS Code 日本語入力の正しい設定方法

## 公式Fcitx 5ドキュメントに基づく設定

### VS Code フラグ設定（正しい設定）
**ファイル**: `~/.config/code-flags.conf`
```
# VS Code Wayland support
--enable-features=WaylandWindowDecorations,WebRTCPipeWireCapturer,VaapiVideoDecoder,UseOzonePlatform
--ozone-platform=wayland
--enable-wayland-ime
--gtk-version=4
```

**重要**: 公式Fcitx 5ドキュメント（https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland#Chromium_.2F_Electron）によると、Chromium/ElectronアプリケーションであるVS Codeでは`--enable-wayland-ime`フラグを**有効にする**必要がある。

### 環境変数設定
**ファイル**: `~/.config/environment.d/00-fcitx.conf`
```
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=@im=fcitx5
XDG_CONFIG_HOME=$HOME/.config
```

## 公式ドキュメントからの重要な情報
- VS Code (Electron) では `--enable-wayland-ime` が必要
- text-input-v1 プロトコルを使用
- ポップアップIMEウィンドウの位置に問題がある場合がある
- コンポジタ（Waylandウィンドウマネージャ）によってサポート状況が異なる

## 適用方法
1. VS Codeを完全に終了
2. 新しく VS Code を起動（フラグが適用される）
3. 日本語入力をテスト

## 以前の間違った情報について
以前のメモリで`--enable-wayland-ime`を削除するよう記載していたが、これは公式ドキュメントに反する情報だった。正しくは、このフラグを**有効にする**必要がある。