scriptencoding utf-8
source ~/.config/nvim/plugins.vim

" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "

" Remap leader key to ,
let g:mapleader=','

" Disable line numbers
set nonumber

" relative line number
set relativenumber
" Don't show last command
set noshowcmd

" Yank and paste with the system clipboard
set clipboard=unnamed

" Hides buffers instead of closing them
set hidden

" === TAB/Space settings === "
" Insert spaces when TAB is pressed.
set expandtab

" Change number of spaces that a <Tab> counts for during editing ops
set softtabstop=2

" Indentation amount for < and > commands.
set shiftwidth=2

" do not wrap long lines by default
set nowrap

" Don't highlight current cursor line
set nocursorline

" Disable line/column number in status line
" Shows up in preview window when airline is disabled if not
set noruler

" Only one line for command line
set cmdheight=1

" === Completion Settings === "

" Don't give completion messages like 'match 1 of 2'
" or 'The only match'
set shortmess+=c


"  ==== Reload vim config ==== "
nmap <leader>r :source ~/.config/nvim/init.vim<CR>


" ====== Wipe Register on vim enter ==========
" autocmd VimEnter * WipeReg

" ======= Disable Arrow keys ================="
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" ======= Past current yank workd ==========="
"map <C-j> cw<C-r>0<ESC>

" PLUGIN SETUP -------------------------------------------{{{

" uuid setup
let g:nuuid_no_mappings = 1
nnoremap <Leader>u <Plug>Nuuid

" Grammer fix
nnoremap <Leader>g <Plug>(grammarous-fixall)	

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

"=== Coc.nvim === "
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Show method signatur
autocmd FileType typescript setlocal completeopt+=menu,preview
" === NeoSnippet === "
" Map <C-k> as shortcut to activate snippet if available
" imap <C-k> <Plug>(neosnippet_expand_or_jump)
" smap <C-k> <Plug>(neosnippet_expand_or_jump)
" xmap <C-k> <Plug>(neosnippet_expand_target)
inoremap <silent><expr> <c-space> coc#refresh()

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<C-n>'
let g:coc_snippet_prev = '<C-p>'


command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>aap  <Plug>(coc-codeaction-selected)
nmap <leader>aap  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>af  <Plug>(coc-fix-current)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>


" Load custom snippets from snippets folder
"let g:neosnippet#snippets_directory='~/.config/nvim/snippets'

" Hide conceal markers
"let g:neosnippet#enable_conceal_markers = 0

" === NERDTree === "
" Show hidden files/directories
let g:NERDTreeShowHidden = 1

let g:NERDTreeDirArrows = 1
" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

let g:NERDTreeQuitOnOpen = 1

let g:NERDTreeAutoDeleteBuffer = 1

let g:NERDTreeQuitOnOpen = 1

" Automaticaly close nvim if NERDTree is only thing left open
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Wrap in try/catch to avoid errors on initial install before plugin is available
try

" === Vim airline ==== "
" Enable extensions
let g:airline_extensions = ['coc', 'tabline']

" to enable status on top
" let g:airline_statusline_ontop=1

" Update section z to just have line number
let g:airline_section_z = airline#section#create(['linenr'])

" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'

let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" Configure error/warning section to use coc.nvim
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Hide the Nerdtree status line to avoid clutter
"let g:NERDTreeStatusline = ''

" Disable vim-airline in preview mode
"let g:airline_exclude_preview = 1

" Enable powerline fonts
"let g:airline_powerline_fonts = 1

" Enable caching of syntax highlighting groups
"let g:airline_highlighting_cache = 1

" Don't show git changes to current file in airline
let g:airline#extensions#hunks#enabled=0

let g:airline#extensions#tabline#fnamemod = ':t' "Show only file name

" TsuQuyomi
let g:tsuquyomi_use_local_typescript = 0
" nvim-typescript
let g:nvim_typescript#default_mappings = 1
" Move to the next buffer
nmap <C-]> :TSDef<CR>

catch
  echo 'Airline not installed. It should work after running :PlugInstall'
endtry

" === echodoc === "
" Enable echodoc on startup
let g:echodoc#enable_at_startup = 1

