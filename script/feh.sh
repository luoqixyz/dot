#!/bin/bash

# 检查是否提供文件
if [ -z "$1" ]; then
  echo "Usage: $0 image_file"
  exit 1
fi

IMAGE="$1"

# 检查文件是否存在
if [ ! -f "$IMAGE" ]; then
  echo "Error: File not found!"
  exit 1
fi

# 获取图片宽度和高度
read WIDTH HEIGHT < <(identify -format "%w %h" "$IMAGE")

# 计算缩放比例
if ((WIDTH > 4000 || HEIGHT > 4000)); then
  SCALE=10 # 超大图片，缩小到 25%
elif ((WIDTH > 3000 || HEIGHT > 3000)); then
  SCALE=25 # 超大图片，缩小到 25%
elif ((WIDTH > 2000 || HEIGHT > 2000)); then
  SCALE=50 # 大图片，缩小到 50%
elif ((WIDTH > 1000 || HEIGHT > 1000)); then
  SCALE=75 # 中等图片，缩小到 75%
else
  SCALE=100 # 小图片，原尺寸
fi

echo "Opening $IMAGE with scale $SCALE%"

# 使用 feh 打开图片
feh --scale-down --zoom "$SCALE" "$IMAGE"
