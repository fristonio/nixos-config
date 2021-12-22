#!/usr/bin/env bash

set -e

DEFAULT_WORKSPACE="$HOME/workspace"
GO_WORKSPACE="$HOME/go/src/github.com/fristonio/"

# Check if a sessino named workspace already exist
if ! tmux has-session -t=workspace; then
    # Create a new tmux session named workspace
    tmux new -s workspace -d -c $DEFAULT_WORKSPACE -n workspace

    # Split window vertically and horizontally
    tmux split-window -h -t workspace:1.0
    tmux split-window -v -t workspace:1.1

    tmux new-window -c $GO_WORKSPACE -n go_workspace -t workspace:1
    tmux split-window -h -t workspace:2.0
    tmux split-window -v -t workspace:2.1
fi

tmux a -t=workspace
