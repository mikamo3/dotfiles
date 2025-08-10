# VSCode ポップアップウィンドウの中央配置修正

## 問題
VSCodeのポップアップウィンドウが左端に表示される問題を修正した。当初は全てのVSCodeウィンドウが中央に配置されてしまっていた。

## 解決策
Hyprlandの設定でfloating状態を判定条件として使用：

```conf
# VSCode specific rules: center any floating Code windows
windowrulev2 = center, class:Code, floating:1
```

## 動作原理
- ポップアップウィンドウは自動的に `floating:1` になる
- メインウィンドウは通常 `tiled` 状態
- `floating:1` の条件でポップアップのみを中央配置

## ファイル
- 修正ファイル: `.config/hypr/hyprland.conf` (196行目)
- 以前の問題のあった設定: `windowrule = center, class:Code` (削除済み)

## 検証したウィンドウ情報
- 小さなポップアップ: size 405x121, floating:1, fullscreen:0
- メインウィンドウ: size 3440x1440, floating:1, fullscreen:2 (手動フルスクリーン)

この方法はディスプレイサイズやフルスクリーン状態に依存せず、確実にポップアップを判定できる。