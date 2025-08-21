# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# DISABLE_AUTO_TITLE="true"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/node_modules/eslint/bin
# export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
# export PATH="/usr/local/opt/mysql@5.7/support-files:$PATH"
export PATH="/Applications/Alacritty.app/Contents/MacOS:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export EDITOR=nvim

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
PATH=$(pyenv root)/shims:$PATH


PATH="${HOME}/workspace/git-scripts:${PATH}"
export WORKON_HOME="${HOME}/.workon"
if [ ! -d "${WORKON_HOME}/git-scripts/bin" ]; then
  mkdir -p "${WORKON_HOME}/git-scripts/bin"
fi
touch "${WORKON_HOME}/git-scripts/bin/activate_this.py"


checkIfSnapTxRepo() {
  SNAPTX_REPO="/Users/priyanklalitkantkapadia/projects/snapsheet-tx"
  currentDir=${pwd}
  if [[ "$currentDir" == "$SNAPTX_REPO" ]]
  then
    return 0
  else
    return 1
  fi
}

function createSnapTxDB {
  if checkIfSnapTxRepo;
  then
    bundle exec rake db:drop
    bundle exec rake db:create
    bundle exec rake db:structure:load
    bundle exec rake db:test:prepare
  else
    echo 'You are not in snaptx repo'
  fi
}

function createSnapTxAccount {
  if checkIfSnapTxRepo;
  then
    bundle exec rake setup:all
    bundle exec rake 'setup:permission_groups_and_users[Priyank, Kapadia, priyank.kapadia]'
    bundle exec rake 'users:create_admin[Priyank, Kapadia, priyank.kapadia@snapsheet.me]'
  else
    echo 'you are not in snaptx repo'
  fi
}

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export DISABLE_SPRING=true
setopt EXTENDED_HISTORY

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

mysqlv() {
    brew services stop mysql@8.0
    brew services stop mysql@5.7
    brew unlink mysql@8.0 mysql@5.7
    brew link --force --overwrite $1
    brew services start $1
}

# Change directory to a specific Git branch worktree
unset -f cdwt 2>/dev/null  # Clear any existing function definition
cdwt() {
  local branch="$1"
  local current_dir="$PWD"
  local parent_dir="$(dirname "$current_dir")"
  
  # Check if we're in a worktree folder (parent contains other directories)
  if [ $(find "$parent_dir" -maxdepth 1 -type d | wc -l) -gt 2 ]; then
    # We're in a worktree folder, go to parent then to branch
    cd "$parent_dir/$branch"
  else
    # We're in the parent folder, go directly to branch
    cd "$current_dir/$branch"
  fi
}

alias mysql57="mysqlv mysql@5.7"
alias mysql80="mysqlv mysql@8.0"

eval "$(starship init zsh)"

# export PATH="/usr/local/opt/mysql@8.0/bin:$PATH"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/priyanklalitkantkapadia/.docker/completions $fpath)
autoload -Uz compinit
compinit

# if inside a tmux session, use tmux-256color
# This is useful for proper color support in terminal applications.
if [[ -n "$TMUX" ]]; then
  export TERM=tmux-256color
else
  export TERM=xterm-256color
fi
