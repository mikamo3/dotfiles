# Firejail profile for a segregated Firefox sandbox
# Purpose: Separate from normal desktop Firefox profile while still allowing persistent cookies/history
# Usage: firejail --profile=$HOME/.config/firejail/firefox-sandbox.profile firefox -profile $SANDBOX_PROFILE
#
# Threat model: Lightweight containment, reduces accidental cross-profile leakage. Not a full exploit mitigation.
# Adjust seccomp/apparmor for hardened needs.

# Base on upstream firefox.profile but do NOT include host ~/.mozilla
# We will mount/allow only a dedicated sandbox profile directory.

# Generic restrictions
caps.drop all
seccomp
nonewprivs
# Disable private-dev by default; allow GPU/DRI selectively
nogroups

# Networking: keep enabled (comment next line to allow normal net)
# net none

# Allow Wayland/X11 sockets (user may choose one). For X11, :0 socket is in /tmp/.X11-unix
# They will be passed via --bind in launcher script rather than whitelisted here.

# Blacklist homedir then add minimal whitelists
blacklist ${HOME}
# Needed skeleton runtime dirs
whitelist ${HOME}/.cache
whitelist ${HOME}/.config/firejail

# Dedicated sandbox root (created by launcher):
whitelist ${HOME}/.local/share/firefox-sandbox
# Firefox will create profile subdir below:
whitelist ${HOME}/.local/share/firefox-sandbox/profile

# Ephemeral Downloads: launcher will create tmp dir and export SANDBOX_DOWNLOADS
whitelist ${HOME}/.local/share/firefox-sandbox/downloads

# Deny access to regular Firefox profiles
blacklist ${HOME}/.mozilla
blacklist ${HOME}/.cache/mozilla

# D-Bus minimal (IME, notifications) – allow session bus; comment out to block
whitelist ${XDG_RUNTIME_DIR}/bus
whitelist ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}
whitelist ${XDG_RUNTIME_DIR}/fcitx5

# Time/locale/fontconfig caches
whitelist /etc/machine-id
whitelist /etc/localtime
whitelist /usr/share/fonts
whitelist /usr/share/icons

# Writable tmp inside sandbox
private-tmp

# Prevent tracing and ptrace from sandbox
noroot
notv
nosound
# (enable sound by commenting nosound)

# DNS may be resolved; for isolation consider 'hosts-file' or 'net none'

# Avoid leaking environment variables for sensitive sessions
env -HOME

# Firejail will mount a new HOME. We still want relative paths inside process to map to sandbox root.
# Use a synthetic home rooted at ~/.local/share/firefox-sandbox
private-home ~/.local/share/firefox-sandbox

# If GPU needed, allow /dev/dri (comment to disable acceleration)
# whitelist /dev/dri
# whitelist /dev/shm

# If downloads are ephemeral, user may cleanup manually or script can remove directory afterwards.
