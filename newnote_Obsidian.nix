{ pkgs }:
pkgs.writeShellScriptBin "newnote_Obsidian" ``
  cd ~/Dropbox/ObsidianDropbox/newNotes || exit
  ${pkgs.neovim}/bin/nvim +ObsidianTemplate
``
