#!/bin/sh
source ./scripts.sh

echo "---------------------------------------------------------"
jprint 2 'Greetings. Preparing to power up and begin diagnostics.'
echo "---------------------------------------------------------"

INSTALLDIR=$PWD

echo "---------------------------------------------------------"
jprint 2  'Checking for Homebrew installation.'
echo "---------------------------------------------------------"
brew="/usr/local/bin/brew"

if [ -f "$brew" ]; then
  echo "---------------------------------------------------------"
  jprint 2  'Homebrew is installed.'
  echo "---------------------------------------------------------"
else
  echo "---------------------------------------------------------"
  jprint 3 'Installing Homebrew. Homebrew requires osx command lines tools, please download xcode first'
  echo "---------------------------------------------------------"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

localGit="/usr/local/bin/git"
if ! [[ -f "$localGit" ]]; then
  echo "---------------------------------------------------------"
  jprint 1 'Invalid git installation. Aborting. Please install git.'
  echo "---------------------------------------------------------"
  exit 1
fi

echo "---------------------------------------------------------"
jprint 2  'Installing system packages.'
echo "---------------------------------------------------------"

packages=(
  "git"
  "nvm"
  "tmux"
  "neovim"
  "python3"
  "zsh"
  "ripgrep"
  "fzf"
  "z"
  "bat"
)

for i in "${packages[@]}"; do
  if brew ls --versions $i > /dev/null; then
    # The package is installed
    brew upgrade $i
  else
    # The package is not installed
    brew install $i
  fi
  echo "---------------------------------------------------------"
done

echo "---------------------------------------------------------"
jprint 2  'Setup NVM & Node.'
echo "---------------------------------------------------------"

export NVM_DIR="$HOME/.nvm"
source /usr/local/opt/nvm/nvm.sh
source /usr/local/opt/nvm/nvm.sh
source /usr/local/opt/nvm/etc/bash_completion.d/nvm
source /usr/local/opt/nvm/etc/bash_completion.d/nvm


nvm install node

echo "---------------------------------------------------------"
jprint 2  'Installing Python NeoVim client.'
echo "---------------------------------------------------------"

pip3 install pynvim
pip3 install neovim

echo "---------------------------------------------------------"
jprint 2  'Installing node neovim package'
echo "---------------------------------------------------------"

npm install -g neovim

echo "---------------------------------------------------------"
jprint 2  'Installing spaceship prompt'
echo "---------------------------------------------------------"

npm install -g spaceship-prompt
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


echo "---------------------------------------------------------"
jprint 2  'Installing vim linter (vint)'
echo "---------------------------------------------------------"

pip3 install vim-vint

echo "---------------------------------------------------------"
jprint 2  'Installing bash language server'
echo "---------------------------------------------------------"

npm i -g bash-language-server

echo "---------------------------------------------------------"
jprint 2  'Installing system fonts.'
echo "---------------------------------------------------------"

brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font

# Create backup folder if it doesn't exist
mkdir -p ~/.local/share/nvim/backup

echo "---------------------------------------------------------"
jprint 2  'Installing oh-my-zsh.'
echo "---------------------------------------------------------"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo "---------------------------------------------------------"
  jprint 2  'oh-my-zsh already installed.'
  echo "---------------------------------------------------------"
fi

echo "---------------------------------------------------------"
jprint 2  'Installing zsh-autosuggestions.'
echo "---------------------------------------------------------"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

echo "---------------------------------------------------------"
jprint 2  'Installing vtop.'
echo "---------------------------------------------------------"
npm install -g vtop

echo "---------------------------------------------------------"
jprint 2  'Backup up current files.'
echo "---------------------------------------------------------"

# Backup files that are provided by the Neo into a ~/$INSTALLDIR-backup directory
BACKUP_DIR=$INSTALLDIR/backup
set -e # Exit immediately if a command exits with a non-zero status.

echo "---------------------------------------------------------"
jprint 2  "Creating backup directory at $BACKUP_DIR."
echo "---------------------------------------------------------"
mkdir -p $BACKUP_DIR

files=("$HOME/.config/nvim" "$HOME/.zshrc" "$HOME/.tmux.conf")
for filename in "${files[@]}"; do
    if [ ! -L $filename ]; then
      echo "---------------------------------------------------------"
      jprint 2  'Backing up $filename.'
      echo "---------------------------------------------------------"
      mv $filename $BACKUP_DIR 2>/dev/null
    else
      echo "---------------------------------------------------------"
      jprint 2 "$filename does not exist at this location or is a symlink."
      echo "---------------------------------------------------------"
    fi
done

echo "---------------------------------------------------------"
jprint 2  'Backup completed.'
echo "---------------------------------------------------------"

echo "---------------------------------------------------------"
jprint 2  'Linking symlink files.'
echo "---------------------------------------------------------"

linkables=$( find -H "$INSTALLDIR" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
  target="$HOME/.$( basename $file '.symlink' )"
  if [ -e $target ]; then
    echo "---------------------------------------------------------"
    jprint 3 "~${target#$HOME} already exists... Skipping."
    echo "---------------------------------------------------------"
  else
    echo "---------------------------------------------------------"
    jprint 2  "Creating symlink for $file."
    echo "---------------------------------------------------------"
    ln -s $file $target
  fi
done

if [ ! -d $HOME/.config ]; then
    echo "Creating ~/.config"
    mkdir -p $HOME/.config
fi

echo "---------------------------------------------------------"
jprint 2  'Installing config files.'
echo "---------------------------------------------------------"

for config in $INSTALLDIR/config/*; do
  target=$HOME/.config/$( basename $config )
  if [ -e $target ]; then
    echo "---------------------------------------------------------"
    jprint 3 "~${target#$HOME} already exists... Skipping."
    echo "---------------------------------------------------------"
  else
    echo "---------------------------------------------------------"
    jprint 2  "Creating symlink for ${config}."
    echo "---------------------------------------------------------"
    ln -s $config $target
  fi
done


echo "---------------------------------------------------------"
jprint 2  'Installing Neovim plugins and linking dotfiles.'
echo "---------------------------------------------------------"

nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall

nvim -c 'CocInstall -sync https://github.com/alDuncanson/react-hooks-snippets|q'

echo "---------------------------------------------------------"
jprint 2  'Installing Space vim-airline theme.'
echo "---------------------------------------------------------"

cp ./config/nvim/space.vim ./config/nvim/plugged/vim-airline-themes/autoload/airline/themes/space.vim

echo "---------------------------------------------------------"
jprint 2  'Installing tmux plugin manager.'
echo "---------------------------------------------------------"

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi
echo "----------------------------------------------"
echo "Setup coc plugins"
echo "----------------------------------------------"

# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]; then
  echo '{"dependencies":{}}' >package.json
fi

echo "---------------------------------------------------------"
jprint 2  'Switching shell to zsh. You may need to logout.'
echo "---------------------------------------------------------"

sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

echo "---------------------------------------------------------"
jprint 2  'System update complete. Currently running at 100% power. Enjoy.'
echo "---------------------------------------------------------"

exit 0
