

# bash::: export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
# zsh:::: PS1="%{$fg[blue]%}%n%{$fg[white]%}@%{$fg[green]%}%m:%{$fg[yellow]%}%20<...<%~%<< %{$reset_color%}$ "

autoload colors
colors
export PS1="%{$fg[blue]%}%n%{$fg[white]%}@%{$fg[green]%}%m:%{$fg[yellow]%}%20<...<%~%<< %{$reset_color%}$ "
export CLICOLOR=1
export LS_COLORS=ExFxBxDxCxegedabagacad

alias ls='ls -GFh -li'






