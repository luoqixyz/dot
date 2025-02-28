#!/bin/bash
current_time=$(date +"%H:%M")
echo $current_time
REPO_PATH="$1"

echo $REPO_PATH

echo "当前目录为: $REPO_PATH" >>/home/luoqi/git/autocommit/commit.log
# >>/home/luoqi/git/autocommit/commit.log
