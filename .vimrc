set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/vim-conf/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-ragtag'

" colorschemes
Bundle "tristen/superman.git"
Bundle 'altercation/vim-colors-solarized'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'scrooloose/nerdtree'
  let NERDTreeHijackNetrw = 0

  nmap gt :NERDTreeToggle<CR>
  nmap g :NERDTree \| NERDTreeToggle \| NERDTreeFind<CR>

Bundle 'othree/html5.vim'

Bundle "git://github.com/vim-ruby/vim-ruby.git"
Bundle "git://github.com/ervandew/supertab.git"
Bundle "git://github.com/tomtom/tcomment_vim.git"
Bundle "git://github.com/tsaleh/vim-matchit.git"
  " CtrlP - with FuzzyFinder compatible keymaps
  Bundle "git://github.com/kien/ctrlp.vim.git"
    nnoremap <Leader>b :<C-U>CtrlPBuffer<CR>
    nnoremap <Leader>t :<C-U>CtrlP<CR>
    nnoremap <Leader>T :<C-U>CtrlPTag<CR>
    let g:ctrlp_prompt_mappings = {
        \ 'PrtSelectMove("j")':   ['<down>'],
        \ 'PrtSelectMove("k")':   ['<up>'],
        \ 'AcceptSelection("h")': ['<c-j>'],
        \ 'AcceptSelection("v")': ['<c-k>', '<RightMouse>'],
        \ }
    " respect the .gitignore
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']


" rails.vim, nuff' said
  Bundle "git://github.com/tpope/vim-rails.git"
    map <Leader>oc :Rcontroller<Space>
    map <Leader>ov :Rview<Space>
    map <Leader>om :Rmodel<Space>
    map <Leader>oh :Rhelper<Space>
    map <Leader>oj :Rjavascript<Space>
    map <Leader>os :Rstylesheet<Space>
    map <Leader>oi :Rintegration<Space>

" Powerline
  Bundle "Lokaltog/powerline.git"
    set rtp+=~/vim-conf/.vim/bundle/powerline/powerline/bindings/vim/
    " call vam#ActivateAddons(['powerline'])
    " let g:Powerline_symbols = 'fancy'

" AutoClose
  Bundle "Townk/vim-autoclose.git"
    let g:AutoCloseExpandEnterOn="{"

" Indent Guides
  Bundle "nathanaelkane/vim-indent-guides.git"

" CoffeeScript
  Bundle "kchmck/vim-coffee-script"
  autocmd BufNewFile,BufRead *.eco set filetype=eco

" Easymotion
  Bundle "https://github.com/Lokaltog/vim-easymotion"

" JS
  Bundle "maksimr/vim-jsbeautify"
  Bundle "walm/jshint.vim.git"

" Syntastic
  Bundle "scrooloose/syntastic.git"
  let g:syntastic_quiet_warnings=0

"" TODO "" SPLIT THIS UP INTO SPERATE FILES DUDE!
"" GENERAL CONFIG

    syntax enable

    if has('gui_macvim') && has('gui_running')
      colorscheme superman
      set guifont=Inconsolata\ for\ Powerline:h14
      " use gui tabs
      set guioptions+=e

      " kill the menubar
      set guioptions-=T

      " kill the scrollbars
      set guioptions-=r
      set guioptions-=L
    else
      colorscheme superman
      set mouse=a   " Mouse support
      set t_Co=256
    endif


    filetype plugin indent on     " required!

  " don't wrap long lines
    set nowrap

  " show commands as we type them
    set showcmd

  " highlight matching brackets
    set showmatch

  " scroll the window when we get near the edge
    set scrolloff=4 sidescrolloff=10

  " use 2 spaces for tabs
    set expandtab tabstop=2 softtabstop=2 shiftwidth=2
    set smarttab

  " enable line numbers, and don't make them any wider than necessary
    set number numberwidth=2

  " show the first match as search strings are typed
    set incsearch

  " highlight the search matches
    set hlsearch

  " searching is case insensitive when all lowercase
    set ignorecase smartcase

  " assume the /g flag on substitutions to replace all matches in a line
    set gdefault

  " set temporary directory (don't litter local dir with swp/tmp files)
    set directory=/tmp/

  " pick up external file modifications
    set autoread

  " don't abandon buffers when unloading
    set hidden

  " match indentation of previous line
    set autoindent

  " perform autoindenting based on filetype plugin
    filetype plugin indent on

  " don't blink the cursor
    set guicursor=a:blinkon0

  " show current line info (current/total)
    set ruler rulerformat=%=%l/%L

  " show status line
    set laststatus=2

  " augment status line
    function! ETry(function, ...)
      if exists('*'.a:function)
        return call(a:function, a:000)
      else
        return ''
      endif
    endfunction
    set statusline=[%n]\ %<%.99f\ %h%w%m%r%{ETry('CapsLockStatusline')}%y%{ETry('rails#statusline')}%{ETry('fugitive#statusline')}%#ErrorMsg#%*%=%-16(\ %l,%c-%v\ %)%P

  " When lines are cropped at the screen bottom, show as much as possible
    set display=lastline

  " flip the default split directions to sane ones
    set splitright
    set splitbelow

  " don't beep for errors
    set visualbell

  " make backspace work in insert mode
    set backspace=indent,eol,start

  " highlight trailing whitespace
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
    set list

  " have the mouse enabled all the time
    set mouse=a

  " use tab-complete to see a list of possiblities when entering commands
    set wildmenu
    set wildmode=list:longest,full

  " allow lots of tabs
    set tabpagemax=20

  " remember last position in file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

  " Thorfile, Rakefile, Vagrantfile, and Gemfile are Ruby
    au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

  " JSON is JS
    au BufNewFile,BufRead *.json set ai filetype=javascript

  " different color for each paren pairs
  let vimclojure#ParenRainbow  = 1

"" FUNCTIONS
" via: http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()


"" KEYMAPS
" get out of insert mode with cmd-i
  imap <D-i> <Esc>
" clean up trailing whitespace
  map <Leader>c :StripTrailingWhitespaces<cr>
" mapping the jumping between splits. Hold control while using vim nav.
  nmap <C-J> <C-W>j
  nmap <C-K> <C-W>k
  nmap <C-H> <C-W>h
  nmap <C-L> <C-W>l