" === vim-javascript === "
" Enable syntax highlighting for JSDoc
let g:javascript_plugin_jsdoc = 1

" === vim-jsx === "
" Highlight jsx syntax even in non .jsx files
let g:jsx_ext_required = 0

" === javascript-libraries-syntax === "
let g:used_javascript_libs = 'underscore,requirejs,chai,jquery'

" === Signify === "
let g:signify_sign_delete = '-'

" === Magit ======"
let g:magit_discard_untracked_do_delete=1
" === Splunker ==="
set nospell

"let g:enable_spelunker_vim = 1
" Override highlight setting.
"highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#9e9e9e
"highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE

"}}}

" UI ------------------------------------{{{

" Enable true color support
set termguicolors

" Editor theme
set background=dark
try
  colorscheme OceanicNext
catch
  colorscheme slate
endtry

au BufReadPost *.prisma set syntax=graphql

" Vim airline theme
"let g:airline_theme='space'

" Add custom highlights in method that is executed every time a
" colorscheme is sourced
" See https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f for
" details
function! MyHighlights() abort
  " Hightlight trailing whitespace
  highlight Trail ctermbg=red guibg=red
  call matchadd('Trail', '\s\+$', 100)
endfunction

augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to appear at bottom
set splitbelow

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" coc.nvim color changes
hi! link CocErrorSign WarningMsg
hi! link CocWarningSign Number
hi! link CocInfoSign Type

" Make background transparent for many things
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
hi! LineNr ctermfg=NONE guibg=NONE
hi! SignColumn ctermfg=NONE guibg=NONE
hi! StatusLine guifg=#16252b guibg=#6699CC
hi! StatusLineNC guifg=#16252b guibg=#16252b

" Try to hide vertical spit and end of buffer symbol
hi! VertSplit gui=NONE guifg=#17252c guibg=#17252c
hi! EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=#17252c guifg=#17252c

" Customize NERDTree directory
hi! NERDTreeCWD guifg=#99c794

" Make background color transparent for git changes
hi! SignifySignAdd guibg=NONE
hi! SignifySignDelete guibg=NONE
hi! SignifySignChange guibg=NONE

" Highlight git change signs
hi! SignifySignAdd guifg=#99c794
hi! SignifySignDelete guifg=#ec5f67
hi! SignifySignChange guifg=#c594c5

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of preview window when open
function! Handle_Win_Enter()
  if &previewwindow
    setlocal winhighlight=Normal:MarkdownError
  endif
endfunction
"}}}

" KEY MAPPINGS ---------------------------------------------{{{
" Quick save
noremap <leader>s :update<CR>

" === Nerdtree shorcuts === "
"  <leader>n - Toggle NERDTree on/off
"  <leader>f - Opens current file location in NERDTree
" nmap <leader>n :NERDTree<CR>
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

"   <Space> - PageDown
"   -       - PageUp
noremap <Space> <PageDown>
noremap - <PageUp>

" Move line
let g:move_key_modifier = 'C'

" === coc.nvim === "
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)

" === vim-better-whitespace === "
"   <leader>y - Automatically remove trailing whitespace
nmap <leader>y :StripWhitespace<CR>

" === Search shorcuts === "
"   <leader>h - Find and replace
"   <leader>/ - Claer highlighted search terms while preserving history
map <leader>h :%s///<left><left>
nmap <silent> <leader>/ :nohlsearch<C
" === Easy-motion shortcuts ==="
"   <leader>e - Easy-motion highlights first word letters bi-directionally
map <leader>e <Plug>(easymotion-bd-w)

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" === vim-jsdoc shortcuts ==="
" Generate jsdoc for function under cursor
nmap <leader>z :JsDoc<CR>

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP

let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'

nnoremap <silent> <leader>cm  :Commits<CR>
nnoremap <silent> <leader>bc :BCommits<CR>
"}}}

" Tabs/Buffers--------------------------------------------------{{{
""This allows buffers to be hidden if you've modified a buffer.
""This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>w :bnext<CR>

" Move to the previous buffer
nmap <leader>q :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>c :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>
map Q <Nop>
nnoremap <silent> Q :Bdelete menu<CR>

