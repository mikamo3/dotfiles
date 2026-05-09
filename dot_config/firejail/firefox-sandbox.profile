###############################
# firefox-sandbox.profile
# ローカルにインストールされたシステム Firefox (/usr/bin/firefox) を既存ユーザープロファイル (~/.mozilla) から分離して起動するための最小 Firejail プロファイル。
# 目的: Cookie/履歴を専用ディレクトリに保持しつつ通常プロファイルへアクセス不可、ダウンロードは揮発化可。
# 起動例: firejail --profile="$HOME/.config/firejail/firefox-sandbox.profile" firefox -profile "$SANDBOX_PROFILE"
# 脅威モデル: 誤操作やセッション混在の軽減。ブラウザ RCE からの脱出防止は限定的なので高リスク用途は追加ハードニング (seccomp 拡張/AppArmor/ネットワーク制限) を検討。
# 注意: 公式 `firefox.profile` を include していません。必要であれば先頭に `include /etc/firejail/firefox.profile` を追加し、その後で不要 whitelist を再ブラックリスト化してください。
###############################

## 基本制限
caps.drop all          # 可能な限りケーパビリティ除去
seccomp                # デフォルト seccomp フィルタ
nonewprivs             # setuid 等による昇格防止
nogroups               # 追加グループ削除 (video 等は whitelist で個別許可)

# Networking: keep enabled (comment next line to allow normal net)
# net none

# Allow Wayland/X11 sockets (user may choose one). For X11, :0 socket is in /tmp/.X11-unix
# They will be passed via --bind in launcher script rather than whitelisted here.

## ホームディレクトリ全体遮断 → 最小限の whitelist を追加
blacklist $HOME
whitelist $HOME/.cache              # フォント等のキャッシュ (private-cache 併用時は不要なら削除可)
whitelist $HOME/.config/firejail    # このプロファイル自身へのアクセス

# Dedicated sandbox root (created by launcher):
whitelist $HOME/.local/share/firefox-sandbox
# Firefox will create profile subdir below:
whitelist $HOME/.local/share/firefox-sandbox/profile

# Ephemeral Downloads: launcher will create tmp dir and export SANDBOX_DOWNLOADS
whitelist $HOME/.local/share/firefox-sandbox/downloads

## 既存 Firefox プロファイルへのアクセス禁止
blacklist $HOME/.mozilla
blacklist $HOME/.cache/mozilla

## D-Bus/IME (必要に応じて削除して遮断)
whitelist $XDG_RUNTIME_DIR/bus
whitelist $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY
whitelist $XDG_RUNTIME_DIR/fcitx5

# Time/locale/fontconfig caches
whitelist /etc/machine-id
whitelist /etc/localtime
whitelist /usr/share/fonts
whitelist /usr/share/icons

private-tmp  # 書込み可能な一時領域を独立

# Prevent tracing and ptrace from sandbox
noroot    # root ユーザー化防止
notv      # TV デバイス不要
nosound   # サウンド無効 (必要ならコメントアウト)

# DNS may be resolved; for isolation consider 'hosts-file' or 'net none'

# Avoid leaking environment variables for sensitive sessions
env -HOME  # HOME 変数の漏洩抑制 (private-home 指定で内部HOMEは切替)

# Firejail will mount a new HOME. We still want relative paths inside process to map to sandbox root.
# Use a synthetic home rooted at ~/.local/share/firefox-sandbox
private-home ~/.local/share/firefox-sandbox   # 合成 HOME 指定

# If GPU needed, allow /dev/dri (comment to disable acceleration)
# whitelist /dev/dri
# whitelist /dev/shm

# If downloads are ephemeral, user may cleanup manually or script can remove directory afterwards.
