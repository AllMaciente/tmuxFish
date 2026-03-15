function tfs
    if test -n "$TMUX"
        tmux display-popup -E "tmux ls -F '#{session_name}' | fzf | xargs tmux switch-client -t"
    else
        set session (tmux ls -F '#{session_name}' | fzf)
        test -n "$session"; and tmux attach -t $session
    end
end
