#!/bin/sh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/KazeTachinuu/dotfiles/master/install.sh)"

set -e

if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    G='\033[1;32m' B='\033[1;34m' Y='\033[1;33m' D='\033[2m' R='\033[0m'
else
    G= B= Y= D= R=
fi
hdr()  { printf "${B}[*]${R} %s\n" "$1"; }
ok()   { printf "${G}[+]${R} %s\n" "$1"; }
skip() { printf "${D}[=] %s${R}\n" "$1"; }
warn() { printf "${Y}[!]${R} %s\n" "$1"; }

# locate the repo: the directory this script lives in, or a fresh clone
DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ ! -e "$DIR/zshrc" ]; then
    DIR="$HOME/.dotfiles"
    if [ -d "$DIR/.git" ]; then
        hdr "updating $DIR"
        git -C "$DIR" pull --progress
    else
        hdr "cloning to $DIR"
        git clone --progress https://github.com/KazeTachinuu/dotfiles "$DIR"
    fi
fi

hdr "dotfiles from $DIR"

# link <src> <dst>: idempotent symlink; a pre-existing real file is kept once as *.backup
TOTAL=7 N=0    # keep TOTAL equal to the number of link lines below
link() {
    src="$DIR/$1" dst="$2" N=$((N + 1))
    [ -e "$src" ] || { warn "[$N/$TOTAL] $1 not in repo, skipped"; return 0; }
    [ "$(readlink "$dst" 2>/dev/null)" = "$src" ] && { skip "[$N/$TOTAL] $dst"; return 0; }
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        mv "$dst" "$dst.backup"
        warn "kept old file as $dst.backup"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -sfn "$src" "$dst"
    ok "[$N/$TOTAL] linked $dst"
}

link zshrc          "$HOME/.zshrc"
link aliases.txt    "$HOME/.config/am/aliases.txt"
link starship.toml  "$HOME/.config/starship.toml"
link nvim           "$HOME/.config/nvim"
link vimrc          "$HOME/.vimrc"
link gdbinit        "$HOME/.gdbinit"
link clang-format   "$HOME/.clang-format"

hdr "done, restart your shell"
