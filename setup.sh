#!/usr/bin/env bash

for rc in .*rc ; do
  ln -fs ~/dotfiles/$rc ~/$rc
done
