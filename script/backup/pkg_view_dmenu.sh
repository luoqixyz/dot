#!/usr/bin/env bash

PACMAN_LIST="pkglist.txt"
AUR_LIST="aurlist.txt"

if ! command -v dmenu &>/dev/null; then
  echo "❌ 你需要安装 dmenu：sudo pacman -S dmenu"
  exit 1
fi

CHOICE=$(printf "pacman\nyay" | dmenu -p "选择要查看的包来源:")

case "$CHOICE" in
pacman)
  FILE="$PACMAN_LIST"
  ;;
yay)
  FILE="$AUR_LIST"
  ;;
*)
  notify-send "取消操作"
  exit 0
  ;;
esac

if [[ ! -f "$FILE" ]]; then
  notify-send "$FILE 不存在，请先备份"
  exit 1
fi

SELECTED=$(cat "$FILE" | dmenu -l 20 -p "选择 $CHOICE 包名:")
[ -n "$SELECTED" ] && echo "你选择了: $SELECTED" | tee /dev/stderr
