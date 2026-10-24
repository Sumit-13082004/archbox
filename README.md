# archbox

My Arch Linux agentic-workflow setup. One repo, one command, and a machine ends up
configured the same way every time.

Managed with **chezmoi** (no Nix). The files in this repo *are* the real files:
`chezmoi apply` symlinks/copies them into `~`, and editing here edits your live config.

## The idea

Two things make this reproducible without Nix:

1. **Package lists** - `pkglist.txt` (native pacman) and `aurlist.txt` (AUR) record
   exactly what is installed.
2. **Edit-in-place dotfiles** - `chezmoi` maps this repo onto `~`. Change a file here,
   run `chezmoi apply`, done.

The agentic part is a **single policy file** (`dot_config/opencode/AGENTS.md`) that is
symlinked into place for Claude, Codex, and opencode, so every agent obeys one set of
rules instead of three drifting ones.

## Layout

```
archbox/
├── setup.sh                  # point chezmoi at this repo + apply (one-time)
├── pkglist.txt               # pacman -Qqen  (native packages)
├── aurlist.txt               # pacman -Qqem  (AUR packages)
├── dot_zshrc                 # -> ~/.zshrc
├── dot_gitconfig             # -> ~/.gitconfig
├── dot_config/
│   ├── starship.toml         # prompt
│   ├── wezterm/wezterm.lua   # terminal (Nord)
│   ├── nvim/                 # editor (lazy.nvim)
│   ├── herdr/config.toml     # agent multiplexer keybinds
│   ├── claude/settings.json  # Claude statusline (model + context %)
│   └── opencode/AGENTS.md    # the shared agent policy (the real file)
├── symlink_dot_claude_CLAUDE.md   # -> ~/.config/opencode/AGENTS.md
└── symlink_dot_codex_AGENTS.md    # -> ~/.config/opencode/AGENTS.md
```

## Fresh-machine setup

```sh
git clone <this-repo> ~/archbox
cd ~/archbox

# 1. Install chezmoi (the one tool this depends on)
sudo pacman -S chezmoi

# 2. Install packages
sudo pacman -S --needed - < pkglist.txt
# AUR packages need an AUR helper (yay/paru) or manual builds:
yay -S --needed - < aurlist.txt

# 3. Apply the config
./setup.sh
```

## Daily use

Edit files here, then apply:

```sh
chezmoi apply
```

That's it. `./setup.sh` is only the first time (it writes the `sourceDir` config and
adopts files that already exist in `~`).

## Notes and caveats

- **Git identity** - `dot_gitconfig` contains your name and email. If this repo is
  public, that email becomes public. Remove `dot_gitconfig` (or the `[user]` block)
  if you don't want that; Kun Chen's original deliberately omits git identity.
- **WezTerm background** - `wezterm.lua` points at `/home/sumit/Downloads/bg-console.png`,
  a local file that is not tracked. Point it at your own image or delete that layer.
- **Neovim theme** - ships with rose-pine moon (from the original repo). Your terminal
  is Nord; to match, edit `dot_config/nvim/lua/plugins/colorscheme.lua`.
- **herdr** - not in pacman. Install it from the AUR or build from source
  (https://github.com/herdrdev/herdr) before the `herdr/config.toml` does anything.
  It's optional.
- **opencode** - installed via its own installer to `~/.opencode/bin`, not pacman, so
  it's not in `pkglist.txt`. Same for rustup, nvm, and miniconda.

## Credit

Structure and the nvim/herdr/claude configs are adapted from
[Kun Chen's dotfiles](https://github.com/kunchenguid/dotfiles) (MIT No Attribution),
reworked for Arch + chezmoi instead of macOS + Nix.
