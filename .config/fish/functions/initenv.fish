function initenv -d "initialize shell environment"
  echo "update xdg user directory"
  LC_ALL=C xdg-user-dirs-update --force

  echo "create directory"

  set  DIR_GOOGLE_DRIVE googleDrive
  set  DIR_DROPBOX Dropbox
  set  DIR_WALLPAPER Pictures/wallpapers
  set  DIR_SCREENSHOT Pictures/screenshot
  set  DIR_LOCALLOG .local/log
  set  DIR_CHEATSHEET .cheatsheet

  mkdir -p ~/$DIR_LOCALLOG
  mkdir -p ~/$DIR_GOOGLE_DRIVE
  mkdir -p ~/$DIR_DROPBOX
  mkdir -p ~/$DIR_WALLPAPER
  mkdir -p ~/$DIR_SCREENSHOT
  mkdir -p ~/$DIR_CHEATSHEET

  echo "enable user service"

  systemctl --user enable grive-changes@(systemd-escape "$DIR_GOOGLE_DRIVE").service
  systemctl --user enable grive-timer@(systemd-escape "$DIR_GOOGLE_DRIVE").timer

  echo "install tpm plugin"
  if test ! -d ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  end 

  if test (pip list --user | grep -c pynvim) = 0
    pip install --user pynvim
  end 
end