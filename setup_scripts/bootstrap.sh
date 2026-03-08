#!/bin/bash
set -e
# Bootstrap all the essenctial things
# Set up structure for project directories
# Set up structure for dotfiles, git clone + stow

# BE SURE YOU HAVE to set dotfiles path: 

DOTFILES="$HOME/dotfiles/"
# Set package names 
TERMINAL="kitty"
FILE_MANAGER="yazi"
LAUNCHER="walker"
AUR_INSTALLER="yay"

# Install essential stuff
sudo pacman -Syu --noconfirm

# basic installations
sudo pacman -S --needed --noconfirm \
    linux-firmware \
	openssh \
	base-devel \
    brightnessctl \
    tree \
    alsa-utils \
    pipewire \
    wireplumber \
    pipewire-pulse \
    pipewire-alsa \
    pavucontrol \
    unzip 

# bluetooth
sudo pacman -S --needed --noconfirm \
    blueman \
    bluez \
    bluez-utils

if ! systemctl is-enabled pipewire > /dev/null 2>&1; then
    systemctl --user enable pipewire pipewire-pulse wireplumber
    systemctl --user start pipewire pipewire-pulse wireplumber
fi

if ! systemctl is-enabled bluetooth > /dev/null 2>&1; then
    systemctl --user enable bluetooth.service
    systemctl --user start bluetooth.service
fi

# config installations such as neovim and so on.
sudo pacman -S --needed --noconfirm \
	neovim \
	stow \
    npm \
    bat \
    nodejs \
    python \
    python-pip \
    python-pynvim \
    rustup \
    wget \
    jq \
    fzf \
    curl \
    ttf-firacode-nerd \
    htop \
    lazygit \
    python-black \
    yaml-language-server \
    mosquitto \
    tree-sitter-cli \
    zathura \
    zathura-pdf-mupdf \
    texlab \
    texlive \
    glow \
    ripgrep

# npm stuff for neovim
sudo npm install -g neovim
rustup default stable


# For sddm ?? 
sudo pacman -S --needed --noconfirm \
	sddm

if [[ ! -f "$SDDM_CONF" ]]; then
    # Settings for sddm
    USER="$(whoami)"
    WAYLAND_SESSION="hyprland"
    sudo mkdir -p /etc/sddm.conf.d
    SDDM_CONF="/etc/sddm.conf.d/autologin.conf"
    
    # enable sddm service
    if ! systemctl is-enable sddm > /dev/null 2>&1; then
        sudo systemctl enable sddm
        sudo systemctl start sddm
    fi
    # Create config for autologin to hyprland
    echo "Creating autologin setup for $USER and DE $WAYLAND_SESSION"
    sudo touch "$SDDM_CONF"
    sudo bash -c "cat > $SDDM_CONF <<EOL
[Autologin]
User=$USER
Session=$WAYLAND_SESSION
Relogin=True
EOL"
fi


if [[ -d "$DOTFILES" ]]; then
	echo "$DOTFILES DOES EXIST!!"
	cd $DOTFILES
	stow nvim 
    stow scripts
fi 

if [[ $AUR_INSTALLER == 'yay' ]]; then 
	if ! command -v yay &> /dev/null; then 
		echo "yay seems to be missing installing from bin!"
		cd $HOME
		git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
		cd /tmp/yay-bin
		makepkg -si 
		cd $HOME
		rm -rf /tmp/yay-bin
		yay --version
		yay -Syu 
	else
		echo "yay seems to be installed, just updating!"
        yay -Syu
	fi
fi


# 
# If you dont want to skip hyprland 
# 
# EXPORT skip_hyprland=1
#

if [[ $skip_hyprland != 1 ]]; then
	cd $DOTFILES
	stow waybar $TERMINAL hypr
	sudo pacman -S --needed --noconfirm \
		hyprland \
		hyprpaper \
		hyprlock \
        hyprshot \
        wl-clipboard \
		waybar \
		$TERMINAL \
		$FILE_MANAGER
fi


if ! command -v starship &> /dev/null; then
    cd "$DOTFILES"
    stow catpuccin_starship
    cd "$HOME"
    echo "starship not found installing and setting it up"
    # install starship with curl
    curl -sS https://starship.rs/install.sh | sh
    
    SHELL_NAME=$(basename "$SHELL")
    case "$SHELL_NAME" in
        bash)
            SHELL_RC="$HOME/.bashrc"
            ;;
        zsh)
            SHELL_RC="$HOME/.zshrc"
            ;;
        *)
            SHELL_RC=""
            ;;
    esac

    if [[ -n "$SHELL_RC" ]]; then
        echo 'eval "$(starship init '$SHELL_NAME')"' >> "$SHELL_RC"
        echo "Starship initialization added to $SHELL_RC"
    fi
else
    echo "Starship already installed if you want to add to another shell \
        follow the instrcution on the website 'starship.rs'"
fi 

if [[ $LAUNCHER == 'walker'  ]]; then 
    if ! command -v walker &> /dev/null; then
	    $AUR_INSTALLER -S --needed --noconfirm \
	    	walker \
	    	elephant-desktopapplications-bin \
            elephant-archlinuxpkgs-bin \
	    	elephant-calc 

        elephant service enable 
	    systemctl --user enable elephant.service
	    systemctl --user start elephant.service

    fi
fi

