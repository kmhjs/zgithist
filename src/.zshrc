# Source script
#source <somewhere>/zgithistory.zsh

# Prepare for using add-zsh-hook
#builtin autoload -U add-zsh-hook

# Add hook to preexec
add-zsh-hook preexec __zgithistory_preexec
