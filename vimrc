let data_dir = '~/.vim'
if executable(expand('~/.vim/bin/rg'))
  let $PATH = expand('~/.vim/bin') . ':' . $PATH
endif

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

augroup vimrc_plug_install
  autocmd!
  autocmd VimEnter * if exists('g:plugs') && len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
    \| endif
augroup END

call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-surround'
  Plug 'jiangmiao/auto-pairs'
  Plug 'junegunn/fzf', { 'do': './install --all' }
  if v:version < 800
    Plug 'junegunn/fzf.vim', { 'commit': '5ab282c2f4a597fa655f39f36e7ee8e97bf51650' }
  else
    Plug 'junegunn/fzf.vim'
  endif
  Plug 'mtdl9/vim-log-highlighting'
  Plug 'osyo-manga/vim-anzu'
  if v:version < 800 && has('timers')
    Plug 'machakann/vim-highlightedyank', { 'commit': '03fe057c5836a3f3897a943dc96bdfe3f087890e' }
  elseif v:version >= 800
    Plug 'machakann/vim-highlightedyank'
  endif
call plug#end()

let mapleader = "\<Space>"
set background=dark
if !has('gui_running') && &t_Co < 256
  set t_Co=256
endif
if has('termguicolors')
  set termguicolors
endif
silent! colorscheme anticuus

highlight Normal  ctermbg=NONE guibg=NONE ctermfg=White guifg=#FFFFFF
highlight NonText ctermbg=NONE guibg=NONE
highlight CursorLine term=NONE cterm=NONE gui=NONE ctermbg=NONE guibg=NONE
highlight CursorLineNr term=bold ctermfg=Yellow guifg=#E5C07B ctermbg=NONE guibg=NONE cterm=bold gui=bold
highlight HighlightedyankRegion ctermfg=Black guifg=#000000 ctermbg=Yellow guibg=yellow
highlight NormalNC ctermbg=NONE guibg=NONE
highlight Search ctermfg=Black guifg=#000000 ctermbg=Yellow guibg=#FFCC66
highlight LineNr ctermbg=NONE guibg=NONE
highlight Visual ctermbg=Gray guibg=Gray ctermfg=Black guifg=Black

let g:highlightedyank_highlight_duration = 140
if v:version < 800 && has('timers')
  nmap y <Plug>(highlightedyank)
  xmap y <Plug>(highlightedyank)
  omap y <Plug>(highlightedyank)
endif

let $FZF_DEFAULT_OPTS = '--bind=tab:up,shift-tab:down'
let g:fzf_layout = { 'window': 'enew' }

" netrw settings
let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1

augroup vimrc_netrw
  autocmd!
  autocmd FileType,BufEnter,BufWinEnter * call HideNetrwBuffer()
  autocmd FileType netrw nnoremap <buffer> <C-l> :wincmd l<CR>
  autocmd FileType netrw nnoremap <buffer> <C-h> :wincmd h<CR>
  autocmd FileType netrw nnoremap <buffer> <C-j> :wincmd j<CR>
  autocmd FileType netrw nnoremap <buffer> <C-k> :wincmd k<CR>
augroup END

augroup vimrc_quickfix
  autocmd!
  autocmd FileType qf nnoremap <buffer> <Tab> j
  autocmd FileType qf nnoremap <buffer> <S-Tab> k
  autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
augroup END

set laststatus=2

set number
set relativenumber
set cursorline
set scrolloff=8

set noincsearch
set ignorecase
set smartcase

set clipboard=unnamedplus
set noswapfile
set nobackup
if exists('&undofile')
  set undofile
  if exists('&undodir')
    set undodir=~/.vim/undodir
  endif
endif

set hidden

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smartindent
if v:version >= 800
  set fillchars=eob:\ 
endif

