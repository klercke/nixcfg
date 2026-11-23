# My NixOS/Home-Manager/Nix Flakes Config

This repo stores the Nix code to build all of my systems, including my daily-use desktop (thor), my laptop (freyr), and portable devshells.
Most of the system configuration will not be useful to you since it is very customized for my hardware/needs.
The [flake templates](./flake-templates/), however, may be useful as a starting point for your own devshells, which are one of my favorite Nix features.

<!-- TODO: desktop screenshots -->

## Hosts

| Host | Type | Notes |
| --- | --- | --- |
| `thor` | Desktop | Ryzen 9 5900XT, RX 6800 XT. Hyprland + Noctalia, gaming and sim controllers, LLM worker for [homelab-as-code](https://github.com/klercke/homelab-as-code). |
| `freyr` | Laptop | 15\" IdeaPad L340, i7-9750H, GTX 1650M. Hyprland + Noctalia, Colemak. |

## Stack
- **Base:** [NixOS](https://nixos.org) 26.05 (stable) with `nixpkgs-unstable` exposed as `pkgs.unstable`.
  I use stable where possible, but pull some packages from unstable.
- **Nix implementation:** [Lix](https://lix.systems/)
- **Structure:** [flake-parts](https://flake.parts) + [import-tree](https://github.com/vic/import-tree), [dendritic](https://github.com/mightyiam/dendritic) pattern
- **User environment:** [Home Manager](https://github.com/nix-community/home-manager) as a NixOS module
- **Disks:** [disko](https://github.com/nix-community/disko)
- **Desktop:** [Hyprland](https://hypr.land), [Noctalia](https://github.com/noctalia-dev/noctalia) shell, [noctalia-greeter](https://github.com/noctalia-dev/noctalia-greeter) on [greetd](https://sr.ht/~kennylevinsen/greetd/), [Umbriel](https://github.com/noctalia-dev/umbriel) (evaluating)
- **Theming:** [Stylix](https://github.com/nix-community/stylix), with some manual overrides
- **Terminal:** [Ghostty](https://ghostty.org/), [zsh](https://www.zsh.org/), [Starship](https://starship.rs/)
- **Editor:** [Neovim](https://neovim.io/) via [nixvim](https://github.com/nix-community/nixvim)
- **Nix interface:** [nh (Nix Helper)](https://github.com/nix-community/nh)

## Shell tools

- **Files:** [eza](https://github.com/eza-community/eza) (aliased to `ls`), [fd](https://github.com/sharkdp/fd) (aliased to `find`), [dust](https://github.com/bootandy/dust)
- **Search:** [ripgrep](https://github.com/BurntSushi/ripgrep), [fzf](https://github.com/junegunn/fzf)
- **Navigation:** [zoxide](https://github.com/ajeetdsouza/zoxide) (aliased to `cd`)
- **Viewing:** [bat](https://github.com/sharkdp/bat) (aliased to `cat`), [batman](https://github.com/eth-p/bat-extras) (aliased to `man`), [glow](https://github.com/charmbracelet/glow), [tldr](https://tldr.sh)
- **Git:** [lazygit](https://github.com/jesseduffield/lazygit) (aliased to `lg`), [delta](https://github.com/dandavison/delta) (set as git pager)
- **Misc.:** [btop](https://github.com/aristocratos/btop), [just](https://github.com/casey/just)

## Structure

Every `.nix` file under `modules/` is a flake-parts module picked up automatically by import-tree.
Files and directories starting with `_` are skipped, which is how the hardware and disko configs stay out of the tree.
Modules define `flake.modules.nixos.<name>` or `flake.modules.homeManager.<name>`, and hosts and users opt in by importing them.

```
.
├── flake.nix              inputs, and import-tree over modules/
├── Justfile               deploy and update recipes
├── flake-templates/       project templates and portable dev shells
└── modules/
    ├── desktop/           Hyprland, Noctalia, Stylix, Firefox, Ghostty, Thunderbird
    ├── dev/               git, GPG, direnv, nixvim, OpenCode, LaTeX, devshell helper
    ├── flake/             systems, checks, formatter, devShells, templates
    ├── gaming/            Steam, Lutris, Heroic, Wine, Elite Dangerous, sim controllers
    ├── hardware/          amdgpu, audio, zram, udev rules for radios and keyboards
    ├── hosts/<host>/      one directory per machine
    ├── services/          LLM worker, Transmission
    ├── shell/             zsh, Starship, eza, btop, fastfetch, zoxide
    ├── system/            boot, networking, Nix settings, nh, unstable overlay, workstation profile
    └── users/<user>/      user accounts and their Home Manager imports
```

I use the dendritic pattern to make it easier to keep my configuration DRY and as modular as possible.

## Usage

Rebuild the current host:

```sh
nh os switch
```

Update inputs:

```sh
nix flake update
```

Run the pre-commit checks (nixfmt, deadnix, statix):

```sh
nix flake check
```

```sh
nix fmt
```

## Flake templates and dev shells

`flake-templates/` holds one template per language I work in.
Each one is exposed twice:

- `templates.<lang>` for starting a new project
- `devShells.<lang>` for working in someone else's repo without adding anything to it

Both are built from the template's `nix/devtools.nix`, so the tool list lives in one place.

| Name | Tools |
| --- | --- |
| `rust` | toolchain from `rust-toolchain.toml` (rustup in the portable shell), cargo-nextest, cargo-deny, cargo-watch, cargo-edit, taplo |
| `go` | go, gopls, gotools, delve, golangci-lint |
| `python` | python3, uv, ruff |
| `iac` | OpenTofu, tflint, terraform-ls, Ansible, ansible-lint, yamllint, check-jsonschema, sops, age, just |
| `web` | Hugo, Zola, dart-sass, taplo, just |

### New project

```sh
nix flake init -t github:klercke/nixcfg#rust
```

Templates use flake-parts, git-hooks.nix with prek, and nixos-unstable, the same layout as my other projects.
`rust` also builds the package with crane and adds clippy and nextest checks.

### Someone else's project

```sh
devshell go
```

`devshell` is a zsh function from `modules/dev/devshell.nix`.
It writes `.envrc` with `use flake ~/nixcfg#<lang>`, lists `.envrc` and `.direnv` in `.git/info/exclude`, and runs `direnv allow`.
The portable shells have no git hooks, so nothing gets installed into the other repo.

Without the helper:

```sh
nix develop github:klercke/nixcfg#go
```

## Credits
- Original format based on @Andrey0189's [nixos-config-reborn](https://github.com/Andrey0189)
- Much of my (limited) Nix knowledge comes from @vimjoyer
- Modular/dendritic pattern based on @mightyiam's [dendritic](https://github.com/mightyiam/dendritic) repo

## Resources
- [NixOS Manual](https://nixos.org/manual/nixos/stable)

## Future Plans
- [x] Migrate to dendritic pattern
- [  ] Add CI pipeline (for fun!)
  - [ ] flake check
  - [ ] nixfmt
  - [ ] flake-checker
  - [ ] deadnix
  - [ ] statix
  - [ ] build nixos configurations
  - [ ] build home-manager configurations
  - [ ] readme badges?
  - [ ] automatic flake updates w/ renovate or similar?
  - [ ] list flake tree in readme automatically?
- [ ] Add server configurations
- [ ] Try NVF instead of NixVim
- [ ] Add support for multiple users per host?
- [x] Move any user packages from nixos configuration to home-manager
- [ ] After NixOS 26.11: move Stylix to its NixOS module once its release branch supports noctalia
- [ ] After NixOS 26.11: enable `home-manager.useGlobalPkgs` and move the remaining Home Manager overlays (pyroclear, NUR, unstable) to NixOS
- [x] Shared workstation module for all hosts
- [ ] GPU setup for freyr
