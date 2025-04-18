#!/bin/bash

set -e

APP_DIR="$HOME/Applications"
APP_NAME="Obsidian"
ARCH="AppImage"
TMP_FILE="/tmp/latest_obsidian.AppImage"

mkdir -p "$APP_DIR"
cd "$APP_DIR"

# 获取本地版本
local_version=$(ls ${APP_NAME}-*.${ARCH} 2>/dev/null | grep -Po "${APP_NAME}-\K[0-9.]+" | sort -V | tail -1)

# 获取 GitHub 上的最新版本号，并去除末尾的点
latest_version=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep -Po '"tag_name": "v\K[0-9.]+(?=")' | head -1)
latest_file="${APP_NAME}-${latest_version}.${ARCH}"
latest_url="https://github.com/obsidianmd/obsidian-releases/releases/download/v${latest_version}/${latest_file}"

echo "本地版本 : ${local_version:-无}"
echo "最新版本 : $latest_version"

if [ "$latest_version" != "$local_version" ]; then
  echo "🆕 检测到新版本，正在下载 $latest_file ..."
  wget -O "$TMP_FILE" "$latest_url"

  # 备份旧版本
  if [ -f "${APP_NAME}-${local_version}.${ARCH}" ]; then
    mv "${APP_NAME}-${local_version}.${ARCH}" "${APP_NAME}-${local_version}.${ARCH}.bak"
  fi

  # 替换新版本
  mv "$TMP_FILE" "${APP_NAME}-${latest_version}.${ARCH}"
  chmod +x "${APP_NAME}-${latest_version}.${ARCH}"

  echo "✅ 已更新为版本 $latest_version"
else
  echo "✅ 已是最新版，无需更新"
fi
