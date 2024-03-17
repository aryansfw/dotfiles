#!/bin/bash

rm .bashrc
cp ~/.bashrc .

rm -rf .config

mkdir -p .config/nvim
cp ~/.config/nvim/init.lua .config/nvim
cp ~/.config/nvim/.luarc.json .config/nvim
cp -r ~/.config/nvim/lua .config/nvim

mkdir -p .config/starship
cp -r ~/.config/starship/starship.toml .config/starship

mkdir -p .config/tmux
cp ~/.config/tmux/tmux.conf .config/tmux
