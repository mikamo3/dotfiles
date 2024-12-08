# Firejail profile for Firefox with a custom profile
# Separate user profile directory for persistence

# Isolate home directory and whitelist the custom Firefox profile
private-home

whitelist ${HOME}/.mozilla/firefox/27a5y6vn.ai

noblacklist ${HOME}/.cache/mozilla
noblacklist ${HOME}/.mozilla

# Networking and security restrictions
netfilter
caps.drop all
seccomp
nonewprivs
