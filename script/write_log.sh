#!/bin/bash

export DISPLAY=:0
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"

message="今天的工作就到这里啦，去把今天的工作日志完成吧！！！"

notify-send "下班提醒" "$message"

echo "$(date): 脚本已执行" >>/home/luoqi/git/script/log.txt
