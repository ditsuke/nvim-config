" Delete last word with ctrl-backspace
exec "set <c-w>=\xce\x7a"

" Automatically indent when starting new lines in code blocks
set autoindent

" Allow backspace to function as usual
set backspace=indent,eol,start

" Enable full 24-bit color support
" vim 7.4.1799+
set termguicolors

" Colorscheme: not sure if this works in vim
colorscheme murphy

" helpful if using 'set ruler' and 'colorscheme shine', makes lineNumbers grey
" Same example from http://vim.wikia.com/wiki/Display_line_numbers
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Disable bell sounds 
set noerrorbells visualbell t_vb=

" Line numbers
set number

" shows column, & line number in bottom right 
set ruler

" Cursor movements wrap
set whichwrap=<,>,h,l

" TODO: cmd to enable wrap and textwidth (basically a note mode)
" Wrap by default
" set wrap
"
" Force wrap on 80 chars
"set textwidth=80

" No wrapping in the middle of a word
set linebreak

" Enable syntax highlighting
syntax on

" Highlight current line
set cursorline

" Style line highlight
highlight CursorLine	cterm=NONE ctermbg=darkred ctermfg=white

" Style for matching paranthesis
highlight MatchParen gui=bold guibg=#666666 guifg=#cfafbf cterm=bold ctermbg=NONE
" 4 spaces/tab by default
set tabstop=4
set shiftwidth=4

" Be smart about tabs... maybe just try
set smarttab

" Allow backspace to function as usual
set backspace=indent,eol,start

" Autoswitch hybrid/absolute line numbers
" source: https://jeffkreeftmeijer.com/vim-number/
set number relativenumber

" :augroup numbertoggle
" :  autocmd!
" :  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
" :  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
" :augroup END

" Switch tabs with H and L
" nnoremap H gT
" nnoremap L gt

" Switch tabs with alt-right/left

" Remaps

" Move selected lines up and down OMG
vnoremap J :move '>+1<CR><CR>gv
vnoremap K :move '<-2<CR><CR>gv

" " Center after up/down
" nnoremap <C-d> <C-d>zz
" nnoremap <C-u> <C-u>zz
"
" " Center on search browse`
" nnoremap n nzzzv
" nnoremap N Nzzzv

" Keep cursor in place on line join
nnoremap J mzJ`z

" Center after up/down
nnoremap <C-d> <Cmd>call smoothie#do("\<C-D>zz")<CR>
nnoremap <C-u> <Cmd>call smoothie#do("\<C-U>zz")<CR>
" Center on search browse`
nnoremap n <Cmd>call smoothie#do('nzzzv')<CR>
nnoremap N <Cmd>call smoothie#do('Nzzzv')<CR>

