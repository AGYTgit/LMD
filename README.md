# LMD dotfiles
Welcome to the LMD Dotfiles! These configs are specifically designed to set up and manage your **Hyprland** environment on **Arch Linux**.


## Requirements

- **pacman/yay:** Used for installing Arch Linux packages (if defined in a module's `module.env`).
- **sudo:** Required for `pacman`.


## Installation

- **Clone the repository:**
    ```bash
    git clone git@github.com:AGYTgit/LMD.git ~/.dotfiles/LMD
    cd ~/.dotfiles/LMD
    ```

- **Make the setup script executable:**
    ```bash
    chmod u+x setup.sh
    ```
	**Note:** Do not run `setup.sh` with `sudo` directly; it's designed to run as your regular user for symlink creation and will not function correctly with `sudo`.


## Usage

The `setup.sh` script takes any number of module paths as arguments.

**⚠️ setup.sh is destructive ⚠️**

- **Basic usage:** This will install all modules contained in the `modules` dir.
  ```bash
  ./setup.sh modules
  ```

- **Advanced usage:** If you only want specific modules, just list their paths.
  ```bash
  ./setup.sh modules/hypr modules/hyprterm/zsh
  ```
