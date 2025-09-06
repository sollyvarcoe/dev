sudo apt update
sudo apt install curl jq zsh stow ripgrep fd-find fzf bat -y
sudo chsh -s /bin/zsh $USER

# stow zsh --dir=/$HOME/code/dev/dotfiles --target=$HOME

# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# curl -sS https://starship.rs/install.sh | sh
curl -LsSf https://astral.sh/uv/install.sh | sh