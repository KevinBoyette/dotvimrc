set nocompatible " Because Vim
filetype off
filetype indent on
"------------------------------------Plugins-----------------------------------"
call plug#begin('~/.vim/plugged')
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Go
Plug 'fatih/vim-go', { 'for': 'go','do': ':GoUpdateBinaries' }
" Python
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
" yaml
Plug 'pearofducks/ansible-vim', { 'for': 'yaml,ansible' }
Plug 'stephpy/vim-yaml', { 'for': 'yaml,ansible' }
" Docker
"Plug 'docker/docker', { 'for': 'dockerfile' }
" HashiCorp Plugins
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'vim-syntastic/syntastic', {'for': 'terraform' }
Plug 'juliosueiras/vim-terraform-completion', {'for': 'terraform' }
" Nginx
" Plug 'chr4/nginx.vim'
Plug 'w0rp/ale'
Plug 'elzr/vim-json', { 'for': 'json'}
call plug#end()
set omnifunc=syntaxcomplete#Complete
"--------------------------------Settings--------------------------------------"
set encoding=utf-8
set clipboard=unnamed
set backspace=indent,eol,start
set ruler
set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)
set cursorline
" set colorcolumn=81
set listchars=tab:>~,nbsp:_,trail:.
set ttimeout
set ttimeoutlen=50
set nobackup
set nowritebackup
set autoread
set conceallevel=0 " for markdown
set ttyfast
set lazyredraw
set nocursorcolumn
set nocursorline
syntax sync minlines=256
set synmaxcol=300
set ignorecase
set smartcase
set wrap
set textwidth=79
set formatoptions=qrn1
set complete-=i
set wildmenu
set list
set noswapfile
set regexpengine=1
" Allow :find to find files below
set path+=**
set nospell
set sm
" set autochdir
set shiftwidth=4
set cindent
set tabstop=4
set softtabstop=4
set expandtab
set foldmethod=indent
set foldlevel=99
set autoindent
retab
" Security
set exrc
set secure
" search
set hlsearch
set incsearch
set showmatch
set noshowcmd noruler
set hidden
set number
"---------------------------------Functions------------------------------------"
" FUNCTION:           Remove Whitespace From File
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()
:noremap <Leader>w :call TrimWhitespace()<CR>
" END FUNCTION
"---------------------------------Groups---------------------------------------"
augroup filetype_python
    autocmd!
    autocmd BufNewFile,BufRead *.py set tabstop=4
    autocmd BufNewFile,BufRead *.py set softtabstop=4
    autocmd BufNewFile,BufRead *.py set shiftwidth=4
    autocmd BufNewFile,BufRead *.py set textwidth=81
    autocmd BufNewFile,BufRead *.py set expandtab
    autocmd BufNewFile,BufRead *.py set autoindent
    autocmd BufNewFile,BufRead *.py set fileformat=unix
    autocmd FileType python set autoindent
augroup END
augroup filetype_ruby
    autocmd!
    autocmd FileType ruby compiler ruby
    autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
augroup END
augroup filetype_cc
    autocmd!
    autocmd BufRead,BufNewFile *.c,*.h,*.cc,*.hh,*.cpp,*.ml set tabstop=2
    autocmd BufRead,BufNewFile *.c,*.h,*.cc,*.hh,*.cpp,*.ml  set shiftwidth=2
    autocmd BufRead,BufNewFile *.c,*.h,*.cc,*.hh,*.cpp,*.ml set expandtab
    autocmd BufRead,BufNewFile *.c,*.h,*.cc,*.hh,*.cpp,*.ml set softtabstop=2
    autocmd BufRead,BufNewFile *.c,*.h,*.cc,*.hh,*.cpp,*.ml match BadWhitespace /^\t\+/
    autocmd BufRead,BufNewFile *.c,*.h,*.cc,*.hh,*.cpp,*.ml match BadWhitespace /\s\+$/
    autocmd BufRead,BufNewFile *.c,*.h,*.cc,*.hh,*.cpp,*.ml set textwidth=100
    autocmd BufRead,BufNewFile *.c,*.h,*.cc,*.hh,*.cpp,*.ml set fileformat=unix
augroup END
augroup golang
    autocmd BufRead *.go set nolist
    autocmd Filetype go set makeprg=go\ build
    autocmd FileType go :setlocal sw=2 ts=2 sts=2
    autocmd FileType *.go :! go fmt *.go
    let s:tlist_def_go_settings = 'go;g:enum;s:struct;u:union;t:type;' .
                           \ 'v:variable;f:function'
augroup END
augroup filetype_misc
    " Jenkinsfile should be Groovy syntax
    au BufRead,BufNewFile Jenkinsfile set filetype=groovy
    " dockerfile Or Dockerfile
    au BufRead,BufNewFile dockerfile set filetype=Dockerfile
    " For Terraform Template files
    au BufRead,BufNewFile *.json..tpl set filetype=json
    " Highlight Ini Files
    autocmd BufRead,BufNewFile *.conf,*.ini,*.toml setf dosini
    " Throw make errors in the window
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
    " Yaml Settings
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    " Bad Whitespace
    au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
    highlight BadWhitespace ctermbg=red guibg=red
    " Set tabs for certain files
    autocmd FileType make   set noexpandtab
    autocmd FileType sh   set noexpandtab
augroup END
" augroup markdownSpell
"     autocmd!
"     autocmd FileType markdown setlocal spell
"     autocmd BufRead,BufNewFile *.md setlocal spell
" augroup END
" autocmd BufNewFile,BufReadPost *.md set filetype=markdown
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}  set filetype=markdown
"---------------------------------Colors---------------------------------------"
syntax reset
" syntax on
" syntax enable
syntax off
" colorscheme gruvbox
colorscheme peachpuff
" Grey Indent Lines
"---------------------------------Config---------------------------------------"
" Fmt on save slows things down.
" Git hooks and automation save the day
" let g:terraform_fmt_on_save=1
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_remap_spacebar=1
" Show Quotes In Json
let g:vim_json_syntax_conceal = 0
let g:markdown_fenced_languages = [ 'python', 'bash=sh', 'rust']
" :Term config, but never used
let g:split_term_default_shell = "bash"
set splitright
set splitbelow
" Disable Ale to minimize distractions
let g:ale_enabled = 0
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}
let g:ale_fix_on_save = 1
" Rust
let g:rustfmt_autosave = 1
" Python
let python_highlight_all=1
let g:SimpylFold_docstring_preview=1
let g:strip_whitespace_on_save =1
let g:better_whitespace_enabled = 1
"----------------------------------Netrw---------------------------------------"
let g:netrw_banner = 0
let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"-------------------------------Mappings---------------------------------------"
let mapleader = ','
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <Leader>g :Ggrep<space>
map ; :
" map fold to space
nnoremap <space> za
" Disable arrows
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
map <Leader>a :vsplit ~/notes.md<CR>
nmap <leader>t :! ctags<CR>
nmap <leader>c :!cscope -Rbkq
"------------------------------------End---------------------------------------"
