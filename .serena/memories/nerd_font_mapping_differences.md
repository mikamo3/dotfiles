# Nerd Font Mapping Differences

## 発見した問題
PlemolJP Console NFと公式Nerd Fontでフォントマッピングが異なる

## 具体例
- `U+E0A0` (git logo) → PlemolJP NFで表示されない
- `U+F0A2` (git logo) → PlemolJP NFで正常表示 `󰊢`
- `U+E0B0` (triangle) → PlemolJP NFで表示されない

## 原因
1. **バージョン差**: PlemolJP NF合成時とNerd Font公式版のバージョン違い
2. **Private Use Area**: U+E0xx系はPrivate Use Areaでフォント依存
3. **合成プロセス**: PlemolJP独自の合成で一部アイコンが欠落

## 対策
- ezaなどで動作するアイコン (`U+F0A2` 系) を使用
- 表示テストで確認してから設定に反映
- 問題のあるアイコンは代替を探す

## 推奨
配布先のNerd Fontアイコンセットに合わせてマッピングを調整する