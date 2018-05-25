export BROWSER=xdg-open
export SOURCED_PROFILE=1
export MAIL_DIR="$HOME/.mail"
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient"
# fix stupid new LS behaviour
export QUOTING_STYLE=literal
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"

# broken scrolling in soffice
export GDK_CORE_DEVICE_EVENTS=1

# disable coredumps
ulimit -S -c 0 >/dev/null 2>&1
export LESS="-R -W"
