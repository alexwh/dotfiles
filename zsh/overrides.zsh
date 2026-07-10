prompt_pure_preexec() {
    if [[ -n $prompt_pure_git_fetch_pattern ]]; then
        # Detect when Git is performing pull/fetch, including Git aliases.
        local -H MATCH MBEGIN MEND match mbegin mend
        if [[ $2 =~ (git|hub)\ (.*\ )?($prompt_pure_git_fetch_pattern)(\ .*)?$ ]]; then
            # We must flush the async jobs to cancel our git fetch in order
            # to avoid conflicts with the user issued pull / fetch.
            async_flush_jobs 'prompt_pure'
        fi
    fi

    typeset -g prompt_pure_cmd_timestamp=$EPOCHSECONDS

    # Shows the current directory and executed command in the title while a process is active.
    # prompt_pure_set_title 'ignore-escape' "$PWD:t: $2"

    # only show executed command arguments in title (command is in tmux tab title)

    # man zshall -> special functions -> hook functions -> preexec:
    # "the string that the user typed is passed as the first argument[...] the
    # second argument is a single-line, size-limited version of the command
    # (with things like function bodies elided); the third argument contains
    # the full text that is being executed."
    # we're doing our own size limiting, so use $1 instead (ignores alias bloat
    # from $3)
    local current_cmd_args="${1#* }"
    # naievly shorten paths (e.g. some/path/file.txt -> s/p/file.txt)
    local short_args=$(sed -E 's|([^/[:space:]])[^/[:space:]]*/|\1/|g' <<< "$current_cmd_args")
    local max_len=58
    if (( ${#short_args} > max_len )); then
        local half=$(( (max_len - 3) / 2 ))
        local left="${short_args[1, half]}"
        local right="${short_args[-half, -1]}"
        short_args="${left}...${right}"
    fi


    prompt_pure_set_title 'ignore-escape' "$short_args"

    # Disallow Python virtualenv from updating the prompt. Set it to 20 if
    # untouched by the user to indicate that Pure modified it. Here we use
    # the magic number 20, same as in `psvar`.
    export VIRTUAL_ENV_DISABLE_PROMPT=${VIRTUAL_ENV_DISABLE_PROMPT:-20}
}
