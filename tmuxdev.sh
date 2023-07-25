#!/bin/bash

session=$1
path=$2

if [ -z $session ]; then
	session="dev"
fi

if [ -z $path ]; then
	path="~/projects"
fi

tmux has-session -t $session 2>/dev/null

if [ $? != 0 ]; then
	cd $path
	tmux new-session -d -s $session

	tmux new-window -t $session:0 -n nvim
	tmux send-keys -t $session:0 "nvim ." C-m

	tmux new-window -t $session:1 -n shell
	tmux select-window -t $session:1
	tmux split-window -h

	tmux new-window -t $session:2 -n tests
	tmux select-window -t $session:0
fi

tmux attach-session -t $session
