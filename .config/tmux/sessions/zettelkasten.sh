#!/bin/bash

session="zettelkasten"

if ! tmux has-session -t $session >/dev/null 2>&1; then
    path="$HOME/wiki/"
    tmux new-session -d -s $session -c $path -n "build"
    tmux new-window -c $path -n "writing"

    tmux send-keys -t $session:1 "pipenv shell \"make\"" C-m
    tmux send-keys -t $session:2 "cd docs;nvim index.md" C-m

    tmux select-window -t 2
fi

tmux attach-session -t $session
