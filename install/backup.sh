#!/usr/bin/env bash
INSTALLDIR=$PWD
source ../scripts.sh

echo "---------------------------------------------------------"
jprint 2 ' Backup up current files.'
echo "---------------------------------------------------------"

# Backup files that are provided by the Neo into a ~/$INSTALLDIR-backup directory
BACKUP_DIR=$INSTALLDIR/backup

set -e # Exit immediately if a command exits with a non-zero status.

echo "---------------------------------------------------------"
jprint 2 'Creating backup directory at $BACKUP_DIR.'
echo "---------------------------------------------------------"
mkdir -p $BACKUP_DIR

files=("$HOME/.config/nvim" "$HOME/.zshrc" "$HOME/.tmux.conf")
for filename in "${files[@]}"; do
    if [ ! -L $filename ]; then
      echo "---------------------------------------------------------"
      jprint 2 "Backing up $filename."
      echo "---------------------------------------------------------"
      mv $filename $BACKUP_DIR 2>/dev/null
    else
      echo "---------------------------------------------------------"
      jprint 3 "$filename does not exist at this location or is a symlink."
      echo "---------------------------------------------------------"
    fi
done

echo "---------------------------------------------------------"
jprint 2 ' Backup completed.'
echo "---------------------------------------------------------"
