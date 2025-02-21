# 验证系统中是否存在env.fish
if test -e "$HOME/.cargo/env.fish"
    source "$HOME/.cargo/env.fish"
end
