#!/usr/bin/env bash

set -e

PACMAN_LIST="pkglist.txt"
AUR_LIST="aurlist.txt"

# 检查 rofi 是否安装
if ! command -v rofi &>/dev/null; then
  echo "❌ 请先安装 rofi：sudo pacman -S rofi"
  exit 1
fi

# 第一步：选择包来源
CHOICE=$(printf "pacman\nyay" | rofi -dmenu -p "选择包来源")
case "$CHOICE" in
pacman) FILE="$PACMAN_LIST" ;;
yay) FILE="$AUR_LIST" ;;
*) exit 0 ;;
esac

# 检查列表文件
if [[ ! -f "$FILE" ]]; then
  rofi -e "文件 $FILE 不存在，请先备份"
  exit 1
fi

# 第二步：选择包名
SELECTED=$(cat "$FILE" | rofi -dmenu -i -p "搜索 $CHOICE 包名")
[[ -z "$SELECTED" ]] && exit 0

# 第三步：选择操作
ACTION=$(printf "查看信息\n卸载\n复制包名\n退出" | rofi -dmenu -p "对 [$SELECTED] 执行操作")

case "$ACTION" in
"查看信息")
  if [[ "$CHOICE" == "yay" ]]; then
    yay -Qi "$SELECTED" | rofi -e "$(cat -)"
  else
    pacman -Qi "$SELECTED" | rofi -e "$(cat -)"
  fi
  ;;
"卸载")
  echo "即将卸载 $SELECTED..."
  gnome-terminal -- bash -c "sudo pacman -Rns $SELECTED; read -n 1 -s -r -p '按任意键关闭窗口...'"
  ;;
"复制包名")
  echo -n "$SELECTED" | wl-copy && rofi -e "已复制 $SELECTED"
  ;;
*)
  exit 0
  ;;
esac
