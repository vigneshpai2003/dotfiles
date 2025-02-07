#!/usr/bin/env bash

set -e  # Exit on any error

help() {
    echo "Usage: $0 [OPTION]"
    echo "Manage NixOS system and user environment."
    echo
    echo "Options:"
    echo "  update          Update the flake inputs"
    echo "  restore         Revert to previous flake inputs"
    echo "  upgrade         Rebuild and switch system"
    echo "  clean           Remove old generations and collect garbage"
    echo "  optimize        Optimize nix store"
    echo "  fetch           Display system information"
    echo "  help            Show this help message"
    exit 0
}

update() {
    sudo nix flake update --flake @DOTDIR@
}

restore() {
    cd @DOTDIR@
    git restore flake.lock
    cd - > /dev/null
}

upgrade() {
    sudo nixos-rebuild switch --flake @DOTDIR@ --show-trace
}

clean() {
    sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old
    sudo nix-collect-garbage
    nix-collect-garbage
}

optimize() {
    nix-store --optimise
}

fetch() {
    fastfetch
}

case "$1" in
    update) update ;;
    restore) restore ;;
    upgrade) upgrade ;;
    clean) clean ;;
    optimize) optimize ;;
    fetch) fetch ;;
    help|*) help ;;
esac
