# LMD dotfiles

**⚠️ Warning: setup.sh can and will remove your files ⚠️**

**If a target file or directory specified by the `SYM_TARGET_DF` variable in a module's `module.env` already exists, the script will replace it with the symlink.**

**Please review the `module.env` files of the modules you intend to install to understand the potential changes to your system.**

## Prerequisites

-   **git:** Self explanatory.
-   **zsh:** The script is written in zsh. (Do not ask me why as I don't know myself).
-   **pacman:** Used for installing Arch Linux packages (if defined in a module's `module.env`).
-   **yay:** Used for installing AUR packages (if defined in a module's `module.env`).
-   **sudo:** Required for installing system-level packages using `pacman`.

## Installation

1.  **Clone the repository:**
    ```zsh
    git clone -b lap git@github.com:AGYTgit/LMD.git ~/.dotfiles/LMD
    cd ~/.dotfiles/LMD
    ```

2.  **Make the setup script executable:**
    ```zsh
    chmod +x setup.sh
    ```
    Do not use setup.sh with sudo, it will not work!

## Usage

The `setup.sh` script takes one or more module names as arguments.

**Basic Usage:**

To install specific modules, provide their names as arguments:

```zsh
./setup.sh zsh alacritty starship
```

Or to install all the modules:

```zsh
./setup.sh $(cat MODULELIST)
```
