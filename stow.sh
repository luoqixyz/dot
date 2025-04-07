#!/bin/bash

# 特殊目录（需要先 rm -rf ~/.config/xxx 再 stow）
special_dirs=("hypr" "fish" "wallust")

# 没有 .config 但也需要 stow 的目录
always_stow=("fcitx5_themes" "gitconfig")

# 判断传入的第一个参数
if [ "$1" != "stow" ] && [ "$1" != "unstow" ]; then
  echo "请传入 'stow' 或 'unstow' 参数"
  exit 1
fi

# 遍历当前目录下的所有子目录
for dir in */; do
  name="${dir%/}" # 去掉最后的 /

  # 判断是否是需要操作的目录
  if [ -d "${dir}/.config" ] || [[ " ${always_stow[*]} " == *" $name "* ]]; then

    # 如果是特殊目录，先删除 ~/.config/$name
    if [[ " ${special_dirs[*]} " == *" $name "* ]]; then
      echo "⚠️  特殊目录 $name，先删除 ~/.config/$name"
      rm -rf "$HOME/.config/$name"
    fi

    # 根据传入的参数执行 stow 或 unstow
    if [ "$1" == "stow" ]; then
      echo "✅ 正在 stow 管理：$name"
      stow "$name"
    else
      echo "🔄 正在 unstow：$name"
      stow -D "$name"
    fi
  else
    echo "⏭️  跳过：$name（没有 .config 且不在 always_stow 列表）"
  fi
done
