#!/usr/bin/env bash

set -euo pipefail

PACMAN_LIST="pkglist.txt"
AUR_LIST="aurlist.txt"

if ! command -v fzf &>/dev/null; then
  echo "❌ 你需要安装 fzf：sudo pacman -S fzf"
  exit 1
fi

CHOICE=$(printf "pacman\nyay" | fzf --prompt="选择要查看的包来源: ")

case "$CHOICE" in
pacman)
  FILE="$PACMAN_LIST"
  ;;
yay)
  FILE="$AUR_LIST"
  ;;
*)
  echo "未选择任何内容，退出。"
  exit 0
  ;;
esac

if [[ ! -f "$FILE" ]]; then
  echo "文件 $FILE 不存在。请先运行备份脚本。"
  exit 1
fi

cat "$FILE" | fzf --prompt="搜索 $CHOICE 包名: "
