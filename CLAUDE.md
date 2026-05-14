# CLAUDE.md

Personal dotfiles managed with **chezmoi**. Arch Linux (Hyprland / Wayland) 向け。

## 構成

- パッケージ管理は arch-ansible が担当。このリポジトリはユーザー設定のみを管理する
- マシン固有の差分 (モニター構成など) は chezmoi テンプレートで吸収する
- Wayland-first: X11 固有の設定は扱わない

## chezmoi 規則

- `dot_` プレフィックス → `~/.` に展開 (例: `dot_config/` → `~/.config/`)
- `.tmpl` サフィックス → テンプレートとして処理
- マシン差分は `{{ .chezmoi.hostname }}` で分岐
- マシン固有の変数は `~/.config/chezmoi/chezmoi.toml` の `[data]` セクションで定義
- 機密情報は `chezmoi secret` または `age` 暗号化を使用

## インストール済みアプリケーション

arch-ansible の shell / desktop / apps / media / development ロールが導入するツール群。
設定ファイルが必要なものを以下に列挙する。

### シェル / ターミナル
- **zsh** — メインシェル (`~/.zshrc`)
- **sheldon** — zsh プラグインマネージャ (`~/.config/sheldon/plugins.toml`)
- **starship** — プロンプト (`~/.config/starship.toml`)
- **ghostty** — ターミナルエミュレータ (`~/.config/ghostty/`)
- **zellij** — ターミナルマルチプレクサ (`~/.config/zellij/`)
- **atuin** — シェル履歴 (`~/.config/atuin/`)

### Wayland / Hyprland
- **hyprland** — compositor (`~/.config/hypr/hyprland.conf`) ← モニター設定はテンプレート化
- **waybar** — ステータスバー (`~/.config/waybar/`)
- **fuzzel** — アプリランチャ (`~/.config/fuzzel/`)
- **swaync** — 通知 (`~/.config/swaync/`)
- **hyprlock** (`~/.config/hypr/hyprlock.conf`)
- **hypridle** (`~/.config/hypr/hypridle.conf`)
- **hyprpaper** (`~/.config/hypr/hyprpaper.conf`)

### エディタ
- **neovim** (`~/.config/nvim/`)
- **helix** (`~/.config/helix/`)

### 開発
- **git** (`~/.gitconfig`) ← git-delta / difftastic の設定を含む
- **lazygit** (`~/.config/lazygit/`)
- **ghq** — ルートディレクトリを gitconfig で設定

### その他
- **fcitx5** — IME (`~/.config/fcitx5/`)
- **zathura** — PDF (`~/.config/zathura/`)
- **mpv** — 動画 (`~/.config/mpv/`)
- **btop** (`~/.config/btop/`)
- **yazi** (`~/.config/yazi/`)
