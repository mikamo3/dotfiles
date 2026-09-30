# dotfiles

個人用 dotfiles。Arch Linux + Hyprland (Wayland) 環境向け。

[chezmoi](https://www.chezmoi.io/) で管理。パッケージインストールは [arch-ansible](https://github.com/mikamo3/arch-ansible) が担当し、本リポジトリはユーザー設定のみを扱う。

## セットアップ

```bash
# arch-ansible で git / chezmoi / zsh など最低限のツールを導入後:
git clone https://github.com/mikamo3/dotfiles ~/.local/share/chezmoi
~/.local/share/chezmoi/init.sh
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

## SSHでの作業再開

接続先にもこの設定を適用すると、対話的なSSH接続時にZellijの `ssh` セッションを作成・再利用する。
切断後も接続先が稼働していれば、再接続で実行中の作業に戻れる。

手元のZellijとの入れ子を避けるため、LinuxではSSH専用のGhosttyウィンドウを開く。
SSHを直接起動するため、手元のZellij自動起動は通らない。

```sh
ghostty -e ssh 接続先
```

画面分割は接続先のZellijで行う。同じ接続先・ユーザーへの複数接続は同じ `ssh` セッションを共有する。
`ssh 接続先 コマンド` やSCPなどの非対話処理では自動起動しない。
接続先の再起動やZellijの終了では実行中の処理は保持されない。

VS Codeの統合ターミナル（Remote-SSHを含む）は、VS Codeの環境変数を検出してZellijの自動起動を無効にする。
設定反映後、新しい統合ターミナルを開く。
統合ターミナルから手動で `ssh` する場合は判定用の環境変数が接続先へ渡らないことがあるため、次のように明示的に無効化する。

```sh
ssh -t 接続先 'ZELLIJ_AUTO_START=0 zsh -il'
```

自動起動を一時的に回避して接続する場合:

```sh
ghostty -e ssh -t 接続先 'ZELLIJ_AUTO_START=0 zsh -il'
```

## ライセンス

[MIT](LICENSE)
