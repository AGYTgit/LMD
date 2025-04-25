#!/bin/zsh

# Function to display errors and exit
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

if [[ 1 ]]; then
    declare MODULE_NAME="$1"
    # declare MODULE_DIR="$DOTFILES/$MODULES/$MODULE_NAME"
    declare MODULE_DIR="$HOME/.dotfiles/LMD/modules/$MODULE_NAME"

    # Check if a module name is provided or the module directory exists.
    [[ $# -eq 0 ]] && error_exit "Please provide a module name as an argument. Usage: $0 <module_name>"
    [[ ! -d "$MODULE_DIR" ]] && error_exit "Module '$MODULE_NAME' not found in '$(dirname $MODULE_DIR)'."

    echo "Setting up module --- $MODULE_NAME --- :"

    # Process DEPS file
    if [[ ! -f "$MODULE_DIR/DEPS" ]]; then
        error_exit "'$MODULES_DIR'/DEPS not found"
    else
        echo "Installing dependencies"

        declare PACMAN_DEPS=$(awk '/^pacman/ {$1=""; sub(/^ +/, ""); print $0}' "$MODULE_DIR/DEPS")
        declare YAY_DEPS=$(awk '/^yay/ {$1=""; sub(/^ +/, ""); print $0}' "$MODULE_DIR/DEPS")

        if [[ $PACMAN_DEPS != "" ]]; then
            echo "Installing packages from pacman: $PACMAN_DEPS"
            sudo pacman -S --needed $PACMAN_DEPS
        fi

        if [[ $YAY_DEPS != "" ]]; then
            echo "Installing packages from yay: $YAY_DEPS"
            yay -S  --needed $YAY_DEPS
        fi
    fi

    # Process PATH file
    if [[ ! -f "$MODULE_DIR/PATH" ]]; then
        error_exit "'$MODULE_DIR'/PATH not found"
    else
        echo "Setting up symlinks:"

        declare SOURCE_DIR=$(awk '/^source/ {$1=""; sub(/^ +/, ""); print $0}' "$MODULE_DIR/PATH")
        declare TARGET_DIR=$(awk '/^target/ {$1=""; sub(/^ +/, ""); print $0}' "$MODULE_DIR/PATH")

        eval "SOURCE_DIR=$SOURCE_DIR"
        eval "TARGET_DIR=$TARGET_DIR"

        if [[ -e "$TARGET_DIR" ]]; then
            echo "Found file: $TARGET_DIR --- removing"
            rm -r "$TARGET_DIR"
        fi

        echo "Symlinking $SOURCE_DIR > $TARGET_DIR"
        ln -sr "$SOURCE_DIR" "$TARGET_DIR"
    fi

    echo "Module --- $MODULE_NAME --- done"
fi
