function tft
    tmux ls -F '#{session_name}' \
    | fzf -m \
        --header="TAB: selecionar múltiplas sessões | ENTER: confirmar seleção" \
        --preview 'tmux list-windows -t {}' \
    | xargs -r -n1 tmux kill-session -t
end
