function tfa
    # Se já estiver dentro do tmux, não faz nada
    test -n "$TMUX"; and return

    # Define nome da sessão
    if test $PWD = $HOME
        set name main
    else
        set name (basename $PWD)
    end

    # Se não existir nenhuma sessão
    if not tmux ls >/dev/null 2>&1
        tmux new -s $name
        return
    end

    # Seleciona sessão ou cria nova
    set session (tmux ls -F "#{session_name}" | \
        fzf --header "Escolha sessão • ENTER conecta • ESC cria nova")

    if test -z "$session"
        tmux new -s $name
    else
        tmux attach -t $session
    end
end

