# ChromiumとVS CodeのWayland対応修正セッション

## 問題
- ChromiumとVS CodeがXWaylandで起動していた
- fcitx5による日本語入力で以下の問題が発生：
  - 複数ウィンドウ起動時、片方のウィンドウで日本語入力ができない
  - 入力候補ウィンドウが表示されない

## 実施した修正

### 1. 現在の状況確認
- Hyprlandで`windowrulev2 = opaque, xwayland:1`設定によりXWaylandアプリが強制的にOpaque
- ChromiumとVS CodeはデフォルトでXWaylandで起動

### 2. fcitx5のWayland対応確認
- fcitx5 version: 5.1.14
- fcitx5-gtk、fcitx5-qtパッケージインストール済み
- 診断結果：WaylandアプリでWaylandフロントエンド（wayland_v2）が動作中
- 環境変数：QT_IM_MODULE=fcitx、XMODIFIERS=@im=fcitx

### 3. Chromium Wayland対応
**ファイル**: `~/.config/chromium-flags.conf`
```
# Chromium Wayland support
--enable-features=UseOzonePlatform
--ozone-platform=wayland
--enable-wayland-ime
```

**手動起動コマンド**:
```bash
chromium --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime
```

### 4. VS Code Wayland対応
**ファイル**: `~/.config/code-flags.conf`
```
# VS Code Wayland support
--enable-features=WaylandWindowDecorations
--ozone-platform-hint=auto
--enable-features=WebRTCPipeWireCapturer
```

## 期待される結果
- 両アプリケーションがWaylandネイティブで起動
- fcitx5の日本語入力問題（複数ウィンドウ・候補ウィンドウ）が解決

## 次回テスト項目
1. VS Codeで複数ウィンドウでの日本語入力テスト
2. Chromiumで複数ウィンドウでの日本語入力テスト
3. 入力候補ウィンドウの表示確認

## 参考情報
- Arch Wiki: Wayland#Electron
- fcitx5 diagnose結果でWaylandフロントエンド動作確認済み
- 設定ファイルは自動読み込まれるため、通常起動で有効