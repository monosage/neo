#!/usr/bin/env bash
source ../scripts.sh

echo "---------------------------------------------------------"
jprint 2 ' Linking symlink files.'
echo "---------------------------------------------------------"

INSTALLDIR=$PWD

linkables=$( find -H "$INSTALLDIR" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
  target="$HOME/.$( basename $file '.symlink' )"
  if [ -e $target ]; then
    echo "---------------------------------------------------------"
    jprint 3 ' ~${target#$HOME} already exists... Skipping.'
    echo "---------------------------------------------------------"
  else
    echo "---------------------------------------------------------"
    jprint 2 ' Creating symlink for $file.'
    echo "---------------------------------------------------------"
    ln -s $file $target
  fi
done

if [ ! -d $HOME/.config ]; then
    echo "Creating ~/.config"
    mkdir -p $HOME/.config
fi

echo "---------------------------------------------------------"
jprint 2 ' Installing config files.'
echo "---------------------------------------------------------"

for config in $INSTALLDIR/config/*; do
  target=$HOME/.config/$( basename $config )
  if [ -e $target ]; then
    echo "---------------------------------------------------------"
    jprint 3 ' ~${target#$HOME} already exists... Skipping.'
    echo "---------------------------------------------------------"
  else
    echo "---------------------------------------------------------"
    jprint 2 ' Creating symlink for ${config}.'
    echo "---------------------------------------------------------"
    ln -s $config $target
  fi
done
