#/bin/zsh

# Check if .dotfiles directory exists, back it up, and delete it
if [ -d "${HOME}/.dotfiles" ]; 
then
  echo "Backing up and removing existing .dotfiles directory."
  mv "${HOME}/.dotfiles" "${HOME}/.dotfiles_backup_$(date +%Y%m%d%H%M%S)"
else
    echo "No directory found, nothing to backup."
fi

# Check if brew is installed and install it if not else update
if ! command -v brew &> /dev/null
then
    echo "Brew not found, Installing."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    # Make sure we’re using the latest Homebrew.
    echo "Brew already installed, updating."
    brew update
fi

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "git not found, Installing."
    brew install git
else
    echo "git already installed, Updating"
    brew upgrade git
fi

# Check if stow is installed
if ! command -v stow &> /dev/null
then
    echo "stow not found, installing."
    brew install stow
else
    echo "stow already installed, updating"
    brew upgrade stow
fi

# Clone required repo
cd ~
git clone git@github.com:theCyberTech/.dotfiles.git
chmod +x .dotfiles/symlink.sh
./.dotfiles/symlink.sh

