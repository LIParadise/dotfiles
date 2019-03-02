" .vimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

"set shell=/bin/zsh\ -i
set shcf=-c

" ===========
" Misc basics
" ===========
" For multi-byte character support (CJK support, for example):
"set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,gb18030,latin1
set encoding=utf-8
set nocompatible	                   " Use vim mode, not vi mode.
silent! set cm=blowfish2
" Set language from user's environment.
let g:lang=tolower(split(expand($LANG), '\.')[0])
let &spelllang=g:lang
let &langmenu=g:lang
set spell spellsuggest=best
map <F7> :set spell! \| let &spelllang=g:lang<CR>

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
" Save fold state and cursor
"set viewoptions=folds,cursor
"au BufRead * loadview
"au BufWrite * mkview

" Allow conceal, but not if the cursor is on the line
set conceallevel=2
set concealcursor=

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

set ttyfast                            " Indicates a fast terminal connection.
set nosol                              " No start of line jump when selecting.
set modelines=0                        " Prevent some security issues
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Automatically equalize splits when Vim is resized
autocmd VimResized * wincmd =

" Enable file type detection.
if has("autocmd")
  " Only do this part when compiled with support for autocommands.
  " Use the default filetype settings, s, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  augroup END
else
  set autoindent                       " always set autoindenting on
endif " has("autocmd")

" Status/Command line
set showcmd                            " Show (partial) command in status line.
set showmode
set wildmenu
set wildmode=longest,list,full         " complete longest common string, then list alternatives, then select the sortest first
set laststatus=2                       " Always show status line
set cmdheight=2                        " Prevent "Press Enter" messages
" Show detailed information in status line:
set statusline=%f%m%r%h%w\ [%n:%{&ff}/%Y]%=[0x\%04.4B][%03v][%p%%\ line\ %l\ of\ %L]
let g:airline_powerline_fonts = 1
"let g:airline#extensions#bufferline#enabled " Buffer line. not working?

" Backup and Swap files
set backup
set undofile
if !isdirectory($HOME . ".vim")        " Create vim dirs if missing
	silent !mkdir -p ~/.vim/{backup,view} > /dev/null 2>&1
	silent !mkdir -p ~/.vim/pack/plugins/{start,opt} > /dev/null 2>&1
