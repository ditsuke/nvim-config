" Delete last word with ctrl-backspace
exec "set <c-w>=\xce\x7a"

" Automatically indent when starting new lines in code blocks
set autoindent

" Allow backspace to function as usual
set backspace=indent,eol,start

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

" Wrap by default
set wrap

" No wrapping in the middle of a word
set linebreak

" Force wrap on 80 chars -- @todo disable by default?
set textwidth=80

" Enable syntax highlighting
syntax on

" Highlight current line
set cursorline

" Style line highlight
highlight CursorLine	cterm=NONE ctermbg=darkred ctermfg=white

" 4 spaces/tab by default
set tabstop=4
set shiftwidth=4

" Be smart about tabs... maybe just try
set smarttab

" Allow backspace to function as usual
set backspace=indent,eol,start

" Autoswitch hybrid/absolute line numbers
" source: https://jeffkreeftmeijer.com/vim-number/
:set number relativenumber

" :augroup numbertoggle
" :  autocmd!
" :  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
" :  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
" :augroup END

" Switch tabs with H and L
nnoremap H gT
nnoremap L gt

