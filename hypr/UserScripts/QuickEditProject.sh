#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Rofi menu for Quick Edit/View of Settings (SUPER E)

# Define preferred text editor and terminal
# edit=${EDITOR:-nano}
edit=neovide

# Paths to configuration directories
rofi_theme="~/.config/rofi/project-edit.rasi"
msg=' ⁉️ Choose which Project to View or Edit ⁉️'

# Function to display the menu options
menu() {
  cat <<EOF
1. neovim config
2. pigMan3.1
EOF
}

# Main function to handle menu selection
main() {
  choice=$(menu | rofi -i -dmenu -config $rofi_theme -mesg "$msg" | cut -d. -f1)

  # Map choices to corresponding files
  case $choice in
  1) file="$HOME/.config/nvim" ;;
  2) file="/home/luoqi/Documents/work/猪场3.0版/03_开发/源码/Web端/pigMan3.1" ;;
  *) return ;; # Do nothing for invalid choices
  esac

  # Open the selected file in the terminal with the text editor
  $edit "$file"
}

# Check if rofi is already running
if pidof rofi >/dev/null; then
  pkill rofi
fi

main
