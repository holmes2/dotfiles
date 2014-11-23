" Copyright Professor Andy Meneely. A part of it is taken from his work. 
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set number
execute pathogen#infect('bundle/{}')
syntax on
filetype plugin indent on
filetype on
set backspace=indent,eol,start
set ruler " show the cursor position all the time
set nocompatible " use vim defaults, not vi defaults
set shiftwidth=4	" number of spaces to (auto)indent
set cindent	" automatically indent inner blocks of code in C
set ignorecase " Ignore case when searching
set autoindent	" Start new lines on the same indent as previous
set smartindent	" Automatically insert a new level for C-like files
set showmatch	" Show matching braces when text indicator is over them
set noerrorbells	" No sound on errors
set novisualbell	" No sound via the visual bell
set history=500	" Remember tons of commands (default is 20)
set showmode	" Show the mode you are currently in
set mouse=a	" Detect mouse input
set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files
set wrap	" View long lines as wrapped
syntax on " syntax highlighing
filetype on " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
filetype plugin on " Enable filetype-specific plugins
colorscheme desert
set clipboard=unnamed
"Setting for filetye python
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4

"============================================================================
" Use arrow keys to navigate after a :vimgrep or :helpgrep
"============================================================================
nmap <silent> <RIGHT>         :cnext<CR>
nmap <silent> <RIGHT><RIGHT>  :cnfile<CR><C-G>
nmap <silent> <LEFT>          :cprev<CR>
nmap <silent> <LEFT><LEFT>    :cpfile<CR><C-G>
