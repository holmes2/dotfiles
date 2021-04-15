"
" Using Vim Plug manager
call plug#begin('~/.local/share/nvim/plugged')

" Trying Corpus
Plug 'wincent/corpus'

" Reveal Commit under Comment
Plug 'rhysd/git-messenger.vim'

"For JSX Files
Plug 'maxmellon/vim-jsx-pretty'

"Using nvim dev icons
Plug 'ryanoasis/vim-devicons'

" If you have nodejs and yarn
" Completion engine for most languages
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" For linting
Plug 'neomake/neomake'

"For repeating from sorround.vim
Plug  'tpope/vim-repeat'

" For indenting
Plug 'thaerkh/vim-indentguides'

" Language Server Protocol (LSP) support for vim and neovim.
Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }

"For MarkdownPreview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" For Git activities inside vim
Plug 'tpope/vim-fugitive'

"For async operations
Plug 'tpope/vim-dispatch'

" For Fuzzy File Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"For Commenting Stuff out
Plug 'tpope/vim-commentary'


" For sorrounding everything
Plug 'tpope/vim-surround'

" For themes
Plug 'chriskempson/base16-vim'

" Vim Plug listing Ends
call plug#end()

"lazily load deoplete"
let g:deoplete#enable_at_startup = 0
let g:deoplete#auto_complete_delay = 5
autocmd InsertEnter * call deoplete#enable()

" Set Echo Doc Settings
set cmdheight=2
let g:echodoc_enable_at_startup = 1

" Always draw the signcolumn.'
set signcolumn=yes

" LanguageClient Settings
let g:LanguageClient_serverCommands = {}

"set filetype
autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
autocmd BufRead,BufNewFile *.tsx set filetype=typescript.tsx

if executable('javascript-typescript-stdio')
  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
	let g:LanguageClient_serverCommands.javascriptreact = ['javascript-typescript-stdio']
  " Use LanguageServer for omnifunc completion
  autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
  autocmd FileType javascriptreact setlocal omnifunc=LanguageClient#complete
else
  echo "javascript-typescript-stdio not installed!\n"
endif

let g:LanguageClient_serverCommands.rust = ['~/.cargo/bin/rustup', 'run', 'stable', 'rls']
let g:LanguageClient_serverCommands.ruby = ['~/.rbenv/shims/solargraph', 'stdio']

let g:LanguageClient_autoStart=1
let g:LanguageClient_autoStop=1
let mapleader=','

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType ruby,rust,javascript,javascriptreact call SetLSPShortcuts()
augroup END

autocmd FileType ruby,javascript,rust setlocal omnifunc=LanguageClient#complete

"Set Encoding to UTF-8
set encoding=UTF-8

"Setting to true
set termguicolors
" set cindent
" Setting tabstops for all filetypes
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd Filetype javascript set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
autocmd Filetype javascriptreact set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab

"Clipboard for Mac
set clipboard=unnamed

" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
call neomake#configure#automake('nrwi', 500)


if executable('yamllint')
  let g:neomake_yaml_yamllint_maker = {
    \ 'args': ['-f', 'parsable'],
    \ 'errorformat': '%E%f:%l:%c: [error] %m,%W%f:%l:%c: [warning] %m' }
  let g:neomake_yaml_enabled_makers = ['yamllint']
endif

" let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'

"set number and set relative number
set nu rnu

" We toggle between relative number as soon as we lose focus of the current
" buffer
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" set search params
"Ignore case while searching
set ignorecase
" While typing start highligting the search
set incsearch
" If there is a capital letter in searching then do not ignore case. Be smart about searching.
set smartcase

" set remapping to tabs for AutoCompletion
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:ulti_expand_or_jump_res = 0
function! ExpandSnippetOrReturn()
let snippet = UltiSnips#ExpandSnippetOrJump()
if g:ulti_expand_or_jump_res > 0
return snippet
else
return "<CR>"
endif
endfunction

 inoremap
\ pumvisible() ? "<C-n>" :
\ check_back_space() ? "<TAB>" :
\ deoplete#mappings#manual_complete()

function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1] =~ '\s'
endfunction
" NerdTree Style
let g:netrw_liststyle     = 3

" Auto command for changing buffer when focus is gained
autocmd! FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

" MarkDown Configuration
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {}
    \ }

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'


"Automatically set text width on a commit message
autocmd Filetype gitcommit setlocal spell textwidth=72

"Function for replacing variables in commit template
function! s:expand_commit_template() abort
  let branch = matchstr(system('git rev-parse --abbrev-ref HEAD'), '\p\+')
  let jira_number = matchstr(branch, '^[^_]+')
  let jira_link = 'https://jira2.cerner.com/browse/' . matchstr(branch, '^[^_]\+')
  let context = {
        \ 'JIRA_LINK': jira_link,
        \ 'AUTHOR': 'Priyank',
        \ }

  let lnum = nextnonblank(1)
  while lnum && lnum < line('$')
    call setline(lnum, substitute(getline(lnum), '\${\(\w\+\)}',
          \ '\=get(context, submatch(1), submatch(0))', 'g'))
    let lnum = nextnonblank(lnum + 1)
  endwhile
endfunction

autocmd BufRead */.git/COMMIT_EDITMSG call s:expand_commit_template()

"enable folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

"For saving folds
" autocmd BufWinLeave *.* mkview

" For Syntax Highlighting the migration file
au BufNewFile,BufRead *.migration set filetype=sql

"For Mouse Support
set mouse=a

set guifont=:h
if has("gui_vimr")
  " Here goes some VimR specific settings like
endif

set hidden
set confirm

"Persistent undo, even if you close and reopen Vim. Super great when combined with the undotree plugin.
set undofile

filetype plugin on
filetype indent on

set cursorline
hi CursorLine cterm=NONE ctermbg=darkblue ctermfg=white guibg=darkblue ctermfg=white

if has('nvim')
  lua <<
    CorpusDirectories = {
      ['~/Documents/Corpus'] = {
        autocommit = true,
        autoreference = 1,
        autotitle = 1,
        base = './',
        transform = 'local',
      }
  }
.
endif

" Open new split panes to right and bottom, which feels more natural than Vim’s default:
" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally#more-natural-split-opening
set splitbelow
set splitright

"While jumping do not go to netrw
let g:netrw_altfile = 1
inoremap { {}<left>
inoremap {{ {
inoremap {} {}
inoremap [ []<left>
inoremap [[ [
inoremap [] []
inoremap ( ()<left>
inoremap (( (
inoremap () ()
inoremap " ""<left>
inoremap "" ""
inoremap ' ''<left>
inoremap '' ''

"Reload a file on saving
autocmd BufWritePost $MYVIMRC source $MYVIMRC

autocmd ColorScheme * highlight StatusLine ctermbg=darkgray cterm=NONE guibg=darkgray gui=NONE

