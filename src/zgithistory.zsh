# Licence : NYSL (http://www.kmonos.net/nysl/)

function __is_git_repo()
{
    [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ] && {
        echo "1"
    } || {
        echo ""
    }
}

function __zgithistory_preexec()
{
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

function __get_repository_name()
{
    local repo_root repo_name tmp_str

    repo_root="init";
    tmp_str="";
    repo_name="";

    while [ -z "$tmp_str" ]; do
        [[ "${repo_root}" == "init" ]] && {
            repo_root="./";
        } || {
            repo_root="${repo_root}../";
        }

        tmp_str="$(ls ${repo_root}.git 2> /dev/null)"
    ; done

    [ -z "$repo_root" ] && repo_root="."

    repo_root="$(realpath $repo_root)"
    repo_name=${repo_root:t}

    echo $repo_name
}

function __get_repository_b64_name()
{
    local r_name r_b64_name

    r_name=$(__get_repository_name)
    r_b64_name=$(echo $r_name | base64)

    echo $r_b64_name
}

function __get_repository_log_file_path()
{
    local log_file_path

    log_file_path=$ZGITHISTORY_DIR/$(__get_repository_b64_name)

    echo $log_file_path
}

function __write_reporsitory_history()
{
    local arguments arguments_b64 log_file_path
    arguments="$*"

    # Check ignore list
    [[ "$(echo $arguments | cut -d ' ' -f 1)" != "repository_history" ]] && {
        [ ! -d $ZGITHISTORY_DIR ] && mkdir $ZGITHISTORY_DIR

        arguments_b64=$(echo $arguments | base64)

        log_file_path=$(__get_repository_log_file_path)

        [ ! -e $log_file_path ] && {
            touch $log_file_path
        }

        echo "$(date +%s):${arguments_b64}" >> $log_file_path
    }
}

function __show_repository_history()
{
    local log_file_path date_sec date_real cmd_b64 cmd_name

    [ -n "$(__is_git_repo)" ] && {
        log_file_path=$(__get_repository_log_file_path)

        [ -e $log_file_path ] && {
            cat $log_file_path | tail -n 10 | while read s; do
                date_sec=$(echo $s | cut -d':' -f1)
                cmd_b64=$(echo $s | cut -d':' -f2)

                case ${OSTYPE} in
                    darwin*)
                        date_real=$(date -r "$date_sec")
                        cmd_name=$(echo $cmd_b64 | base64 -D)
                        ;;
                    *)
                        date_real=$(date --date "@$date_sec")
                        cmd_name=$(echo $cmd_b64 | base64 -d)
                        ;;
                esac

                echo "[${date_real}] : ${cmd_name}"
            ; done
        }
    }
}

# External interface
function repository_history()
{
    __show_repository_history
}
