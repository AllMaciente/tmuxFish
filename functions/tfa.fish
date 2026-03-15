function tfa
    if test -n "$TMUX"
        if not contains -- "-d" $argv
            return
        end
    end

    # Define nome da sessão
    if test $PWD = $HOME
        set name main
    else
        set name (basename $PWD | tr . _) # tr limpa pontos que o tmux não gosta
    end

    # Se a flag -d for passada, cria em background e encerra
    if contains -- "-d" $argv
        if tmux has-session -t $name 2>/dev/null
            echo "Sessão '$name' já existe."
        else
            tmux new-session -d -s $name
            echo "Sessão '$name' criada em background."
        end
        return
    end

    # --- Lógica original para quando você NÃO está no tmux ---

    # Se não existir nenhuma sessão, cria a primeira
    if not tmux ls >/dev/null 2>&1
        tmux new -s $name
        return
    end

    # Seleciona sessão ou cria nova via fzf
    set session (tmux ls -F "#{session_name}" | \
        fzf --header "Escolha sessão • ENTER conecta • ESC cria nova")

    if test -z "$session"
        tmux new -s $name
    else
        tmux attach -t $session
    end
  end
