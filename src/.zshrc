# Prepare for using add-zsh-hook
#builtin autoload -U add-zsh-hook

# You need to load script
#FPATH=<SOMEWHERE>/zgithist/src:$FPATH
#autoload -Uz zgithist; zgithist --load

# Add hook to preexec
add-zsh-hook preexec __zgithistory_preexec
