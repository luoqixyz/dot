#!/usr/bin/env bash

# 创建并配置一个 Rust 开发环境容器

set -e

CONTAINER_NAME="rust-dev"
IMAGE="fedora-toolbox:latest"

echo "📦 创建 Toolbx 容器：$CONTAINER_NAME..."
toolbox create --container "$CONTAINER_NAME" --image "$IMAGE"

echo "🚪 进入容器安装环境..."
toolbox run --container "$CONTAINER_NAME" bash -c '
  echo "🔧 安装基础开发工具..."
  sudo dnf install -y gcc make curl git cmake pkg-config libclang xz

  echo "🦀 安装 rustup（官方推荐工具）..."
  curl https://sh.rustup.rs -sSf | sh -s -- -y

  echo "✅ 加载 Rust 环境变量..."
  echo '\''export PATH="$HOME/.cargo/bin:$PATH"'\'' >> ~/.bashrc
  echo '\''set -gx PATH $HOME/.cargo/bin $PATH'\'' >> ~/.config/fish/config.fish || true

  echo "🧰 安装常用 Rust 工具链组件..."
  source $HOME/.cargo/env
  rustup component add clippy rustfmt rust-analyzer

  echo "✅ Rust 环境安装完成！"
'

echo ""
echo "🎉 Rust 开发容器 '$CONTAINER_NAME' 准备就绪！"
echo "👉 输入以下命令开始开发："
echo "   toolbox enter $CONTAINER_NAME"
echo ""
