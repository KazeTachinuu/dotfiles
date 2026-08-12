#!/bin/sh
# Dotfiles installer. Symlinks everything into place, idempotent.
#
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/KazeTachinuu/dotfiles/master/install.sh)"
#
# Run from a checkout it uses that checkout; run via curl it clones
# to ~/.dotfiles first. Existing real files are kept as *.backup.

set -e

if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    G='\033[1;32m' B='\033[1;34m' R='\033[0m'
else
    G= B= R=
fi
say() { printf "${G}[+]${R} %s\n" "$1"; }

# locate the repo: the directory this script lives in, or a fresh clone
DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ ! -e "$DIR/zshrc" ]; then
    DIR="$HOME/.dotfiles"
    if [ -d "$DIR/.git" ]; then
        say "updating $DIR"
        git -C "$DIR" pull -q
    else
        say "cloning to $DIR"
        git clone -q https://github.com/KazeTachinuu/dotfiles "$DIR"
    fi
fi

printf "${B}==>${R} dotfiles from %s\n" "$DIR"

# link <src> <dst>: symlink, converging in zero work when already correct.
# A pre-existing real file is kept once as *.backup.
link() {
    src="$DIR/$1" dst="$2"
    [ "$(readlink "$dst" 2>/dev/null)" = "$src" ] && return 0
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        mv "$dst" "$dst.backup"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -sfn "$src" "$dst"
    say "linked $dst"
}

link zshrc          "$HOME/.zshrc"
link aliases.txt    "$HOME/.config/am/aliases.txt"
link starship.toml  "$HOME/.config/starship.toml"
link nvim           "$HOME/.config/nvim"

printf "${G}==>${R} done. Restart your shell.\n"
