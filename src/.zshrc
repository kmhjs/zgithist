# source <somewhere>/zgithistory.zsh

preexec() {
    # This method will save repository history
    function _save_repo_history()
    {
        [ -n "$(__is_git_repo)" ] && {
            __write_reporsitory_history $1
        }
    }

    # execute
    # ARGV is cmd executed
    _save_repo_history $1

    # clean
    unfunction _save_repo_history
}
