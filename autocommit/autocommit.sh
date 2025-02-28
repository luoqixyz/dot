#!/bin/bash

# 定义仓库路径（默认为当前目录）
# REPO_PATH="/home/luoqi/git/gitea/work_log"
# 仓库路径从参数中获取
current_time=$(date +"%H:%M")
echo $current_time >>/home/luoqi/git/autocommit/commit.log
if [ -z "$1" ]; then
  echo "错误：请提供仓库路径作为参数。" >>/home/luoqi/git/autocommit/commit.log
  echo "用法：$0 <仓库路径>" >>/home/luoqi/git/autocommit/commit.log
  exit 1
fi

REPO_PATH="$1"
echo "当前目录为: $REPO_PATH" >>/home/luoqi/git/autocommit/commit.log
# 进入仓库目录
cd "$REPO_PATH" || {
  echo "无法进入目录: $REPO_PATH" >>/home/luoqi/git/autocommit/commit.log
  exit 1
}

# 检查是否是 Git 仓库
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "当前目录不是 Git 仓库！" >>/home/luoqi/git/autocommit/commit.log
  exit 1
fi

# 添加所有更改到暂存区
git add .

# 检查是否有未提交的变更
if git diff-index --quiet HEAD --; then
  echo "没有变更需要提交。" >>/home/luoqi/git/autocommit/commit.log
  exit 0
fi

# 获取变更文件列表
ADDED_FILES=$(git diff --cached --name-only --diff-filter=A)
MODIFIED_FILES=$(git diff --cached --name-only --diff-filter=M)
DELETED_FILES=$(git diff --cached --name-only --diff-filter=D)

# 生成提交信息
COMMIT_MESSAGE=""

if [ -n "$ADDED_FILES" ]; then
  COMMIT_MESSAGE+="新增了：$(echo "$ADDED_FILES" | tr '\n' ' ')"
fi

if [ -n "$MODIFIED_FILES" ]; then
  if [ -n "$COMMIT_MESSAGE" ]; then
    COMMIT_MESSAGE+=", "
  fi
  COMMIT_MESSAGE+="修改了：$(echo "$MODIFIED_FILES" | tr '\n' ' ')"
fi

if [ -n "$DELETED_FILES" ]; then
  if [ -n "$COMMIT_MESSAGE" ]; then
    COMMIT_MESSAGE+=", "
  fi
  COMMIT_MESSAGE+="删除了：$(echo "$DELETED_FILES" | tr '\n' ' ')"
fi

# 如果没有变更（理论上不会走到这里，因为前面已经检查过）
if [ -z "$COMMIT_MESSAGE" ]; then
  echo "没有变更需要提交。" >>/home/luoqi/git/autocommit/commit.log
  exit 0
fi

# 提交更改
git commit -m "$COMMIT_MESSAGE"

# 推送到远程仓库
git push origin main # 如果分支是 main
# git push origin master  # 如果分支是 master

# 输出完成信息
echo "自动提交完成：$COMMIT_MESSAGE" >>/home/luoqi/git/autocommit/commit.log
