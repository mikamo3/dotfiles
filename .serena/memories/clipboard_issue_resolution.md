# Clipboard Issue Resolution (2025-07-31)

## Problem
ターミナルエミュレータ（kitty, alacritty, foot）で文字選択・コピーペーストができない問題が発生。GUIアプリケーション（Firefox, leafpad）では正常動作。

## Root Cause
**zellij設定の `copy_on_select false`** が原因。zellijがターミナル入力を管理しているため、ターミナルエミュレータの設定が無効化されていた。

## Solution
`.config/zellij/config.kdl` で `copy_on_select false` をコメントアウト（デフォルト動作に委ねる）
`.config/kitty/kitty.conf` で `copy_on_select yes` に設定

## Key Learning
- 階層的な制御: TerminalEmulator → Multiplexer(zellij) → Shell(fish)
- zellijが動作している場合、zellij設定が優先される
- 設定の責任分離：kittyがクリップボード管理、zellijはセッション管理に専念