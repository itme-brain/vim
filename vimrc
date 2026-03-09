let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
  \| endif

call plug#begin('~/.vim/plugged')
  Plug 'chriskempson/base16-vim'
  Plug 'tpope/vim-surround'
  Plug 'jiangmiao/auto-pairs'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
  Plug 'junegunn/fzf.vim'
  Plug 'mtdl9/vim-log-highlighting'
  Plug 'machakann/vim-highlightedyank'
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'mhinz/vim-signify'
  Plug 'osyo-manga/vim-anzu'
call plug#end()

let mapleader = "\<Space>"
set background=dark
silent! colorscheme base16-onedark

highlight Normal  ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight CursorLine ctermbg=NONE guibg=NONE
highlight CursorLineNr ctermfg=Yellow guifg=#FFCC66 ctermbg=NONE guibg=NONE cterm=bold
highlight HighlightedyankRegion ctermfg=Black guifg=#FFFFFF ctermbg=Yellow guibg=#FFA500
highlight NormalNC ctermbg=NONE guibg=NONE
highlight Search ctermfg=Black guifg=#000000 ctermbg=Yellow guibg=#FFCC66
highlight LineNr ctermbg=NONE guibg=NONE
highlight Visual ctermbg=LightGray guibg=#E8E8E8 ctermfg=Black guifg=#000000

let g:highlightedyank_highlight_duration = 140
let g:lightline = { 'colorscheme': 'deus', }

let $FZF_DEFAULT_OPTS = '--bind=tab:up,shift-tab:down'
let g:fzf_layout = { 'window': 'enew' }

" netrw settings
let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1

autocmd FileType netrw nnoremap <buffer> <C-l> :wincmd l<CR>
autocmd FileType netrw nnoremap <buffer> <C-h> :wincmd h<CR>
autocmd FileType netrw nnoremap <buffer> <C-j> :wincmd j<CR>
autocmd FileType netrw nnoremap <buffer> <C-k> :wincmd k<CR>

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
set undofile
set undodir=~/.vim/undodir

set hidden

set tabstop=2
set shiftwidth=2
set expandtab

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
  Lexplore
endfunction

function! SafeWincmd(dir)
  let target = winnr(a:dir)
  if target == winnr()
    return
  endif
  if getbufvar(winbufnr(target), '&filetype') ==# 'netrw'
    return
  endif
  execute 'wincmd ' . a:dir
endfunction

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
nnoremap <Esc> :noh<CR>

" --- Visual indentation ---
vnoremap < <gv
vnoremap > >gv

" --- Scrolling (centered) ---
nnoremap <C-U> <C-U>zz
nnoremap <C-D> <C-D>zz

" --- Window navigation (matches nvim <C-h/j/k/l>, skips netrw) ---
nnoremap <C-h> :call SafeWincmd('h')<CR>
nnoremap <C-j> :call SafeWincmd('j')<CR>
nnoremap <C-k> :call SafeWincmd('k')<CR>
nnoremap <C-l> :call SafeWincmd('l')<CR>

" --- Window resize (matches nvim <C-Arrow>) ---
nnoremap <C-Right> :vertical resize +10<CR>
nnoremap <C-Left> :vertical resize -10<CR>
nnoremap <C-Up> :resize +10<CR>
nnoremap <C-Down> :resize -10<CR>

" --- Window management ---
nnoremap <leader>wh :split<CR>
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>wd :q<CR>
nnoremap <leader>ww :wincmd w<CR>
nnoremap <leader>wW :wincmd W<CR>

" --- Git (fugitive) ---
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>gl :Git log<CR>
nnoremap <leader>ga :Git add<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>gb :Git blame<CR>

" --- File explorer & search ---
nnoremap <leader>e :call NetrwToggle()<CR>
nnoremap <leader>/ :Rg<Space>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fp :History<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>? :History:<CR>

" --- Buffers ---
nnoremap <leader>bd :bd!<CR>
nnoremap H :bprevious<CR>
nnoremap L :bnext<CR>

" --- Terminal ---
nnoremap <leader>t :below terminal ++rows=10<CR>

" --- Misc ---
nnoremap <Leader>ts :execute "normal! a" . strftime('[%b %d %H:%M:%S - BR]')<CR>
