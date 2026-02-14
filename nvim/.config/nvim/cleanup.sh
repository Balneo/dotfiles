# Backup first!
rm -rf ~/.cache/nvim                 # plugin/build caches (safe)
rm -rf ~/.local/share/nvim/undo      # undo history (safe)
rm -rf ~/.local/share/nvim/swap      # swap files (safe)
rm -rf ~/.local/share/nvim/backup    # backup files (safe)
rm -rf ~/.local/share/nvim/site      # old plugin installs (safe)
rm -rf ~/.local/state/nvim           # shada, logs, state (optional)
