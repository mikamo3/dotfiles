# dotfiles

個人用 dotfiles。Arch Linux + Hyprland (Wayland) 環境向け。

[chezmoi](https://www.chezmoi.io/) で管理。パッケージインストールは [arch-ansible](https://github.com/mikamo3/arch-ansible) が担当し、本リポジトリはユーザー設定のみを扱う。

## セットアップ

```bash
# arch-ansible で git / chezmoi / zsh など最低限のツールを導入後:
git clone https://github.com/mikamo3/dotfiles ~/.kawazu/dotfiles
cd ~/.kawazu/dotfiles
./init.sh
```

`init.sh` は冪等。再実行時は差分のみ適用。

## 主な構成

- シェル: zsh + sheldon + starship + atuin
- WM: Hyprland (Wayland) + waybar + fuzzel + swaync
- エディタ: neovim / helix
- ターミナル: ghostty / kitty + zellij
- ファイラ: yazi
- テーマ: Catppuccin Mocha 統一

詳細なツール一覧は [CLAUDE.md](CLAUDE.md) を参照。

## ライセンス

[MIT](LICENSE)
