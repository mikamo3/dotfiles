# East Asian Width問題の解決 (2025-07-31)

## 問題
- 日本語環境 (ja_JP.UTF-8) でのUnicode文字幅認識問題
- Nerd Fontアイコン(`󰊢` など)がAmbiguous (A)カテゴリで幅が不安定
- Unicode絵文字(`🤷` `📝` など)がWide (W)カテゴリで2文字幅
- `right_format`での時刻表示が位置ずれを起こす

## 解決策
- `right_format = ""` に変更してEast Asian Width問題を回避
- 2行形式プロンプトを維持

## 現在の状態
```
…/dotfiles 󰊢 master[📝🤷]
❯
```

## 今後の課題
- モノクロ・カラーアイコンの混在問題は残存
- 統一感のあるアイコンセットへの変更を検討可能