endif
set backupdir=$HOME/.vim/backup        " for backup files
set directory=$HOME/.vim/backup        " for .swp files
set backupskip=/tmp/*
set history=2000
set undodir=$HOME/.vim/undo            " where to save undo histories
set undolevels=2000                    " how many undos
set undoreload=10000                   " number of lines to save for undo

" Wrapping
set textwidth=80
"set colorcolumn=80                    " Colour column to know when wrapping is needed.
set nowrap
"set wrap linebreak nolist             " Linebreaks at word boundaries.

" Searching
set ignorecase						   " do case insensitive matching
set smartcase						   " overrides ignorecase if uppercase used in search string
set incsearch						   " incremental search
set wrapscan						   " jumps to the beginning if reaching end, and viceversa
" Ctrl+/ to toggle search highlight:
let hlstate=0
nnoremap <C-_> :if (hlstate == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=1-hlstate<cr>

" Markdown
set suffixesadd+='.md'
set suffixesadd+='.wiki'

" Insert mode
set backspace=2                        " Influences the working of <BS>, <Del>, CTRL-W
                                       " and CTRL-U in Insert mode. This is a list of items,
                                       " separated by commas. Each item allows a way to backspace
                                       " over something.
"set backspace=indent,eol,start        " Better handling of <BS>
"set smartindent
set autoindent                         " Copy indent from current line when starting a new line
                                       " (typing <CR> in Insert mode or when using the "o" or "O"
                                       " command).
"set nostartofline                     " Emulate typical editor navigation behaviour

" Tabbing
set tabstop=4                          " Number of spaces that a <Tab> in the file counts for.
set softtabstop=4
set shiftwidth=4                       " Number of spaces to use for each step of (auto)indent.
"set expandtab                         " Use the appropriate number of spaces to insert a <Tab>.
                                       " Spaces are used in indents with the '>' and '<' commands
                                       " and when 'autoindent' is on. To insert a real tab when
                                       " 'expandtab' is on, use CTRL-V <Tab>.

set smarttab                           " When on, a <Tab> in front of a line inserts blanks
                                       " according to 'shiftwidth'. 'tabstop' is used in other
                                       " places. A <BS> will delete a 'shiftwidth' worth of space
                                       " at the start of the line.

set showmatch                          " When a bracket is inserted, briefly jump to the matching
                                       " one. The jump is only done if the match can be seen on the
                                       " screen. The time to show the match can be set with
                                       " 'matchtime'.

" Formatting
set formatoptions=croqnlj
"set formatoptions=croqanlj            " This is a sequence of letters which describes how
                                       " automatic formatting works. See :h fo-table
"set formatoptions=want                " Attempt markdown list behaviour

" =========
" Interface
" =========
" Theme/colours
set background=dark                    " If using a dark background, for syntax highlighting. Opts: light/dark
colors elflord

" Set both for relative and absolute on cursor line:
set number                             " Show line numbers.
set relativenumber                     " Show relative line numbers.
set scrolloff=2                        " Keep cursor # lines from top/bottom.
" Toggle line numbering types:
nnoremap <leader>N :exe 'set nu!' &nu ? 'rnu!' : ''<cr>
if has('mouse')
	set mouse=a                        " Enable the use of the mouse (all modes).
endif
set visualbell                         " Flash instead of beep
"set t_vb=                             " And then disable even the flashing
set cursorline                         " Underline line with cursor
set ruler                              " Show the line and column number of the cursor position,
                                       " separated by a comma.
set splitright                         " vertical splits use right half of screen
set splitbelow                         " horizontal splits use bottom half of screen

" Folding
set foldenable
"set foldmethod=syntax
""Indent w/manual folds:
"augroup vimrc
"  au BufReadPre * setlocal foldmethod=indent
"  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"augroup END
""
"set foldcolumn=3
let g:vimwiki_folding='syntax'
set foldlevel=99
set foldnestmax=10		               " max 10 depth
set foldlevelstart=1	               " start with fold level of 1

" -----------
" GUI options
" -----------
set guioptions=
set guioptions+=a                      " Automatically make visual selection available in system clipboard
set guioptions+=A                      " Same for modeless selection
set guioptions+=e                      " GUI tabs
set guioptions+=g                      " Grayed-out menu items that aren't active
set guioptions+=i                      " Use a Vim icon
set guioptions+=m                      " Show the menu bar
set guicursor+=a:blinkon0              " Don't blink the cursor
set mousehide                          " Hide the mouse while typing
set winaltkeys=no                      " Don't use ALT to access the menu
" Set font for gvim if running.
if has('gui_running')
	set guifont=Noto\ Mono\ 9
endif
set termguicolors

" ========
" Mappings
" ========
" Set <leader> to space, consistent with spacemacs/spacevim.
" Disabled due to insert-mode issues.
"let mapleader = " "
"let maplocalleader = " "
"nnoremap <SPACE> <Nop>

" -----
" Misc.
" -----
" Toggle folds, tab like spacemacs/spacevim.
nnoremap <tab> za
" F1 to be a context sensitive keyword-under-cursor lookup
nnoremap <F1> :help <C-R><C-W><CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" Quick yank/paste
set pastetoggle=<F2>
" Alt+y
vnoremap y "+ygv=gv
vnoremap <Leader>y "+y
vnoremap <Leader>Y "*y
nnoremap <M-p> "+p
nnoremap <Leader>p "+p
nnoremap <Leader>P "*p
nnoremap Y y$

" Retain selection when changing indent level
xnoremap < <gv
xnoremap > >gv

" Table (column) align
vmap <leader>ca :!column -t<cr>
vmap <leader>ta :!column -to<bslash><bar> -s<bslash><bar><cr>

" =======
" Buffers
" =======
set hidden                             " Let you switch buffers without saving current. Don't mark buffers as abandoned if hidden.
set confirm                            " Prompt to save unsaved changes when exiting
" New buffer
nnoremap <leader>n :enew<CR>
" Delete buffer
nnoremap <leader>d :bd<CR>
" Cycle through buffers, tabs:
nnoremap <C-j> :bnext<CR>
nnoremap <C-k> :bprevious<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>
" Switch to previous-viewed buffer
nnoremap <Bslash><Bslash> <C-^>

" Quickfix/errors
nnoremap ]] :cnext<cr>zz
nnoremap [[ :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" Up/down by row instead of line:
nnoremap j gj
nnoremap k gk

" For mappings needing conditionals/dependencies.
source ~/.vim/mappings.vim

" ===================
" Completion/Omnifunc
" ===================
set wildignore=*.o,*.obj,*~            "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*.png,*.jpg,*.gif,*.ico
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=node_modules/*,bower_components/*
set infercase                          " Same-case autocomplete
set autochdir                          " Set working dir to open file
set complete+=kspell

" ======================
" Set up external tools.
" ======================

" Use Silver Searcher for :grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c:%m
" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Use ripgrep for :grep if ag not available
if !executable('ag')
    if executable('rg')
    	set grepprg=rg\ --vimgrep
    	set grepformat^=%f:%l:%c:%m
    endif
endif

" Better formatting for some file types
if executable('python')
    au FileType json set equalprg=python\ -m\ json.tool
endif
if executable('autopep8')
    au FileType python set equalprg=autopep8\ -
endif
if executable('xmllint')
    au FileType html,xhtml,xml set equalprg=xmllint\ --format\ -
endif
"if executable('tidy')
"    " Tidy gives more formatting options than xmllint
"    au FileType html,xhtml,xml setl equalprg=tidy\ --indent-spaces\ 4\ --indent-attributes\ yes\ --sort-attributes\ alpha\ --drop-empty-paras\ no\ --vertical-space\ yes\ --wrap\ 80\ -i\ -xml\ 2>/dev/null
"endif
if executable('pandoc')
    au FileType markdown set equalprg=pandoc\ -t\ markdown\ --reference-links\ --atx-headers\ --wrap=preserve
endif

" Vimwiki
if isdirectory($HOME . "/vimwiki/")
	source ~/.vw.vim
endif

" ----
" Todo
" ----
" https://github.com/junegunn/dotfiles/blob/master/vimrc#L856
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
            \ 'grep -rniI -e TODO -e FIXME -e XXX * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! Todo call s:todo()
