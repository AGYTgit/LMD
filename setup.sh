#!/bin/bash

declare RED=$'\e[1;31m'
declare YELLOW=$'\e[1;33m'
declare GREEN=$'\e[1;32m'
declare BLUE=$'\e[1;34m'
declare MAGENTA=$'\e[1;35m'
declare CYAN=$'\e[1;36m'
declare RESET=$'\e[0m'

declare DOTFILES_PATH="$(dirname "$(readlink -f "$0")")"
declare ENV_FILE_NAME="module.env"

# save DOTFILES_PATH to path.env
echo "export DOTFILES=\"$DOTFILES_PATH\"" >$DOTFILES_PATH/variables/path.env

handleWrongArgs() {
    echo
    echo "${RED}Error:${RESET} No module (argument) provided!"
    echo "Usage: ${CYAN}$0${RESET} ${MAGENTA}module${RESET}"
    echo

    exit 1
}

checkModuleIntegrity() {
    if [[ ! -d "$DOTFILES_PATH/$1" ]]; then # check module dir
        return 1
    elif [[ ! -f "$DOTFILES_PATH/$1/$ENV_FILE_NAME" ]]; then # check module.env file
        return 2
    fi

    return 0
}

displaySummary() {
    echo
    echo "==================================================================="

    if [[ ${#failed[@]} -gt 0 ]]; then
        echo "${RED}Failed modules: ${MAGENTA}${failed[*]}${RESET}"
    else
        echo "${GREEN}No failed modules.${RESET}"
    fi

    if [[ ${#completed[@]} -gt 0 ]]; then
        echo "${GREEN}Successfully installed modules: ${MAGENTA}${completed[*]}${RESET}"
    else
        echo "${RED}No modules were installed.${RESET}"
    fi

    echo "==================================================================="
    echo
}

loadModule() {
    # installPacmanDependencies
    echo "${BLUE}Installing pacman dependencies...${RESET}"
    if [[ -n "$PACMAN_DEPS" ]]; then
        echo "  pacman: ${MAGENTA}${PACMAN_DEPS[*]}${RESET}"
        sudo pacman -S "${PACMAN_DEPS[@]}" --needed
    else
        echo "  ${YELLOW}Warning:${RESET} No dependencies detected -- ${YELLOW}skipping${RESET}"
    fi
    echo

    # installYayDependencies
    echo "${BLUE}Installing yay dependencies...${RESET}"
    if [[ -n "$YAY_DEPS" ]]; then
        echo "  yay: ${MAGENTA}${YAY_DEPS[*]}${RESET}"
        yay -S "${YAY_DEPS[@]}" --needed
    else
        echo "  ${YELLOW}Warning:${RESET} No dependencies detected -- ${YELLOW}skipping${RESET}"
    fi
    echo

    # createSymlinks
    echo "${BLUE}Creating symlinks...${RESET}"
    if [[ -n "$SYM_SOURCE" && -n "$SYM_TARGET" ]]; then
        local ABS_SYM_SOURCE="$DOTFILES_PATH/$module/$SYM_SOURCE"

        if [[ -e "$SYM_TARGET" ]]; then
            echo "  ${YELLOW}Warning:${RESET} Target ${CYAN}$SYM_TARGET${RESET} exists -- ${YELLOW}removing.${RESET}"
            rm -r "$SYM_TARGET"
        fi
        echo "  ${GREEN}Symlinking: ${CYAN}$ABS_SYM_SOURCE${RESET} -> ${CYAN}$SYM_TARGET${RESET}"
        ln -srf "$ABS_SYM_SOURCE" "$SYM_TARGET"
    else
        echo "  ${YELLOW}Warning:${RESET} No source/target for symlink detected -- ${YELLOW}skipping${RESET}"
    fi
    echo

    # executeCommands
    echo "${BLUE}Executing commands...${RESET}"
    if [[ -n "$EXEC" ]]; then
        echo "  Evaluating ${BLUE}$EXEC${RESET}"
        eval "$EXEC"
        sleep 0.1
    else
        echo "  ${YELLOW}Warning:${RESET} no commands detected -- ${YELLOW}skipping${RESET}"
    fi
    echo

    # setupGitignore
    echo "${BLUE}Setting up .gitignore...${RESET}"
    if [[ -n "$IGNORE_FILE" ]]; then
        echo "  Using ignore file ${CYAN}$IGNORE_FILE${RESET}"
        if [[ -n $(cat "$gitIgnoreDir" | grep "$(cat "$IGNORE_FILE")") ]]; then
            echo "  Ignore paths already exist in ${CYAN}$gitIgnoreDir${RESET}"
        else
            echo "  Adding ignore paths:"
            echo "${CYAN}$(cat "$IGNORE_FILE")${RESET}"
            cat "$IGNORE_FILE" >>"$gitIgnoreDir"
        fi
    else
        echo "  ${YELLOW}Warning:${RESET} no .gitignore file path detected -- ${YELLOW}skipping${RESET}"
    fi
    echo
}

processModule() {
    local declare module="$1"
    local declare level="$2"

    # validate integrity
    checkModuleIntegrity "$module"
    local declare integrity=$?
    if [[ integrity -eq 1 ]]; then
        echo "Error: couldn't find module: $module"
        return 1
    elif [[ integrity -eq 2 ]]; then
        echo "Error: couldn't find module.env in: $DOTFILES/$module"
        return 1
    fi

    # load env
    echo "${BLUE}Loading environment:${RESET} ${CYAN}$DOTFILES_PATH/$module/$ENV_FILE_NAME${RESET}"
    source "$DOTFILES_PATH/$module/$ENV_FILE_NAME"

    # validate module's LEVEL
    if [[ ! $level -eq -1 ]]; then # skip validation for modules with LEVEL=-1
        if [[ $LEVEL -ge $level ]]; then
            echo "Error: LEVEL of a submodule has to be lover then the module's LEVEL"
            return 1
        fi
    fi

    # load module
    loadModule "$module"

    # process submodules
    if [[ ! "$LEVEL" -eq 1 ]]; then
        for subModule in "${MODULES[@]}"; do
            processModule "$module/$subModule" "$LEVEL"
        done
    fi

    echo "Installed module: ${MAGENTA}$module${RESET}"
}

main() {
    if [[ $# -le 0 ]]; then
        handleWrongArgs
    fi

    # declare -a allCompleted=() # unused
    # declare -a allFailed=()    # unused

    # print starting setup

    if [[ $# -eq 1 ]]; then
        processModule "$1" "-1"
    elif [[ $# -gt 1 ]]; then
        for module in "$@"; do
            processModule "$module" "-1"
        done
    fi

    # displaySummary # unused
}

main "$@"