"}}}

" Folding--------------------------------------------------{{{
let g:tex_fold_enabled=1
let g:vimsyn_folding='af'
let g:xml_syntax_folding = 1
let g:php_folding = 1
let g:perl_fold = 1

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}

function! JavaScriptFold() "{{{
    " syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend
    setlocal foldmethod=syntax
    setlocal foldlevel=99
    echo "hello"
    syn region foldBraces start=/{/ skip=/\(\/\/.*\)\|\(\/.*\/\)/ end=/}/ transparent fold keepend extend
endfunction "}}}

function! HTMLFold() "{{{
    " syn sync fromstart
    set foldmethod=syntax
    syn region HTMLFold start=+^<\([^/?!><]*[^/]>\)\&.*\(<\1\|[[:alnum:]]\)$+ end=+^</.*[^-?]>$+ fold transparent keepend extend
    syn match HTMLCData "<!\[CDATA\[\_.\{-}\]\]>" fold transparent extend
    syn match HTMLCommentFold "<!--\_.\{-}-->" fold transparent extend
endfunction "}}}

set foldtext=MyFoldText()

autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

autocmd FileType vim setlocal fdc=1
set foldlevel=99
" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldlevel=0

au FileType html call HTMLFold()
autocmd FileType html setlocal foldmethod=syntax
autocmd FileType html setlocal fdl=99

" autocmd FileType javascript call JavaScriptFold()
autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
autocmd FileType javascript,typescript,css,scss,json setlocal foldmethod=marker
autocmd FileType javascript,typescript,css,scss,json setlocal foldmarker={,}
autocmd FileType coffee setl foldmethod=indent
autocmd FileType python setl foldmethod=indent
" au FileType html nnoremap <buffer> <leader>F zfat

" }}}

" Search files Rg:--------------------------------------------------{{{
nnoremap <C-f> :Rg<Space>
nnoremap <C-p> :GFiles<CR>
nnoremap <silent> <leader>m :FZFMru<CR>
noremap <leader>. :Buffers<CR>

" .............................................................................
" mhinz/vim-grepper
" .............................................................................

let g:grepper={}
let g:grepper.tools=["rg"]

xmap gr <plug>(GrepperOperator)

" After searching for text, press this mapping to do a project wide find and
" replace. It's similar to <leader>r except this one applies to all matches
" across all files instead of just the current file.
nnoremap <Leader>R
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" The same as above except it works with a visual selection.
xmap <Leader>R
    \ "sy
    \ gvgr
    \ :cfdo %s/<C-r>s//g \| update
     \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" Toggle quickfix window.
function! QuickFix_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor

    copen
endfunction
nnoremap <silent> <Leader>c :call QuickFix_toggle()<CR>



"}}}

" Indent -----------------------------------------------------{{{
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=23
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=73

let g:indentLine_char_list = ['|', '¦', '┆']
let g:indentLine_bgcolor_term = 202
"let g:indentLine_bgcolor_gui = '#FF5F00'
"}}}

" Pretter ---------------------------------------------------{{{
" let g:prettier#exec_cmd_async = 1
" " when running at every change you may want to disable quickfix
" let g:prettier#quickfix_enabled = 1

" let g:prettier#autoformat = 0
" " autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
" let g:prettier#config#single_quote = 'true'
" let g:prettier#config#parser = 'typescript'
" nmap <Leader>py <Plug>(Prettier)
" }}}
" Ale --------------------------------------------------------{{{
" let g:ale_sign_column_always = 1
" }}}


" Git Merget tool --------------------------------------------{{{
if &diff
  map <leader>1 :diffget LOCAL<CR>
  map <leader>2 :diffget BASE<CR>
  map <leader>3 :diffget REMOTE<CR>
endif
" }}}

" MISC -----------------------------------------------------{{{

" === Search === "
" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" Automatically re-read file if a change was detected outside of vim
set autoread

" Enable line numbers
set number

" Set backups
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.local/share/nvim/backup " Don't put backups in current dir
set backup
set noswapfile

" Reload icons after init source
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

"}}}
