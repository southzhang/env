
alias work="cd ~/Documents/workspace"
alias q="exit"
alias b="cd .."
alias view="vim -R"
alias vi="vim"
cdls(){chdir $1;ls}
alias cd='cdls'
#alias gvim="gvim -geom 160x80"
alias ssh='ssh -o serveraliveinterval=360 -X'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='ls'
alias la='ls -a'
alias ll='ls -l'
alias grep='grep --color=auto'

alias format_json='python -mjson.tool'

alias gcc='gcc-7'

alias ssr="http_proxy=http://127.0.0.1:1087 https_proxy=http://127.0.0.1:1087"

alias gofmtool="~/env/code/gofmt-tool"

