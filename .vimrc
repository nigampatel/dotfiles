" compatibility mode, no
set nocp

" workaround for gvim screen redraw issues
set ttyscroll=0

" colors, yes
set t_Co=256
syntax on

" no swap files
set noswapfile

" don't write to a backup file then delete the original and then rename the
" backup to the name of the original file... it's annoying
set nowritebackup

" syntax-specific stuff, yes
filetype plugin on

" pathogen - https://github.com/tpope/vim-pathogen
call pathogen#infect()

" pass correct key-codes in tmux
if &term =~ '^screen' && exists('$TMUX')
    set mouse+=a
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <xHome>=\e[1;*H"
    execute "set <xEnd>=\e[1;*F"
    execute "set <Insert>=\e[2;*~"
    execute "set <Delete>=\e[3;*~"
    execute "set <PageUp>=\e[5;*~"
    execute "set <PageDown>=\e[6;*~"
    execute "set <xF1>=\e[1;*P"
    execute "set <xF2>=\e[1;*Q"
    execute "set <xF3>=\e[1;*R"
    execute "set <xF4>=\e[1;*S"
    execute "set <F5>=\e[15;*~"
    execute "set <F6>=\e[17;*~"
    execute "set <F7>=\e[18;*~"
    execute "set <F8>=\e[19;*~"
    execute "set <F9>=\e[20;*~"
    execute "set <F10>=\e[21;*~"
    execute "set <F11>=\e[23;*~"
    execute "set <F12>=\e[24;*~"
endif

" indenting
filetype indent on
set expandtab       " Use softtabstop spaces instead of tab characters for indentation - abbr et
set shiftwidth=4    " Indent by 4 spaces when using >>, <<, == etc. - abbr sw
set softtabstop=4   " Indent by 4 spaces when pressing <TAB> - abbr sts
set tabstop=4       " Indent by 4 spaces when pressing <TAB> - abbr ts
set smartindent     " Automatically inserts indentation in some cases
set smarttab        " A <Tab> in front of a line inserts blanks according to 'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places.  A <BS> will delete a 'shiftwidth' worth of space at the start of the line.

" set word separators
set iskeyword-=_

" unix style line endings
set ff=unix

" set leader
let mapleader="\<Space>"

" wildmenu makes life better
set wildmenu wildmode=list:longest,full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" A buffer becomes hidden when it is abandoned
set hid

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Makes search act like search in modern browsers
set incsearch

" set %% as abbreviation for working directory
cabbr <expr> %% expand('%:p:h')

" allow lots and lots of tabs, even though we don't use them much
set tabpagemax=50

" replay q macro with Q
nnoremap Q @q

" make Y yank to end of line as with C and D
nnoremap Y y$

" easier switch to split
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-k> <C-w>k
nmap <C-j> <C-w>j

" copy paste from system clipboard
vmap ç "*y
vmap ≈ "*d
nmap √ :set paste<CR>"*p:set nopaste<CR>
imap √ <ESC>:set paste<CR>"*p:set nopaste<CR>a

" toggle paste mode with <F1> ... this way you can leave autocommenting on most of the time a quickly disable it for pasting in code
set pastetoggle=<F1>
set showmode

" fix backspace (for windows)
set backspace=indent,eol,start

" remove trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" replace tabs with spaces
nnoremap <Leader>tts :%s/	/    /g<CR>

" tabs to spaces
command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'

" spaces to tabs
command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" Don't redraw while executing macros (good performance config)
set lazyredraw

" scrollbars, no
set guioptions=

" line numbers, yes
set number
set nuw=6  " number width to 6 makes things look a little neater

" word wrap, no
set nowrap

" Height of the command bar
set cmdheight=2

" status line
set noruler             " ruler, no
set laststatus=2        " statusbar on every buffer, yes
let g:airline_powerline_fonts=1
let g:airline_theme="hybridline"

" highlight char at 81st column
call matchadd('ColorColumn', '\%81v', 100)

" Show trailing whitespace and tabs
augroup extrawhitespace_autocmd
    autocmd!
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$\|\t/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$\|\t/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$\|\t/
    autocmd BufWinLeave * call clearmatches()
    autocmd InsertEnter * set nolist
    autocmd InsertLeave * set list
augroup END
set listchars=tab:▶▶,trail:∙,nbsp:▒
set list

" theme
set background=dark
let g:enable_bold_font=1
let g:gitgutter_override_sign_column_highlight=0

colorscheme mho

fun! SetColorScheme()
    if (&ft == '')
        return
    elseif &ft == 'go'
        colorscheme triplejelly
    else
        colorscheme mho
    endif
    :AirlineRefresh
endfun

augroup colorscheme_autocmd
    autocmd!
    autocmd BufEnter * call SetColorScheme()
augroup END

" font
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h14
  elseif has("gui_win32")
    set guifont=Consolas:h13:cANSI
  endif
endif

" highlight next search item
set hls
nnoremap <Leader>n :nohls<cr>
autocmd BufWinEnter * highlight NextItem ctermbg=112 guibg=#87d700 ctermfg=236 guifg=#303030
nnoremap <silent> n n:call HLNext(80)<cr>
nnoremap <silent> N N:call HLNext(80)<cr>
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('NextItem', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime) . 'm'
    call matchdelete(ring)
    redraw
endfunction

" use html syntax on ejs and mustache files
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.mustache set filetype=html

" json formatting
au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
    autocmd!
    autocmd FileType json set autoindent
    autocmd FileType json set formatoptions=tcq2l
    autocmd FileType json set textwidth=78 shiftwidth=4
    autocmd FileType json set softtabstop=4 tabstop=4
    autocmd FileType json set expandtab
    autocmd FileType json set foldmethod=syntax
augroup END

" ****************
" Plugins
" ****************

" make sure vim has a tmp directory to write to ... needed for fugitive to
" work
set directory+=,~/tmp,$TMP

" yankring - http://www.vim.org/scripts/script.php?script_id=1234
nnoremap <silent> <F4> :YRShow<CR>
let g:yankring_zap_keys = 'f F t T / ?'

" NERDtree - http://vim.sourceforge.net/scripts/script.php?script_id=1658
nnoremap <silent> <Leader>a :execute ':silent! NERDTreeToggle'<cr>
fun! InitNERDTree()
    let isNERDTree = (&ft == 'nerdtree')
    let dir = (argv() != []) ? fnamemodify(argv()[0], ':h') : expand('%:p:h')
    sleep 1m
    if (isNERDTree)
        :execute ':NERDTree ' . dir
        :wincmd h
    else
        :execute ':NERDTree ' . dir
        :wincmd l
    endif
    :only
endfun
autocmd vimenter * call InitNERDTree()

" gundo - http://sjl.bitbucket.org/gundo.vim/
nnoremap <silent> <F6> :GundoToggle<CR>

" source closetag script
au Filetype html,xml,xsl,ejs,mustache source ~/.vim/scripts/closetag.vim

" eslint
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_html_checkers=[]
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0

" enable emmet just for html/css
let g:user_emmet_install_global=0
autocmd FileType html,ejs,mustache,css EmmetInstall

" intellisense
set omnifunc=syntaxcomplete#Complete
" popup menu inserts the longest common text of all matches
" and the menu will come up even if there's only one match.
set completeopt=longest,menuone

" Custom IDE functionality using tmux
function! RunInTmux(cmd)
  :execute ":silent !tmux splitw -h '".a:cmd."; tmux select-pane -L'"
endfunction
autocmd FileType markdown nnoremap <Leader>k :!open -a Marked\ 2.app '%:p'<CR>
"autocmd FileType javascript nnoremap <Leader>n :call RunInTmux('node --debug --es_staging %')<CR>
"autocmd FileType sh nnoremap <Leader>e :call RunInTmux('sh %')<CR>
"nnoremap <Leader>! :call RunInTmux('chmod +x % && %')<CR>
"nnoremap <Leader>m :call RunInTmux('make')<CR>
command! -nargs=1 ND :execute ":silent !tmux splitw -h 'killall -9 node;node-vim-inspector " . string(<q-args>) . " --es_staging';sleep 2;tmux splitw -v 'node debug localhost:5858';tmux select-pane -L" | :nbs

