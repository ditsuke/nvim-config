# 💤 ditsuke's `nvim` config

_A tailored prose-writing and programming environment based on @folke's [LazyVim](https://github.com/lazyvim/lazyvim)_

## Requirements

- Neovim Nightly.
- Terminal emulator with support for the [Kitty graphics protocol](https://sw.kovidgoyal.net/kitty/graphics-protocol/).
- `sqlite` and `lib-sqlite`. See [instructions](https://github.com/kkharji/sqlite.lua#-installation).

## Features

- [x] IDE experience, out of the box
- [x] Debug Go, Rust, JS and others out of the box.
- [x] Integrated tests for popular languages/frameworks (powered by Neotest)
- [x] Automatic session management (including reloads!) with flag (`+NoSession`) to disable it.
- [x] Floating, persistent terminal
- [x] Better _marks_ with [Harpoon](https://github.com/ThePrimeagen/harpoon).
- [x] Editor context awareness and more powered by Treesitter. Checked for performance on large (>5000LOC) files!
- [x] LSP-sensitive completion context (import paths)
- [x] A ton of themes

## How can I try this configuration?

There are 2 ways:

1. Clone this into `~/.config/nvim-ditsuke`, then run:
  ```sh
  NVIM_APPNAME=nvim-ditsuke nvim
  ```
2. Use it as a layer in your `LazyVim` configuration. Note that `1.` is simpler to get started:
```lua
{ "ditsuke/nvim-config", import = "ditsuke.plugins"}
-- And any additional layers
-- { import = "ditsuke.extras.code.neotest" },
-- { import = "ditsuke.extras.utils.ai" },
-- { import = "ditsuke.extras.utils.wakatime" },
--
-- -- Language extensions
-- { import = "ditsuke.extras.lang.go" },
-- { import = "ditsuke.extras.lang.java" },
-- { import = "ditsuke.extras.lang.typescript" }, -- vs `lazyvim.plugins.extras.lang.typescript`, this one uses vtsls instead
-- { import = "ditsuke.extras.lang.python" },
-- { import = "ditsuke.extras.lang.rust" },
```

## Stability

I consider this configuration bleeding edge and maintain it for my own use. As such, there are no guarantees on stability
but I'm open to issues and fixes and try to keep the configuration as plug-and-play as possible.


## Ideas and Inspiration
- [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim#colorscheme-creation)
- [r/neovim](https://reddit.com/r/neovim)
- [Nvchad](https://github.com/NvChad/NvChad)
- [Astronvim](https://astronvim.github.io/)
- [amaanq/nvim-config](https://github.com/amaanq/nvim-config)

_And countless other dotfiles_
