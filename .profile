export SOURCED_PROFILE=1
export SESSION_DIR="$HOME/.local/session"
export MAIL_DIR="$HOME/.mail"
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient"
export SSH_AUTH_SOCK=/run/user/$UID/gnupg/S.gpg-agent.ssh
# fix stupid new LS behaviour
export QUOTING_STYLE=literal

gpg-connect-agent /bye
epass serve-credentials start &

# broken JIT in javascriptcore; disable.
export JavaScriptCoreUseJIT=0

# disable coredumps
ulimit -S -c 0 >/dev/null 2>&1

systemctl --user import-environment

export LESS="-R -W"
