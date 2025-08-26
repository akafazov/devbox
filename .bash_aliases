# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -l'
alias k='kubectl'
alias pbcopy='xclip -selection clipboard'

alias k='kubectl'

alias office='xrandr --output eDP-1 --off && i3-msg restart'
alias ip4a='ip -4 a'

# vagrant aliases
alias vs='vagrant status'
alias vssh='vagrant ssh'

# git
alias gits='git status'
alias gittree='git log --graph --oneline --all -n 20'
alias gitka='gitk --all'
alias gll='git log --oneline'
alias glg='git log --graph --oneline'
alias gcb='git checkout -b'
alias gp='git pull'
alias gf='git fetch'
alias gsm='git switch main'
alias gfp='git fetch && git pull'
alias gsmgfp='gsm && gfp'
alias gpf='git push --force'
alias grom='git rebase origin/main'

# helm
alias hdu='helm dependency update'
alias hut='helm unittest'

