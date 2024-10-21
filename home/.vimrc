" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
"syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd        " Show (partial) command in status line.
set showmatch        " Show matching brackets.
set ignorecase        " Do case insensitive matching
set smartcase        " Do smart case matching
"set smartindent
"set incsearch        " Incremental search
"set autowrite        " Automatically save before commands like :next and :make
set hidden        " Hide buffers when they are abandoned
set mouse=a        " Enable mouse usage (all modes)
syntax on
set backspace=indent,eol,start
"let $RC='$HOME/.vim/vimrc'

"set nocompatible              " required
"filetype on                  " required



" ###############################################

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


" ALE ~~~~~~~~
" enable various plugin features
" Enable completion where available.
" This setting must be set before ALE is loaded.
"
" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
"let g:ale_completion_enabled = 1
"set omnifunc=ale#completion#OmniFunc



" ######################################
" Plug-Vim plugins

""call plug#begin()
"""Plug 'black/black'
""Plug 'psf/black'
""
"""Plug 'sheerun/vim-polyglot'
"""Plug 'vim-python/python-syntax'
"""Plug 'dense-analysis/ale'
"""Plug 'jeetsukumaran/vim-pythonsense'
"""Plug 'scrooloose/nerdcommenter'
""
""call plug#end() 
" ######################################


" set scroll offset (number of lines visible from bottom of screen)
set scrolloff=1

" show line numbers
set number

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" set tab widths when using >> command
set tabstop=4

" set tab widths when in Insert mode (0 defaults to regular tab stop)
set softtabstop=4

" show a visual line under the cursor's current line
"set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" enable all Python syntax highlighting features
let python_highlight_all = 1

" show formatting characters
set list

" use special unicode characters for Tab, EOL, etc. Shown here are u2192, u00b6 and u2b15
"set listchars=tab:→\ ,eol:¶↵
set listchars=tab:→\ 

" set mouse behavior (a||v will not let you copy to clipboard)
set mouse=i

"######################################
"Netrw settings
"######################################

" change default display style (simple, long, 2-column, or tree)
let g:netrw_liststyle = 1
"let g:netrw_liststyle = 2
"let g:netrw_liststyle = 3

" open splits to the right
let g:netrw_preview = 1


" Netrw normally leaves unmodified buffers open. To delete netrw's buffer once hidden or exited:
autocmd FileType netrw setl bufhidden=delete   " use :qa! if disabled.

" fuzzy searching:
set nocompatible   " limit searching to within working directory
"set path+=**    " search directories recursively
set wildmenu    " show multiple matches on one line


" Use tmp directory in $HOME to avoid issues with running commands
"let $TMPDIR = $HOME/".tmp"

" Set shell to sh to fix same issue (this works)
set shell=/bin/sh

" Highlight searches:
set hlsearch

" Search for visually selected text:
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Clear search highlights after completing:
nnoremap <silent> <ESC> :nohl<CR><ESC>


"
" Keyboard Mappings:
"

" Put blank lines without entering Insert mode:
nnoremap <Enter> o<ESC>
"nnoremap <S-Enter> O<ESC>

" Automatically insert (), [] or {}:
"inoremap () ()<Esc>i
"inoremap [] []<Esc>i
"inoremap {} {}<Esc>i
"inoremap "" ""<Esc>i
"inoremap '' ''<Esc>i
cnoremap <Left> <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>


" Automate filetype-specific comment insertion

let g:COMMENTS = { 'python': '# ', 'sh': '# ', 'c': '\/\/ ', 'cpp': '\/\/ ', 'javascript': '\/\/ ', 'java': '\/\/ ', 'rust': '\/\/ ', 'html': '<-- ', 'xml': '<-- ', 'sql': '-- ', 'vim': '\"' , }
let g:HASH_COMMENTS  = ['python', 'sh', 'zsh', 'perl', 'ruby', ]
let g:SLASH_COMMENTS = ['c', 'cpp', 'js', 'java', 'rust', ]
let g:ML_COMMENTS    = ['html', 'xml', ]
let g:OTHER_COMMENTS = {'vim': '" ', }

function GetComment()
    return comment = get(g:COMMENTS, &filetype, '')
    endf

function InsertComment()
    "if &filetype in ['html', 'xml']:
    "if &filetype == 'html' || 'xml':
        "execute 's/\v(\ze|\n).*($)/'

    let b:cur_pos = getpos('.')
    "return get(g:COMMENTS, &filetype, '') "| call setpos('.', current_pos) <CR><Esc>
    let b:COMMENT = get(g:COMMENTS, &filetype, '# ')
    execute 's/\v(\ze\S|\n)/' . b:COMMENT

    let b:cur_pos[2] += len(b:COMMENT)
    call setpos('.', b:cur_pos)
endf


nnoremap <silent> <C-_> :call InsertComment() <CR>
inoremap <silent> <C-_> <C-o>:call InsertComment() <CR>

"nnoremap <C-_> I<C-R>=SavePos() | call GetComment() | call setpos('.', b:cur_pos) <CR><Esc>
"nnoremap <C-_> I<C-R>=get(COMMENTS, &filetype, '') | call setpos('.', current_pos) <CR><Esc>
"inoremap <C-_> <Esc>I<C-R>=get(COMMENTS, &filetype, '') | call setpos('.', current_pos) <CR><Esc>

" Search highlighting looks weird in Terminator for some reason, likely
" because of my settings for the black color.
" For now, link Search group to Todo :
hi link Search Todo


" A custom statusline
"hi CustomStatusline cterm=bold ctermfg=white ctermbg=darkred
hi CustomStatusline cterm=bold ctermfg=15 ctermbg=8
"hi CustomStatusline cterm=bold ctermfg=darkred ctermbg=none
set statusline=
set statusline+=%#CustomStatusline#
set statusline+=%<%F
set statusline+=%m%h%r%w\ 
set statusline+=%{&fileencoding}
set statusline+=%=
set statusline+=%04l/%04LL\ 
set statusline+=%03c/%03{strwidth(getline('.'))}C\ 
set statusline+=a(%03b)=h(%02B)

set laststatus=2

" Python Abbreviations
abbr sf self
abbr im import
abbr def_ def foo(self,<CR><BS>bar,<CR><BS><BS>) -> None:
abbr ini_ def __init__(<CR><BS>self,<CR>foo,<CR><BS>) -> None:


" hnei = hjkl for Colemak
"nnoremap n j
"nnoremap j n
"nnoremap e k
"nnoremap k e
"nnoremap i l
"nnoremap l i
