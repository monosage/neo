#!/usr/env sh
INSTALLDIR=$PWD

echo "JARVIS: Greetings. Preparing to power up and begin diagnostics."

createLinks () {
    if [ ! -d ~/.vim ]; then
        echo "Jarvis: Linking files."
        ln -sfn $INSTALLDIR/jarvis ~/.vim
    else
        echo "Jarvis: Moving ~/.vim to ~/.vim.bkp"
        mv ~/.vim ~/.vim.bkp
        ln -sfn $INSTALLDIR/jarvis ~/.vim
    fi

    if [ ! -f ~/.vimrc ]; then
        ln -sfn $INSTALLDIR/jarvis/vimrc ~/.vimrc
    else
        echo "Jarvis: Moving ~/.vimrc to ~/.vimrc.bkp"
        mv ~/.vimrc ~/.vimrc.bkp
        ln -sfn $INSTALLDIR/jarvis/vimrc ~/.vimrc
    fi
}



which git > /dev/null
if [ "$?" != "0" ]; then
  echo "JARVIS: I require git to be installed to continue."
  exit 1
fi

which vim > /dev/null
if [ "$?" != "0" ]; then
  echo "JARVIS: It would be beneficial if you installed Vim before we continue."
  exit 1
fi

if [ ! -d "$INSTALLDIR/jarvis" ]; then
    echo "JARVIS: I do not detect a previous installation. Creating a new version."
    git clone https://github.com/ctaylo21/jarvis.git
    createLinks
    cd $INSTALLDIR/jarvis

else
    echo "JARVIS: Previous installation detected. Updating to latest version."
    cd $INSTALLDIR/jarvis
    git pull origin master
    createLinks
fi

if [ ! -d "bundle" ]; then
    echo "JARVIS: Creating bundle directory."
    mkdir bundle
fi

if [ ! -d "tmp/backup" ]; then
    echo "JARVIS: Creating backup directories."
    mkdir -p tmp/backup tmp/swap tmp/undo
fi

if [ ! -d "color" ]; then
    echo "JARVIS: Creating color directory."
    mkdir color
fi

if [ ! -d "bundle/vundle" ]; then
    echo "JARVIS: Installing Vundle"
    git clone https://github.com/gmarik/vundle.git bundle/vundle
fi

echo "JARVIS: System update complete. Currently running at 100% power. Enjoy."

vim +BundleInstall +qall
