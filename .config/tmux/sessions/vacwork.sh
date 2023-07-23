#!/bin/bash

session="vacwork"

if ! tmux has-session -t $session >/dev/null 2>&1; then
    path="$HOME/src/vacwork/app-zustand"
    tmux new-session -d -s $session -c $path -n "nvim"
    tmux new-window -c $path -n "shell"
    tmux new-window -c $path -n "git"
    tmux new-window -c $path -n "todo"

    tmux send-keys -t $session:1 "nvim" C-m
    tmux send-keys -t $session:2 "yarn dev" C-m
    tmux send-keys -t $session:3 "lazygit" C-m
    tmux send-keys -t $session:4 "task project:vacwork" C-m

    tmux select-window -t 1
fi

tmux attach-session -t $session
