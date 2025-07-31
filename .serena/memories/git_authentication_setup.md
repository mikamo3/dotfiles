# Git認証設定の作業ログ

## 問題
- kitty terminalでのgit pushで毎回認証情報の入力が求められる
- VSCodeでは認証情報を聞かれない

## 原因の調査結果
- VSCodeは独自の認証システムを使用（`GIT_ASKPASS`環境変数）
- リモートURLがHTTPS接続（`https://github.com/mikamo3/dotfiles`）
- Git認証ヘルパーが未設定

## 検討した解決策
1. **SSH接続への変更** - 却下（HTTPS認証ヘルパーを希望）
2. **1Password CLI連携** - 試行したが`credential`コマンドが利用不可
3. **git-credential-libsecret** - 採用

## 実装した解決策
- **git-credential-libsecret**を認証ヘルパーとして設定
- 設定コマンド: `git config --global credential.helper /usr/lib/git-core/git-credential-libsecret`
- GNOME Keyringが既に動作中であることを確認
- 認証情報は安全にGNOME Keyringに保存される

## 結果
- 初回push時のみ認証情報入力が必要
- 以降のgit操作では自動認証
- pushが正常に動作することを確認

## 関連する設定ファイル
- `.gitconfig`: Git認証ヘルパー設定を含む
- GNOME Keyring: 認証情報の保存先

## 推奨事項
- GitHub Personal Access Tokenの使用（username/passwordより安全）