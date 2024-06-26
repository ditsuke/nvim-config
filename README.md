# 💤 ditsuke's `nvim` config

_A tailored prose-writing and programming environment based on @folke's [LazyVim](https://github.com/lazyvim/lazyvim)_

![Dash](assets/ss-dash.png)

## Requirements

- Neovim Nightly.
- Terminal emulator with support for the [Kitty graphics protocol](https://sw.kovidgoyal.net/kitty/graphics-protocol/).
- `sqlite` and `lib-sqlite`. See [instructions](https://github.com/kkharji/sqlite.lua#-installation).
- A C compiler (e.g. `gcc`), `make` and `cmake` for some native plugins.

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

## Screenshots

![Floating Terminals](assets/ss-terminal.png)

![Terminal search](assets/search-terminals.png)

![File search](assets/fuzzy-search-files.png)

![Structural Symbol Explorer](assets/structural-symbol-explorer.png)

![Better Quickfix list](assets/better-qflist.png)

## How can I try this configuration?

There are 2 ways:

1. Clone this into `~/.config/nvim-ditsuke`, then run:

   ```sh
   NVIM_APPNAME=nvim-ditsuke nvim
   ```

2. Use it as a layer in your `LazyVim` configuration. Note that `1.` is simpler to
   get started and I personally don't dogfood this configuration as a layer.

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

## FAQs

### Fresh install appears broken

It's likely the WakaTime plugin, which misbehaves when the API key is not set. You can either set the API key
(`:WakaTimeApiKey`) or disable the WakaTime extra in `./lua/ditsuke/config/lazy.lua`

If it's another plugin installation that's failing, please ensure you satisfy
all [requirements](#requirements). If you're still stuck, please open an issue.

## Ideas and Inspiration

- [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim#colorscheme-creation)
- [r/neovim](https://reddit.com/r/neovim)
- [Nvchad](https://github.com/NvChad/NvChad)
- [Astronvim](https://astronvim.github.io/)
- [amaanq/nvim-config](https://github.com/amaanq/nvim-config)

_And countless other dotfiles_
