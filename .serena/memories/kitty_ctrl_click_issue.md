# kitty CTRL+左クリック問題

## 問題
- kittyでCTRL+左クリックによるURL開封機能が動作しない

## 環境情報
- kitty version: 0.42.2
- OS: Linux 6.15.7-zen1-1-zen
- 設定ファイル: `.config/kitty/kitty.conf:78`

## 現在の設定
```
mouse_map ctrl+left click ungrabbed mouse_click_url_or_select
```

## その他の関連設定
```
url_style curly
open_url_with default
detect_urls yes
```

## 作成したissue
- GitHub Issue #65: "kitty: CTRL+左クリックでURLを開く機能が動作しない"
- URL: https://github.com/mikamo3/dotfiles/issues/65

## 今後の対応
- 設定の構文確認
- kittyの設定リロード
- ログやエラーメッセージの確認
- 他のマウス設定との競合確認
- Waylandでの動作確認