export BROWSER=xdg-open
export SOURCED_PROFILE=1
export SESSION_DIR="$HOME/.local/session"
export MAIL_DIR="$HOME/.mail"
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient"
# fix stupid new LS behaviour
export QUOTING_STYLE=literal

gpg-connect-agent -q updatestartuptty /bye
passm -s &

export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
if [ ! -S "${SSH_AUTH_SOCK}" ]; then
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

# broken JIT in javascriptcore; disable.
export JavaScriptCoreUseJIT=0
# broken scrolling in soffice
export GDK_CORE_DEVICE_EVENTS=1

# disable coredumps
ulimit -S -c 0 >/dev/null 2>&1
export LESS="-R -W"