set statusline=%{exists('*anzu#search_status')?anzu#search_status():''}

" --- Netrw toggle (like neo-tree) ---
function! NetrwToggle()
  for i in range(1, winnr('$'))
    if getbufvar(winbufnr(i), '&filetype') ==# 'netrw'
      execute i . 'wincmd w'
      close
      return
    endif
  endfor
  let g:netrw_return_win = winnr()
  if exists(':Lexplore') == 2
    Lexplore
  else
    execute 'topleft vertical ' . g:netrw_winsize . 'new'
    Explore
  endif
endfunction

function! SafeWincmd(dir)
  let l:current = winnr()
  execute 'wincmd ' . a:dir
  if winnr() == l:current
    return
  endif
  if &filetype ==# 'netrw'
    execute l:current . 'wincmd w'
  endif
endfunction

function! GitRoot()
  let l:root = substitute(system('git rev-parse --show-toplevel'), '\n\+$', '', '')
  if v:shell_error == 0 && !empty(l:root)
    return l:root
  endif
  return getcwd()
endfunction

function! FzfRg()
  if exists(':Rg') != 2 && exists(':grep') != 2
    echohl WarningMsg | echom 'No project search command is available' | echohl None
    return
  endif
  execute 'lcd ' . fnameescape(GitRoot())
  if executable('rg') && exists(':Rg') == 2
    Rg
  else
    let l:query = input('Search: ')
    if empty(l:query)
      return
    endif
    let l:results = system('grep -RIn -e ' . shellescape(l:query) . ' . 2>/dev/null')
    if empty(l:results)
      echohl WarningMsg | echom 'No matches found' | echohl None
      return
    endif
    cgetexpr split(l:results, "\n")
    copen
  endif
endfunction

function! SafeBdelete()
  if &filetype ==# 'netrw'
    echohl WarningMsg | echom 'Cannot delete buffer from netrw' | echohl None
    return
  endif

  let l:buflisted = filter(range(1, bufnr('$')), 'buflisted(v:val)')
  if len(l:buflisted) <= 1
    echohl WarningMsg | echom 'Cannot delete last buffer' | echohl None
    return
  endif

  let l:buf = bufnr('%')
  bprevious
  execute 'bdelete ' . l:buf
endfunction

function! IsNetrwBuffer(buf)
  let l:name = bufname(a:buf)
  return getbufvar(a:buf, '&filetype') =~# '^netrw'
    \ || fnamemodify(l:name, ':t') ==# 'NetrwTreeListing'
    \ || (!empty(l:name) && isdirectory(l:name))
endfunction

function! HideNetrwBuffer()
  if IsNetrwBuffer(bufnr('%'))
    setlocal nobuflisted
  endif
endfunction

function! ListedFileBuffers()
  return filter(range(1, bufnr('$')), 'buflisted(v:val) && !IsNetrwBuffer(v:val)')
endfunction

function! SafeBnext(dir)
  let l:buffers = ListedFileBuffers()
  if empty(l:buffers)
    return
  endif

  let l:current = bufnr('%')
  let l:index = index(l:buffers, l:current)
  if l:index < 0
    let l:index = 0
  elseif a:dir > 0
    let l:index = (l:index + 1) % len(l:buffers)
  else
    let l:index = (l:index - 1 + len(l:buffers)) % len(l:buffers)
  endif

  execute 'buffer ' . l:buffers[l:index]
endfunction

if exists(':Buffers') == 2
  command! -bar -bang -nargs=? -complete=buffer Buffers call fzf#vim#buffers(<q-args>, ListedFileBuffers(), fzf#vim#with_preview({ 'placeholder': '{1}' }), <bang>0)
endif

" --- Plugin management ---
nnoremap <leader>pu :PlugUpdate<CR>
nnoremap <leader>pd :PlugUpgrade<CR>
nnoremap <leader>ps :PlugStatus<CR>
nnoremap <leader>pi :PlugInstall<CR>

" --- Search (anzu) ---
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
nnoremap <Esc> :noh<Bar>let @/=""<CR>

" --- Visual indentation ---
vnoremap < <gv
vnoremap > >gv

" --- Scrolling (centered) ---
nnoremap <C-U> <C-U>zz
nnoremap <C-D> <C-D>zz

" --- Window navigation (skips netrw) ---
nnoremap <silent> <C-h> :call SafeWincmd('h')<CR>
nnoremap <silent> <BS> :call SafeWincmd('h')<CR>
nnoremap <silent> <C-j> :call SafeWincmd('j')<CR>
nnoremap <silent> <C-k> :call SafeWincmd('k')<CR>
nnoremap <silent> <C-l> :call SafeWincmd('l')<CR>

" --- Window resize ---
nnoremap <C-Right> :vertical resize +10<CR>
nnoremap <C-Left> :vertical resize -10<CR>
nnoremap <C-Up> :resize +10<CR>
nnoremap <C-Down> :resize -10<CR>

" --- Window management ---
nnoremap <leader>wc :close<CR>
nnoremap <leader>ws :split<CR>
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>wm <C-w>_
nnoremap <leader>ww :wincmd w<CR>
nnoremap <leader>wW :wincmd W<CR>

" --- File explorer & search ---
nnoremap <leader>e :call NetrwToggle()<CR>
nnoremap <leader>/ :call FzfRg()<CR>
nnoremap <leader>ff :execute 'lcd ' . fnameescape(GitRoot()) <Bar> Files<CR>
nnoremap <leader>fp :History<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>? :History:<CR>

" --- Buffers ---
nnoremap <leader>bd :call SafeBdelete()<CR>
nnoremap H :call SafeBnext(-1)<CR>
nnoremap L :call SafeBnext(1)<CR>

" --- Terminal ---
if exists(':terminal') == 2
  nnoremap <leader>t :below terminal ++rows=10<CR>
endif

" --- Misc ---
nnoremap <Leader>ts :execute "normal! a" . strftime('[%b %d %H:%M:%S - BR]')<CR>
