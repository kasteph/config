#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PYENV_ROOT="$HOME/.pyenv"

export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"
export GOMODCACHE="$GOPATH/pkg/mod"

# Enable shims and autocompletion
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

alias doom="$HOME/.emacs.d/bin/doom"

export PATH="$HOME/.poetry/bin:$PYENV_ROOT/bin:$PATH:$GOBIN"
