scriptencoding utf-8
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/scripts/code-fold.vim

" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "
" Remap leader key to ,
let g:mapleader=','

" Yank and paste with the system clipboard
set clipboard=unnamed

" relative line number
set number relativenumber

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

set noautochdir

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

" Spell check
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell
set complete+=kspell


"  ==== Reload vim config ==== "
nmap <leader>r :source ~/.config/nvim/init.vim<CR>

" UI ------------------------------------{{{

" Enable true color support
set termguicolors

" Editor theme
"set background=dark
try
  colorscheme OceanicNext
catch
  colorscheme slate
endtry


" === Vim airline ==== "
" Enable extensions
let g:airline_extensions = ['coc', 'tabline']
" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'
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


" ------------------------------------------}}}

" KEY MAPPINGS ---------------------------------------------{{{
nnoremap <C-c> <Esc>
vnoremap <C-c> <Esc>gV
onoremap <C-c> <Esc>
cnoremap <C-c> <C-C><Esc>
inoremap <C-c> <Esc>`^
inoremap <Leader><C-c> <Tab>

" Quick save
noremap <leader>s :update<CR>
" Remove highlight
noremap <leader>c :nohl<CR>
" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>P "_dP
noremap <leader>p :Format<CR>

"}}}

" PLUGIN SETUP -------------------------------------------{{{

" === vim-better-whitespace === "
"   <leader>y - Automatically remove trailing whitespace
nmap <leader>y :StripWhitespace<CR>

" === Easy-motion shortcuts ==="
"   <leader>e - Easy-motion highlights first word letters bi-directionally
map <leader>e <Plug>(easymotion-bd-w)

" === COC === "
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
   call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
   call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

set statusline+=%#warningmsgj#
set statusline+=%{StatusDiagnostic()}
"set statusline^=%{coc#status()}
set statusline+=%*
" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
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

" Show all open buffers and their status
nmap <leader>bl :ls<CR>
map Q <Nop>
nnoremap <silent> Q :Bdelete menu<CR>

"}}}

"Search---------------------------------------------{{{
" ignore case when searching
set ignorecase
" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase
" Automatically re-read file if a change was detected outside of vim
set autoread

"===Rg===
nnoremap <C-f> :Rg<Space>
nnoremap <C-p> :GFiles<CR>
nnoremap <silent> <leader>m :FZFMru<CR>
noremap <leader>. :Buffers<CR>
" bind K to grep word under cursor
nnoremap F :Rg "<C-R><C-W>"

"===brooth/far.vim===
nnoremap <Leader>fr :Far<Space>
vnoremap <Leader>fr :Far<Space>

" === Type z/ to toggle highlighting on/off === "
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

"}}}

" Vista.vim ------------------------- {{{

noremap <c-t> :silent! Vista finder coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" }}}

"FileExplorer --------------------------{{{
nmap <leader>f :CocCommand explorer --quit-on-open <CR>
nmap <leader>n :CocCommand explorer  --quit-on-open <CR>

"let g:netrw_banner = 0
"let g:netrw_liststyle = 0
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1

"function! s:close_explorer_buffers()
    "for i in range(1, bufnr('$'))
        "if getbufvar(i, '&filetype') == "netrw"
            "silent exe 'bdelete! ' . i
        "endif
    "endfor
"endfunction

"nnoremap <leader>n :call <sid>close_explorer_buffers()<cr>
"nmap <leader>f :Vexplore<CR>

"let g:netrw_fastbrowse = 0

"}}}
