" Misc mappings
" =============
"let mapleader = '\<space>'
"let maplocalleader = '\<space>'
"nnoremap <SPACE> <Nop>

" Up/down by row instead of line:
nnoremap j gj
nnoremap k gk
" Retain selection when changing indent level
xnoremap < <gv
xnoremap > >gv
" Toggle folds. Was tab, but remapping <tab> remaps <c-i> too.
nnoremap <BS> za
vnoremap <BS> zf
" Don't use Ex mode, use Q for formatting
nnoremap Q gq
" Reload config. Useful for testing & troubleshooting.
nnoremap <leader>R :<C-U>source $MYVIMRC<CR>
" Uses last changed or yanked text as a characterwise object
onoremap <leader>_ :<C-U>normal! `[v`]<CR>
" Uses entire buffer as a linewise object
onoremap <leader>% :<C-U>normal! 1GVG<CR>
" Find next instance of last changed word and repeat.
nnoremap R /<c-r>-<cr>.
" Delete words with <C-del> (not working, use codes).
if $TERM == 'linux'
    " In VT
    inoremap [3~ <C-\><C-o>dw
else
    " Should work outside VT
    "inoremap <C-Del> <C-\><C-O>dw
    inoremap [3;5~ <C-\><C-o>dw
endif

" Have ctrl+scroll move by half-page, not full.
map <C-ScrollWheelUp> <C-u>
map <C-ScrollWheelDown> <C-d>
nnoremap <space> <C-d>
"nnoremap <s-space> <C-u>

" Buffers.
nnoremap <leader>bb :b<space><c-d>
nnoremap <leader>bm :bm<cr>
nnoremap <Bslash><Insert> :enew<CR>
nnoremap <Bslash><Delete> :bdel<CR>
nnoremap <leader>d :bdel<CR>
" Edit file including subdirectories.
nnoremap <leader>e :e **/

" Window panes.
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <leader>wo :only<cr>

" Browse oldfiles
nnoremap <leader>o :browse oldfiles<cr>

" Cycle through argument list
nnoremap [a :prev<CR>
nnoremap ]a :next<CR>
nnoremap [A :first<CR>
nnoremap ]A :last<CR>
" Cycle through buffers
nnoremap [b :bprev<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>
" Cycle through quickfix/errors
" TODO Clobbered by gitgutter
"nnoremap [c :cprev<CR>zz
"nnoremap ]c :cnext<CR>zz
" TODO Clobbered
"nnoremap ]] :cnext<cr>zz
"nnoremap [[ :cprev<cr>zz
nnoremap [e :cprev<CR>zz
nnoremap ]e :cnext<CR>zz
nnoremap [E :cfirst<CR>zz
nnoremap ]E :clast<CR>zz
" Cycle through location list items
nnoremap [l :lprev<CR>zz
nnoremap ]l :lnext<CR>zz
nnoremap [L :lfirst<CR>zz
nnoremap ]L :llast<CR>zz

" Cycle through buffers, tabs:
nnoremap <C-down> :bnext<CR>
nnoremap <C-up> :bprev<CR>
nnoremap <C-right> :tabnext<CR>
nnoremap <C-left> :tabprev<CR>

" New line before/after paragraph:
" Disabled due to buggy direction keys.
"nnoremap o }O
"nnoremap O {o

" Quick spelling fixes.
nmap <leader>1 1z=
nmap <leader>2 2z=

" To toggle search highlight: C-/ in terminal, C-_ in gvim. C-7 also works?
" FIXME: Not working in NeoVim for Windows.
nnoremap <C-_> :set hlsearch! hlsearch?<CR>

" Cycle line numbering types:
nnoremap <leader>N :exe 'set nu!' &nu ? 'rnu!' : ''<cr>

" Function keys.
" F1 to be a context sensitive keyword-under-cursor lookup
nnoremap <F1> :help <C-R><C-W><CR>
" Quick yank/paste
set pastetoggle=<F2>
nmap <F3> :grep<space>
" Toggle wrap.
nnoremap <F4> :set wrap! wrap?<cr>
" Toggle spellcheck.
noremap <F7> :setl spell! \| let &spelllang=g:lang<CR>
if exists("*strftime")
    nmap <F8> i<c-r>=strftime('%c')<cr><esc>
    imap <F8> <c-r>=strftime('%c')<cr>
endif
" Toggle highlighting column 80:
if has('syntax')
    nnoremap <F9> :if &cc != 80 \| setl cc=80 cc? \| else \| setl cc& cc? \| endif<cr>
endif
if has('terminal')
    nmap <F10> :terminal<CR>
endif

" <C-Space> in terminal hack
"map <C-@> <C-Space>
"imap <C-@> <C-Space>

" Alt+y
if !has('gui_running')
    vmap y <A-y>
endif
vnoremap <A-y> "+ygv
vnoremap <Leader>y "+ygv
nnoremap <M-p> "+p
nnoremap <Leader>P "+p
nnoremap Y y$
nnoremap <leader>r :<C-U>registers<CR>

" Saving
if has('win32') || has('win64')
    " TODO: Something here.
else
    " Write the file when you opened it without root privileges.
    " :w!!
    cmap w!! w !sudo tee % > /dev/null
endif
" Save if needed.
" If terminal freezes, hit <c-q> to resume.
inoremap <C-s> <C-O>:update<cr>
nnoremap <leader>fs :update<cr>
vnoremap <leader>fs <Esc>:update<cr>gv

" Alt-up/down/left/right to move lines:
if $TERM == 'linux'
    " In VT
    nnoremap [A :m .-2<CR>
    nnoremap [B :m .+1<CR>
    nnoremap [C >>
    nnoremap [D <<
    vnoremap [A :m '<-2<CR>gv=gv
    vnoremap [B :m '>+1<CR>gv=gv
    xnoremap [C >gv
    xnoremap [D <gv
else
    " Elsewhere
    nnoremap [1;3B :m .+1<CR>
    nnoremap [1;3A :m .-2<CR>
    nnoremap [1;3D <<
    nnoremap [1;3C >>
    vnoremap [1;3B :m '>+1<CR>gv=gv
    vnoremap [1;3A :m '<-2<CR>gv=gv
    xnoremap [1;3D <gv
    xnoremap [1;3C >gv
    " Enabling these two makes you need to ESC twice to ESC insert-mode.
    "inoremap [1;3B <C-o>:m .+1<CR>
    "inoremap [1;3A <C-o>:m .-2<CR>
endif

" Alt-h/j/k/l to move lines:
if $TERM == 'linux'
    " No VT versions yet.
else
    " Should work outside VT
    " Causing issues, needing extra ESCs
    "nnoremap j :m .+1<CR>
    "nnoremap k :m .-2<CR>
    "nnoremap h <<
    "nnoremap l >>
    "inoremap j <Esc>:m .+1<CR>gi
    "inoremap k <Esc>:m .-2<CR>gi
    "xnoremap j :m '>+1<CR>gv=gv
    "xnoremap k :m '<-2<CR>gv=gv
    "xnoremap h <gv
    "xnoremap l >gv
    " Not working
    "nnoremap <A-j> :m .+1<CR>
    "nnoremap <A-k> :m .-2<CR>
    "nnoremap <a-h> <<
    "nnoremap <a-l> >>
    "inoremap <A-j> <Esc>:m .+1<CR>gi
    "inoremap <A-k> <Esc>:m .-2<CR>gi
    "xnoremap <A-j> :m '>+1<CR>gv=gv
    "xnoremap <A-k> :m '<-2<CR>gv=gv
    "xnoremap <a-h> <gv
    "xnoremap <a-l> >gv
endif

" Save session
"nmap <c-S> :mks! ~/session.vim<CR>
"vmap <c-S> <Esc><c-S>gv
"imap <c-S> <c-o><c-S>

" External tools.
" FIXME: Places an error msg over cursor line until line change.
" Or hides vim until user input.
"nnoremap <silent> <F6> :!xdg-open<space><c-r><c-p><cr>
" Search definition of  word under cursor.
" TODO: Test $BROWSER on Windows.
nnoremap <silent> <leader>k :silent ! $BROWSER https://en.wiktionary.org/wiki/<cword><cr>
command -range=% CL <line1>,<line2>w !curl -F 'clbin=<-' https://clbin.com | tr -d '\n' | xclip -i -selection clipboard
command -range=% VP <line1>,<line2>w !curl -F 'text=<-' http://vpaste.net | tr -d '\n' | xclip -i -selection clipboard
" Table (column) align
vmap <leader>ca :!column -t<cr>
vmap <leader>ta :!column -to<bslash><bar> -s<bslash><bar><cr>

