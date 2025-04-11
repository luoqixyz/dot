#!/usr/bin/env bash

PACMAN_LIST="pkglist.txt"
AUR_LIST="aurlist.txt"

if ! command -v rofi &>/dev/null; then
  echo "❌ 请先安装 rofi：sudo pacman -S rofi"
  exit 1
fi

# 选择来源
CHOICE=$(printf "pacman\nyay" | rofi -dmenu -p "选择包来源")

case "$CHOICE" in
pacman)
  FILE="$PACMAN_LIST"
  ;;
yay)
  FILE="$AUR_LIST"
  ;;
*)
  exit 0
  ;;
esac

if [[ ! -f "$FILE" ]]; then
  rofi -e "文件 $FILE 不存在，请先备份！"
  exit 1
fi

# 用 rofi 显示包列表并选择
SELECTED=$(cat "$FILE" | rofi -dmenu -i -p "$CHOICE 包名搜索")

if [[ -n "$SELECTED" ]]; then
  echo "你选择了: $SELECTED"
  # 你可以在这里添加更多操作，比如查看信息、复制等：
  # pacman -Qi "$SELECTED" | less
  # echo -n "$SELECTED" | wl-copy
fi
