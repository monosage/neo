" PLUGINS------------------------------- {{{
" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif


call plug#begin('~/.config/nvim/plugged')


" === UI === "
" Colorscheme
Plug 'mhartington/oceanic-next'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"===Code===
Plug 'tpope/vim-surround'
" Auto reload file
Plug 'djoshea/vim-autoread'
" Comments
Plug 'scrooloose/nerdcommenter'
" Indent
Plug 'Yggdroot/indentLine'
" spell checker
Plug 'rhysd/vim-grammarous'
" auto-close plugin
Plug 'rstacruz/vim-closer'
" Improved motion in Vim
Plug 'easymotion/vim-easymotion'
" Trailing whitespace h ighlighting & automatic fixing
Plug 'ntpeters/vim-better-whitespace'
" move line
Plug 'matze/vim-move'
" Auto close pair
"Plug 'jiangmiao/auto-pairs'



"=== Project ==="
Plug 'thaerkh/vim-workspace'

Plug 'mhinz/vim-startify'
" Tmux/Neovim movement integration
Plug 'liuchengxu/vista.vim'
" Code folding
Plug 'Konfekt/FastFold'
" Intellisense Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
        \'coc-eslint',
        \'coc-git',
        \'coc-snippets',
        \'coc-tabnine',
        \'coc-eslint',
        \'coc-git',
        \'coc-jest',
        \'coc-tsserver',
        \'coc-emmet',
        \'coc-css',
        \'coc-html',
        \'coc-json',
        \'coc-yank',
        \'coc-prettier',
        \'coc-explorer',
        \'coc-java'
        \]


Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'brooth/far.vim'

" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'samoshkin/vim-mergetool'

"Buffer
Plug 'Asheq/close-buffers.vim'
" Multiline select <C-n>
Plug 'terryma/vim-multiple-cursors'

" Marks
Plug 'kshenoy/vim-signature'

"=== Languages ==="
"TypeScript & JavaScript
Plug 'HerringtonDarkholme/yats.vim'
"HTML & CSS
Plug 'mattn/emmet-vim'
Plug 'jparise/vim-graphql'

"=== Games ==="
"Plug 'ThePrimeagen/vim-be-good'

call plug#end()

"}}}
