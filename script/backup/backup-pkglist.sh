#!/usr/bin/env bash

set -euo pipefail

PACMAN_LIST="pkglist.txt"
AUR_LIST="aurlist.txt"
LOG_FILE="backup.log"

# 获取今天的日期
TODAY=$(date '+%Y-%m-%d %H:%M')

# 当前的官方包和 AUR 包
current_pacman=$(comm -23 <(pacman -Qqe | sort) <(pacman -Qqm | sort))
current_aur=$(pacman -Qqm | sort)

# 比较并更新文件，记录新增和删除内容
update_file_with_log() {
  local current_content="$1"
  local file="$2"
  local label="$3" # pacman 或 yay

  local tmp_file
  tmp_file=$(mktemp)
  echo "$current_content" >"$tmp_file"

  if [[ -f "$file" ]]; then
    added=$(comm -13 <(sort "$file") <(sort "$tmp_file"))
    removed=$(comm -23 <(sort "$file") <(sort "$tmp_file"))

    if [[ -n "$added" || -n "$removed" ]]; then
      echo "$current_content" >"$file"
      [[ -n "$added" ]] && echo "$TODAY 添加了 ${label} 包: $added" >>"$LOG_FILE"
      [[ -n "$removed" ]] && echo "$TODAY 删除了 ${label} 包: $removed" >>"$LOG_FILE"
      echo "✅ 更新了 $file"
    else
      echo "✅ $file 无变化"
    fi
  else
    echo "$current_content" >"$file"
    echo "$TODAY 添加了 ${label} 包: $current_content" >>"$LOG_FILE"
    echo "✅ 新建了 $file"
  fi

  rm -f "$tmp_file"
}

update_file_with_log "$current_pacman" "$PACMAN_LIST" "pacman"
update_file_with_log "$current_aur" "$AUR_LIST" "yay"
