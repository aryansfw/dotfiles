# Dotfiles

These are my personal dotfiles that I use in Windows Subsystem for Linux 2 (WSL2). Feel free to use this repository for inspiration (or not). :)

## Configuration files

My dotfiles consists of configuration files for:
- [neovim](https://github.com/neovim/neovim): a text editor
- [tmux](https://github.com/tmux/tmux): a terminal multiplexer
- [starship](https://github.com/starship/starship): a prompt styler
- .bashrc: bash script that runs on start
  - [fzf](https://github.com/junegunn/fzf): general-purpose command-line fuzzy finder.
  - [zoxide](https://github.com/ajeetdsouza/zoxide): smarter cd command

## Workflow

Besides configuration files, in `.bashrc` there are scripts for opening workspaces and folders, primarily using fzf.
These are configured as aliases and functions which help define my current workflow. My ideal workflow goes like this.

1. Open a bash shell terminal
2. Find a workspace using `w` alias to fuzzy-find a zoxide query or normal query
3. Open workspace in a new tmux session by pressing `Enter`
4. Open project up using the alias `v` which is just `nvim .`
5. Work in neovim using plugins: oil.nvim, harpoon, telescope, and neogit

If I ever want to go to another folder I can use zoxide normally or the `g` alias to fuzzy-find a folder
