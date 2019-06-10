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

" === Editing Plugins === "
" Auto reload file
Plug 'djoshea/vim-autoread'
" Comments
Plug 'scrooloose/nerdcommenter'
" Indent
Plug 'Yggdroot/indentLine'

" spell checker
Plug 'rhysd/vim-grammarous'

" Plug 'kamykn/spelunker.vim'
" Fuzzy finding
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'

" Prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'w0rp/ale' "Require by prettier

" Trailing whitespace highlighting & automatic fixing
Plug 'ntpeters/vim-better-whitespace'

" auto-close plugin
Plug 'rstacruz/vim-closer'

" Code folding
Plug 'Konfekt/FastFold'

" Improved motion in Vim
Plug 'easymotion/vim-easymotion'

" Intellisense Engine
" Plug 'neoclide/coc.nvim', { 'do': 'yarn install' }
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Tmux/Neovim movement integration
Plug 'christoomey/vim-tmux-navigator'

" === Git Plugins === "
" Enable git changes to be shown in sign column
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
" === Javascript Plugins === "
" Typescript syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mhartington/nvim-typescript', {'do': 'sh install.sh'}
" Generate JSDoc commands based on function signature
Plug 'heavenshell/vim-jsdoc'

" === Syntax Highlighting === "
" ReactJS JSX syntax highlighting
Plug 'mxw/vim-jsx'

"Graph Ql
Plug 'jparise/vim-graphql'

" Syntax highlighting for javascript libraries
Plug 'othree/javascript-libraries-syntax.vim'

" Improved syntax highlighting and indentation
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'othree/yajs.vim'

" go lang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" emmet
Plug 'mattn/emmet-vim'

" === UI === "
" File explorer
Plug 'scrooloose/nerdtree'

" Colorscheme
Plug 'mhartington/oceanic-next'

" Customized vim status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" move line
Plug 'matze/vim-move'

" Auto close pair
Plug 'jiangmiao/auto-pairs'
Plug 'Asheq/close-buffers.vim'

" Markdown
Plug 'gabrielelana/vim-markdown'
" Initialize plugin system
call plug#end()

"}}}
