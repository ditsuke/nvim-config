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

## Wants

- [x] feat: Wakatime in statusbar.
      **See:** https://github.com/wakatime/vim-wakatime/issues/110.
      _Also `:WakatimeToday`_ :moon:
- [x] feat: Keymaps to yank from system clipboard.
      **Ref:** Primeagen's keymaps
- [x] feat: smarter winbar
      **See:** [barbecue.nvim](https://github.com/utilyre/barbecue.nvim).
- [x] feat: inline git blame
- [x] fix: session reload conflicts with lazy.nvim float
- [x] feat: `:UndoTree` alternative in `telescope-undo`
- [x] feat: cleaner winbar, toggle keymap
- [x] chore: Improve Neo-tree aesthetics
- [x] fix: Defuse LuaSnip slots on mode change
      **Reasoning:** Super duper annoying when `<Tab>` triggers slots and you can't see them.
- [x] feat: GPT3 integration
      **See:** https://github.com/jackMort/ChatGPT.nvim
- [x] feat: Highlight LuaSNIP slots with ext marks

### Ideas/configs I'm totally stealing from astronvim
      - [x] `b0o/SchemaStore.nvim`
- [x] `nvim-ufo`
- [x] `nvim-dap` -- But I didn't steal it from astro, since LazyVim comes with it now.
- [x] `neotree` -- certainly looks better + has a buffer and git view.
- [ ] ~~Paste mode~~

## Ideas and Inspiration
- [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim#colorscheme-creation)
- [r/neovim](https://reddit.com/r/neovim)
- Nvchad

_And countless dotfiles_
