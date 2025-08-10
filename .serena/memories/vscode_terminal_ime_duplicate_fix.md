# VS Code ターミナル日本語入力重複問題の修正

## 問題
VS Codeのターミナルで日本語入力を確定すると、入力した文字が重複して表示される

## 原因
VS Codeの`code-flags.conf`で`--enable-wayland-ime`フラグが有効になっていたため、VS Code内蔵のWayland IMEとfcitx5が競合していた

## 修正方法
**ファイル**: `~/.config/code-flags.conf`

**修正前**:
```
# VS Code Wayland support
--enable-features=WaylandWindowDecorations,WebRTCPipeWireCapturer,VaapiVideoDecoder
--ozone-platform=wayland
--enable-wayland-ime
--gtk-version=4
```

**修正後**:
```
# VS Code Wayland support
--enable-features=WaylandWindowDecorations,WebRTCPipeWireCapturer,VaapiVideoDecoder
--ozone-platform=wayland
--gtk-version=4
```

## 変更内容
- `--enable-wayland-ime`フラグを削除
- これによりVS CodeはGTK経由でfcitx5を使用するようになり、重複問題を回避

## テスト方法
1. VS Codeを再起動
2. ターミナルを開く
3. 日本語入力をテスト（重複しないことを確認）

## 注意
VS Codeを完全に再起動する必要がある（ウィンドウを閉じるだけでは設定が反映されない場合がある）