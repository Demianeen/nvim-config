#!/bin/zsh
cd "$( dirname "${BASH_SOURCE[0]}" )"
git add --all
git commit -m "Sync nvim config"
git push origin

