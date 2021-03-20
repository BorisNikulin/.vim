""Based on https://github.com/amix/vimrc

set nocompatible			  " be iMproved, required
filetype off				  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'

" Load before powerline to dynamically load python3 instead of python2
" only 1 can be dynamically loaded
" powerline is probably loaded in by airline or airline themes
Plugin 'Valloric/YouCompleteMe'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'tpope/vim-fugitive' " git wrapper and needed by vim airline for git support

Plugin 'jalvesaq/Nvim-R'

Plugin 'plytophogy/vim-virtualenv'
Plugin 'PieterjanMontens/vim-pipenv'

Plugin 'chrisbra/csv.vim'

Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'easymotion/vim-easymotion'

Plugin 'scrooloose/nerdcommenter'

Plugin 'jiangmiao/auto-pairs'

Plugin 'lervag/vimtex'
Plugin 'KeitaNakamura/tex-conceal.vim'

Plugin 'aklt/plantuml-syntax'

Plugin 'edwinb/idris2-vim'

Plugin 'purescript-contrib/purescript-vim'
Plugin 'FrigoEU/psc-ide-vim'

" All of your Plugins must be added before the following line
call vundle#end()			 " required
filetype plugin indent on	 " required

" Brief help
" :PluginList		- lists configured plugins
" :PluginInstall	- installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean		- confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



let mapleader=" "
let g:mapleader=" "



" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#enabled = 1

" air-line set theme solarizied dark
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

set noshowmode "remove default insert status

" spaces are allowed after tabs, but not in between
" this algorithm works well with programming styles that use tabs for
" indentation and spaces for alignment
let g:airline#extensions#whitespace#mixed_indent_algo = 2

augroup rmarkdown
	au!
	au FileType rmd let b:airline_whitespace_checks = ['indent', 'trailing', 'long']
augroup END

set diffopt+=vertical
nmap <leader>gs :Gstatus<cr>:on<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gp :Gpush<cr>

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = ['~/school/*']
set completeopt-=preview "disable preview window for completions
let g:ycm_key_list_stop_completion = ['<C-e>']

let g:EclimCompletionMethod = 'omnifunc'

let R_assign=0	" disable _ = type' <-'

let b:csv_arrange_align='.*'
let g:csv_autocmd_arrange=1

" Setup some default ignores
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/](\.(git|hg|svn|gradle|stack-work)|\_site)$',
	\ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|swap)$',
	\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'ra'
" Shows hidden files
let g:ctrlp_show_hidden = 1

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>gb :CtrlPBuffer<cr>
nmap <leader>gr :CtrlPMRU<cr>
nmap <leader>gf :CtrlPCurWD<cr>
nmap <leader>gm :CtrlPMixed<cr>
nmap <leader>gl :CtrlPLine<cr>
nmap <leader>gc :CtrlPChange<cr>

" easymotion highlight colors
hi link EasyMotionTarget SpecialChar
hi link EasyMotionTarget2First SpecialChar
hi link EasyMotionTarget2Second SpecialChar
hi link EasyMotionShade Comment

" auto pairs
let g:AutoPairs = {'{':'}'}

" set .tex to tex (latex) not plaintex
let g:tex_flavor = 'latex'

"set conceallevel=2
"let g:tex_conceal="abdgm"

let g:vimtex_view_method = 'zathura'
"let g:vimtex_view_general_viewer = 'okular'
"let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
"let g:vimtex_view_general_options_latexmk = '--unique'

" Enable YouCompleteMe with VimTex
if !exists('g:ycm_semantic_triggers')
	let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

let $JAVA_TOOL_OPTIONS = '-javaagent:/home/main/.vim/lombok.jar -Xbootclasspath/a:/home/main/.vim/lombok.jar'

noremap <leader>f :YcmCompleter FixIt<CR>
noremap <leader>o :YcmCompleter OrganizeImports<CR>
noremap <leader>d :YcmCompleter GetDoc<CR>
noremap <leader>e :YcmDiag<CR>
noremap <leader>E :YcmShowDetailedDiagnostics<CR>

augroup spellcheck
	autocmd!
	autocmd FileType gitcommit setlocal spell
	autocmd FileType tex setlocal spell
	autocmd FileType markdown setlocal spell
	autocmd FileType rmarkdown setlocal spell
augroup END

augroup cabal
	autocmd FileType cabal setlocal expandtab
augroup END

set timeoutlen=100
set ttimeoutlen=100

set history=256

"Reload with external changes
set autoread



"Fast save
nmap <leader>w :w!<cr>

":W - sudo save
"(nice for permision denied)
command W w !sudo tee % > /dev/null


" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
	set wildignore+=.git\*,.hg\*,.svn\*
else
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif


"Always show current position
set ruler

" Height of the command bar
"set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" Enable syntax highlighting
syntax enable

let g:markdown_fenced_languages = [
		\ 'vim',
		\  'css',
		\  'erb=eruby',
		\  'go',
		\  'java',
		\  'javascript',
		\  'js=javascript',
		\  'json=javascript',
		\  'ruby',
		\  'sass',
		\  'sql',
		\  'xml',
		\  'cpp',
		\  'python',
		\  'bash=sh',
		\  'cmake',
		\  'html'
		\]

set number

set showcmd

set background=dark
colorscheme solarized
" remove underline on line number
hi CursorLineNr term=bold cterm=bold ctermfg=012 gui=bold

set list
hi SpecialKey ctermbg=None ctermfg=5
hi SpellBad cterm=underline

set listchars=tab:\▏\ ,trail:●,extends:►

"augroup haskell
	"au!
	"au BufEnter *	 :set listchars=tab:\ \ ,trail:●,extends:►
	"au BufEnter *.hs :set listchars=tab:\▏\ ,trail:●,extends:►
"augroup END


"enable mouse support
set mouse=a

" Set extra options when running in GUI mode
if has("gui_running")
	set guioptions-=T
	set guioptions-=e
	set t_Co=256
	set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac



set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent



"Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Open new splits at the bottom and right
set splitbelow
set splitright

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>] :tabn<cr>
map <leader>[ :tabp<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
	set switchbuf=useopen,usetab,newtab
	set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif



" needs to be 2 for the airline statusline
set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" show cursor line only in active window
augroup CursorLine
	au!
	au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
	au WinLeave * setlocal nocursorline
augroup END



" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] (alt doesnt work)
"nmap <M-k> mz:m-2<cr>`z
"nmap <M-j> mz:m+<cr>`z
""vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
"vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	silent! %s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfun

if has("autocmd")
	autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif



" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=
map <leader>sc 1z=

" Change last typo to first suggestion
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u



" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>



" Returns true if paste mode is enabled
function! HasPaste()
	if &paste
		return 'PASTE MODE	'
	endif
	return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")

	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif

	if bufnr("%") == l:currentBufNum
		new
	endif

	if buflisted(l:currentBufNum)
		execute("bdelete! ".l:currentBufNum)
	endif
endfunction



" directory specific settings
augroup local-features
	au!
	au BufRead */local-features* set expandtab
augroup END
