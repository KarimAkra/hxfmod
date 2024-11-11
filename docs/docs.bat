@echo off
haxe docs/docs.hxml
haxelib run dox -i docs -o pages --title "hxFMod Documentation" -in "hxfmod" --toplevel-package hxfmod -D source-path "https://github.com/KarimAkra/hxfmod/tree/main/source" -D logo "https://raw.githubusercontent.com/KarimAkra/hxfmod/main/assets/hxfmod_black_198x198_no_background.png"