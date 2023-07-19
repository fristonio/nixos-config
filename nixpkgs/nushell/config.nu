let-env config = {
  show_banner: false,
  keybindings: [],
  hooks: {
    pre_execution: [],
    pre_prompt: [],
    env_change: {}
  }
}

let-env EDITOR = nvim
let-env GOPATH = $"($env.HOME)/go"
let-env GO111MODULE = on

let-env PATH = (
  $env.PATH | split row (char esep) |
  append $"($env.HOME)/bin" |
  append $"($env.HOME)/.local/bin" |
  append $"($env.GOPATH)/bin" |
  append $"($env.HOME)/.local/share/nvim/mason/bin"
)

source ~/.config/nushell/atuin.nu
source ~/.config/nushell/zoxide.nu

let-env DOCKER_HOST = "unix:///run/docker.sock"
let-env MOZ_USE_XINPUT2 = 1

use "~/.config/nushell/onedark.nu"
let-env config = ($env.config | merge {color_config: (onedark)})

alias cls = clear
alias off = poweroff
alias restart = reboot
alias got = xdg-open

alias gl = git log --oneline --graph --abbrev-commit --decorate
alias gs = git status
alias gcb = git checkout -b
alias k = kubectl

alias nix-gc-all = sudo nix-garbage-collect -d
alias nix-gc = sudo nix-store --gc

alias open-workspace = bash ~/.tmux-workspace.sh
alias edit-home = nvim $"($env.HOME)/workspace/nixos-config/nixpkgs/home.nix"
alias edit-nixpkgs = nvim $"($env.HOME)/workspace/nixos-config/nixpkgs/"
