## Regular

- [ ] feat: enable inlay hints? (fix will come from upstream ref https://github.com/LazyVim/LazyVim/issues/2005)
- [ ] feat: migrate to conform/nvim-lint from `none-ls`. (URGENT!)
- [ ] fix: Configuration order is broken when opening a file directly (lazyvim keymaps loaded after ours)
- [ ] feat: Add `stevanmilic/nvim-lspimport` for resolving undefined imports (`pyright` et al)
- [ ] feat: `<S-Tab>` for dedent (map to `<C-D>`)
- [ ] fix: Statusline toggle breaks on colorscheme change.
- [ ] feat: Consider using `dropbar.nvim` as an `nvim-navic` replacement.
- [ ] feat: Consider `improved-search.nvim` for search improvements.
      Ref: https://www.reddit.com/r/neovim/comments/178z686/improvedsearchnvim_little_things_for_search_that/
      Question: how compatible with flash.nvim?
- [ ] feat: Consider `auto-indent.nvim` to get VSCode-like indent level matching on first <TAB>.
      Ref: https://www.reddit.com/r/neovim/comments/17mrka2/dataviewernvim_autoindentnvim_two_plugins_i_wrote/
      Hint: or use the keymap someone shared on the thread >\_<
- [ ] feat: Get a (n)vim tip on startup.
      Ref: https://www.reddit.com/r/neovim/comments/17qdqkt/get_a_handy_tip_when_you_launch_neovim
- [ ] fix: CWD changes on switching to file with a different (git) root.
      **Question:** Is this fixed with latest `lazyvim` updates?
- [ ] fix: Disable `<C-j/k>` bindings in terminal mode?
- [ ] fix: `<C-W>` still maps to `goto_cwd` for telescope_file_browser, somehow.
- [ ] fix(status-column): Git signs are shared by "current buffer" > Impact?  
       1. If you have 2 windows open and switch between them, both
          will show the same git-signs (ie, for the active window/buffer)
      2. UPDATE: now they don't work at now, unless `numhl` is also enabled.
- [ ] fix: disable `indentline` for `noice` ft
- [ ] feat: tune indentline and mini-indentscope, - [ ] define keymap for toggling.
- [ ] feat: `fidget.nvim` to fixed location (statusline?)
- [ ] feat: Codeium as a copilot alternative.
      **Options:** - https://github.com/Exafunction/codeium.vim - https://github.com/jcdickinson/codeium.nvim
- [ ] fix: Neoconf complains about loading order
      **NOTE:** The configuration set responsible is currently disabled.
- [ ] feat: more info on ctrl-g, wittle down on statusbar components
- [ ] feat: LSPSaga for code outline, better references and action previews etc
- [ ] misc: Food for thought
      [r/neovim](https://www.reddit.com/r/neovim/comments/11rzy1k/why_isnt_using_sidebars_to_display_information/)

## High Effort / Might require me to write a plugin

- [ ] Declarative configuration management with _Neoconf_. Neoconf, however, does not support general
      configuration besides LSP at the moment so I'll probably have to make a plugin that extends it.
      Someone did take a shot at it earlier in 2023, but it doesn't cover much ground:
      _Alternatively_, I could contribute back to neoconf if `folke` is receptive of the idea.
      **Note:** I really, really want this for `colorscheme`, `wrap` etc :plead: - https://git.jacky.wtf/neovim/neoconf-neovim-configuration - https://github.com/folke/neoconf.nvim/issues/2
- [ ] Tailored markdown editing - **Reasoning:** Markdown with tailored keymaps makes for a good experience,
      incidentally it also falls in the realm of expectations from using
      virtually any markdown editor. - **Options:** - https://github.com/antonk52/markdowny.nvim/blob/main/lua/markdowny.lua
- [ ] feat: Shada file by CWD. > Why?
      I don't want the jumplist etc for one cwd to be mixed with another. > What to do? - [ ] Create a custom shada file for each cwd. - [ ] Package this into plugin (if one doesn't exist)

## Done

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
- [x] ! Load keymaps, autocmds and opts (broken after namespacing, see `lazyvim.config.init`)
- [x] Improved `null-ls` setup that ships with spell checks and code-actions.
      For spell-checking consider `cspell` among other more involved options like LanguageTool
      **Reference:** https://nullvoxpopuli.com/2023-03-13-null-ls/
- [x] fix!: [regression] shift+enter no longer bypasses cmp
      **NOTE:** It turned out to be the terminal emulator I was using then. It turns
      out that all emulators except Kitty pass S-CR as CR, Kitty passes it as S-CR as it should.
- [x] ui: Move all float border = true to a custom layer (that I might keep disabled)
- [x] fix: disable colorizer for `lazy` ft
- [x] fix: Treesitter errors when no parser is available. > Triggered by `cmp`? > Reproduce by opening: `kitty.conf`
      NOTE: I think this issue fixed itself somewhere along the way.
- [x] feat: Smart colorcolumn
      [smartcolumn.nvim](https://github.com/m4xshen/smartcolumn.nvim).
- [x] feat: consider using Neogit or fugitive or a more nvim-centric
      git workflow.
- [x] feat: `<leader>ff` for git-insensitive search / figure out a way to include hidden files etc
      with a `:tag:` (Telescope).
      UPDATE: <leader>fF is now a git-insensitive search.
- [x] Notifications to the left
      **See:** https://github.com/rcarriga/nvim-notify/issues/124
- [x] feat: `<C-j/k>` bindings for Neo-tree search modes
- [x] chore: Remove enter-to-accept suggestions.
      **Reasoning:** Accidental accepts are really annoying to deal with.
      **UPDATE:** While enter-to-accept still works, we don't preselect
      suggestions anymore, eliminating the problem.
- [x] feat: improved Harpoon mappings for more utility
      **See:** [r/neovim/comments](https://www.reddit.com/r/neovim/comments/11r4ecp/comment/jc6rdjv/?utm_source=share&utm_medium=web2x&context=3)
- [x] Disable, by default, mini-indentscope for large files. Or at least the markers. They're slow..
- [x] feat: status-column
- [x] Improve pair-handling. Currently the pair plugin (`mini-pair`?) does not
      detect existing unmatches pairs on the line and also fails to detect
      and act upon deletion of pair on other lines/same line making it difficult
      to work with pairs after deleting one of the parts. Consider: - Enter \`. Paired \` appears. - Delete second \`. First one remains. - Insert \`. First \` is ignored, 2 \` are inserted again.
      PAIN!
- [x] fix: Copilot statusline indicator
- [x] fix: <C-F> <C-B> <C-W> mappings are broken in `telescope-file-browser`
      **Context:** While the default mappings are reasonable,
