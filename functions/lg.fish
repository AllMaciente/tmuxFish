function lg
  tmux display-popup -w 80% -h 70% -T "LazyGit" -d "#{pane_current_path}" -E "lazygit"
end
