# 💤 ditsuke's `nvim` config

_A tailored prose-writing and programming environment based on @folke's [LazyVim](https://github.com/lazyvim/lazyvim)_
## Requirements

- Neovim Nightly
- Terminal emulator with support for the [Kitty graphics protocol](https://sw.kovidgoyal.net/kitty/graphics-protocol/).

## Features
- [x] IDE experience, out of the box
- [x] Automatic session management (including reloads!) with flag (`+NoSession`) to disable it.
- [x] Floating, persistent terminal
- [x] Better _marks_ with [Harpoon](https://github.com/ThePrimeagen/harpoon).
- [x] Editor context awareness and more powered by Treesitter. Checked for performance on large (>5000LOC) files!
- [x] LSP-sensitive completion context (import paths)
- [x] A ton of themes

## Wants
- [ ] fix: session reload conflicts with lazy.nvim float
- [ ] feat: LSPSaga for code outline, better references and action previews etc
- [ ] fix: disable colorizer for `lazy` ft
- [ ] fix: disable `indentline` for `noice` ft
- [ ] feat: tune indentline, keymap for indentline toggle
- [ ] feat: cleaner winbar
