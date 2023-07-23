#!/bin/bash

session="third-phd-paper"

if ! tmux has-session -t $session >/dev/null 2>&1; then
    path="$HOME/phd/writings/publications/vqe-on-ibm-processors-for-quantum-chemistry"
    file="$path/main.tex"
    tmux new-session -d -s $session -c $path -n "nvim"
    tmux new-window -c $path -n "make"
    tmux new-window -c $path -n "todo"

    tmux send-keys -t $session:1 "nvim $file" C-m
    tmux send-keys -t $session:2 "make preview" C-m
    tmux send-keys -t $session:3 "task project:paper-no-3" C-m

    tmux select-window -t 1
fi

tmux attach-session -t $session
