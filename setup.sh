#!/bin/zsh

# Colors
declare RED=$'\e[1;31m'    # Error
declare YELLOW=$'\e[1;33m' # Warning
declare GREEN=$'\e[1;32m'  # Success
declare BLUE=$'\e[1;34m'   # Title/section
declare MAGENTA=$'\e[1;35m' # Module name
declare CYAN=$'\e[1;36m'   # Path/Command
declare RESET=$'\e[0m'     # Reset

# Variables
declare MODULE_ENV_FILE_NAME="module.env"
declare GITIGNORE_DIR="$DOTFILES/.gitignore"

# No arguments passed
if [ $# -eq 0 ]; then
    echo
    echo "${RED}Error:${RESET} No modules provided."
    echo "Usage: ${CYAN}$0${RESET} ${MAGENTA}module1 module2 module3 ...${RESET}"
    echo
    exit 1
fi

declare modulesToInstall=("$@")
declare -a completed=()
declare -a failed=()

startSetup() {
    echo
    echo "${BLUE}Starting installation of modules:${RESET} ${MAGENTA}${modulesToInstall[*]}${RESET}"
    echo "==================================================================="
    echo
}

for moduleName in "${modulesToInstall[@]}"; do
    echo "${BLUE}Processing module:${RESET} ${MAGENTA}$moduleName${RESET}"
    echo "-------------------------------------------------------------------"

    (
        moduleDir="$DOTFILES/$MODULES/$moduleName"
        if [[ ! -d "$moduleDir" ]]; then
            echo "${RED}Error:${RESET} Module directory ${CYAN}$moduleDir${RESET} ${RED}not found.${RESET}"
            exit 1
        fi


        moduleEnvFile="$moduleDir/$MODULE_ENV_FILE_NAME"
        if [[ ! -f "$moduleEnvFile" ]]; then
            echo "${RED}Error:${RESET} Environment file ${CYAN}$moduleEnvFile${RESET} ${RED}not found.${RESET}"
            exit 1
        fi


        echo "${BLUE}Loading environment:${RESET} ${CYAN}$moduleEnvFile${RESET}"
        source "$moduleEnvFile"
        echo


        echo "${BLUE}Installing dependencies...${RESET}"
        if [[ -n "$PACMAN_DEPS" ]]; then
            echo "  pacman: ${MAGENTA}${PACMAN_DEPS[*]}${RESET}"
            sudo pacman -S "${PACMAN_DEPS[@]}" --needed
        else
            echo "  ${YELLOW}Warning:${RESET} No pacman dependencies detected -- ${YELLOW}skipping${RESET}"
        fi

        if [[ -n "$YAY_DEPS" ]]; then
            echo "  yay: ${MAGENTA}${YAY_DEPS[*]}${RESET}"
            yay -S "${YAY_DEPS[@]}" --needed
        else
            echo "  ${YELLOW}Warning:${RESET} No yay dependencies detected -- ${YELLOW}skipping${RESET}"
        fi
        echo


        echo "${BLUE}Creating symlinks...${RESET}"
        if [[ -n "$SYM_SOURCE_DF" && -n "$SYM_TARGET_DF" ]]; then
            if [[ -e "$SYM_TARGET_DF" ]]; then
                echo "  ${YELLOW}Warning:${RESET} Target ${CYAN}$SYM_TARGET_DF${RESET} exists -- ${YELLOW}removing.${RESET}"
                rm -r "$SYM_TARGET_DF"
            fi
            echo "  ${GREEN}Symlinking: ${CYAN}$SYM_SOURCE_DF${RESET} -> ${CYAN}$SYM_TARGET_DF${RESET}"
            ln -sr "$SYM_SOURCE_DF" "$SYM_TARGET_DF"
        else
            echo "  ${YELLOW}Warning:${RESET} No source/target for symlink detected -- ${YELLOW}skipping${RESET}"
        fi
        echo


        echo "${BLUE}Executing commands...${RESET}"
        if [[ -n "$EXEC" ]]; then
            echo "  Evaluating ${BLUE}$EXEC${RESET}"
            eval "$EXEC"
        else
            echo "  ${YELLOW}Warning:${RESET} no commands detected -- ${YELLOW}skipping${RESET}"
        fi
        echo


        echo "${BLUE}Setting up .gitignore...${RESET}"
        if [[ -n "$IGNORE_FILE" ]]; then
            echo "  Using ignore file ${CYAN}$IGNORE_FILE${RESET}"
            if [[ -n $(cat "$GITIGNORE_DIR" | grep $(cat "$IGNORE_FILE")) ]]; then
                echo "  Ignore paths already exist in ${CYAN}$GITIGNORE_DIR${RESET}"
            else
                echo "  Adding ignore paths:"
                echo "${CYAN}$(cat $IGNORE_FILE)${RESET}"
                cat $IGNORE_FILE >> $GITIGNORE_DIR
            fi
        else
            echo "  ${YELLOW}Warning:${RESET} no .gitignore file path detected -- ${YELLOW}skipping${RESET}"
        fi
        echo

        echo "${GREEN}Module ${MAGENTA}$moduleName${GREEN} installed successfully!${RESET}"
        exit 0
 
    )

    if [[ $? -eq 0 ]]; then
        completed+=("$moduleName")
    else
        failed+=("$moduleName")
    fi

    echo "-------------------------------------------------------------------"
    echo
done

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
