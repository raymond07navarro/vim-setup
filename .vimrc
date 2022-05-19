
"Load Pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on

"After pathogen are loaded
set nocompatible
let mapleader=" "
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
" set ts=2
color desert
set number" Display the line numbers
set showcmd
set showmode
set backspace=indent,eol,start

set incsearch   " Highlight matches as you type
set hlsearch    " Highlight matches
set wrap        " Turn on line wrapping
set scrolloff=3 " Show 3 lines around the corner
set title       " Set the terminal title
set visualbell  " No beeping
set nobackup    " Don't make a backup before overwriting a file set "and again
set laststatus=2                  " Show the status line all the time

"" Set encoding
set encoding=utf-8
" useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\%l,%c-%v\ %)%P

map :f :find<space>

"Remap Esc with jj
imap jj <Esc>
" Add Save with ss
 map ss :w<cr>
 " Map exit
 map qq :q <cr>
 " Map the source to leader so
 map <leader>so :so %<cr>
 " Map suspend
 map <leader>z <C-Z>
 " Tab mappings.
 map <leader>tt :tabnew<cr>
 map <leader>te :tabedit
 map <leader>tc :tabclose<cr>
 map <leader>to :tabonly<cr>
 map <leader>tn :tabnext<cr>
 map <leader>tp :tabprevious<cr>
 map <leader>tf :tabfirst<cr>
 map <leader>tl :tablast<cr>
 map <leader>tm :tabmov

 set mouse=ia "  Enable your track pad interaction
 set clipboard=unnamedplus
 vnoremap <C-c> "*y
 set antialias " Macvim: smooth fonts
 "set listchars=tab:▸\
 " Command-T mappings for rails
 map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
 map <leader>gj :CommandTFlush<cr>\|:CommandT app/assets/javascripts<cr>
 map <leader>gs :CommandTFlush<cr>\|:CommandT app/assets/stylesheets<cr>
 map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
 map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
 map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
 map <leader>gt :CommandTFlush<cr>\|:CommandT spec<cr>
 map <leader>gf :CommandTFlush<cr>\|:CommandT features<cr>
 map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
 map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
 map <leader>gr :vsplit config/routes.rb<cr>
 map <leader>gg :vsplit Gemfile<cr>
 map <leader>gl :left :vsplit config/locales/en.yml<cr>
 map <leader>ge :CommandTFlush<cr>\|:CommandT config<cr>

 " Map Node commands
 map <leader>ev :CommandTFlush<cr>\|:CommandT app/views<cr>
 map <leader>ej :CommandTFlush<cr>\|:CommandT public/js<cr>
 map <leader>es :CommandTFlush<cr>\|:CommandT public/css<cr>

 " Map windows
 map <leader>mv :vsplit <cr>
 map <leader>ms :split <cr>
 map <leader>wh <C-W>h <cr>
 map <leader>wj <C-W>j <cr>
 map <leader>wk <C-W>k <cr>
 map <leader>wl <C-W>l <cr>


 " Open files with <leader>f
 map <leader>f :CommandTFlush<cr>\|:CommandT<cr>

 " Mappings to access buffers (don't use "\p" because a
 " " delay before pressing "p" would accidentally paste).
 " " \l       : list buffers
 " " \b \f \g : go back/forward/last-used
 " " \1 \2 \3 : go to buffer 1/2/3 etc
 nnoremap <Leader>l :ls<CR>
 nnoremap <Leader>bf :bp<CR>
 nnoremap <Leader>bn :bn<CR>
 nnoremap <Leader>g :e#<CR>
 nnoremap <Leader>1 :1b<CR>
 nnoremap <Leader>2 :2b<CR>
 nnoremap <Leader>3 :3b<CR>
 nnoremap <Leader>4 :4b<CR>
 nnoremap <Leader>5 :5b<CR>
 nnoremap <Leader>6 :6b<CR>
 nnoremap <Leader>7 :7b<CR>
 nnoremap <Leader>8 :8b<CR>
 nnoremap <Leader>9 :9b<CR>
 nnoremap <Leader>0 :10b<CR>

 " " Opens an edit command with the path of the currently edited file filled
 " in
 " " Normal mode: <Leader>e
 map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
 map <Leader>w :w <C-R>=expand("%:p:h") . "/" <CR>

 " Make it easy to navigate on insert mode
 imap <C-k> <Up>
 imap <C-j> <Down>
 imap <C-h> <Left>
 imap <C-l> <Right>

 " Folding
 set foldmethod=indent
 set foldnestmax=10
 set nofoldenable
 set foldlevel=0

 " Navigate splis
 nmap <tab> <c-w>w

 " I want my NERDTree to be updated
 map <leader>n :CommandTFlush<cr>\|:NERDTreeToggle<cr>

 " " Test helpers from Gary Bernhardt's screen cast:
 " " https://www.destroyallsoftware.com/screencasts/catalog/file-navigation-in-vim
 " " https://www.destroyallsoftware.com/file-navigation-in-vim.htmlfunction!
 function! RunTests(filename)
   "Write the file and run tests for the given filename
   :w    :silent
   !echo;echo;echo;echo;echo
   exec ":!time spring rspec " . a:filenameendfunctionfunction!
 endfunction

 function! SetTestFile()
   " Set the spec file that tests will be run for.
   let t:grb_test_file=@%
 endfunction

 function! RunTestFile(...)
   if a:0
     let command_suffix = a:1
   else
     let command_suffix = ""
   endif

   " Run the tests for the previously-marked file.
   let in_spec_file = match(expand("%"), '_spec.rb$') != -1
   if in_spec_file
     call SetTestFile()
   elseif !exists("t:grb_test_file")
     return
   end
   call RunTests(t:grb_test_file . command_suffix)
 endfunction

 function! RunNearestTest()
   let spec_line_number = line('.')
   call RunTestFile(":" . spec_line_number)
 endfunction

 " Run this file
 map <leader>rr :call RunTestFile()<cr>
 " Run only the example under the cursor
 map <leader>rl :call RunNearestTest()<cr>
 " Run all test files
 map <leader>ra :call RunTests('spec')<cr>

 "@Vic Test scripts
 " Run Rspec in current file
 " function! RSpecRunLineWithSpring()
 "   execute("!clear && spring rspec " . expand("%p")) . ":" . line(".") . " -c"
 " endfunction

 " function! RSpecRunFileWithSpring()
 "   execute("!clear && spring rspec " . expand("%p")) . " -c"
 " endfunction

 " " Run cucumber in current file
 " function! CucumberRunLineWithSpring()
 "   execute("!clear && spring cucumber " . expand("%p")) . ":" . line(".") .
 " --format=doc"
 " endfunction

 " map <Leader>rl :call RSpecRunLineWithSpring()<cr>
 " map <Leader>rr :call RSpecRunFileWithSpring()<cr>
 " map <Leader>cl :call CucumberRunLineWithSpring()<cr>

 set listchars=tab:▸\ ,eol:˫,extends:❯,precedes:❮
 " TRAILING WHITESPACES MUST DIE
 autocmd BufWritePre * :%s/\s\+$//e

 augroup vimrcEX
   autocmd!
   autocmd FileType text setlocal textwidth=78
   "Jump to last cursor position
   autocmd BufReadPost *
         \ if line("'\"") > 0  && line("'\"") <= line ("$") |
         \   exe "normal g'\"" |
         \ endif
 augroup END
 "Clear the search buffer when hitting return
 :nnoremap <CR> :nohlsearch<cr>

 "Indent begining of line, else do completion
 function! InsertTabWrapper()
   let col = col('.') - 1
   if !col || getline('.')[col - 1] !~ '\k'
     return "\<tab>"
   else
     return "\<c-p>"
   endif
 endfunction
 inoremap <tab> <c-r>=InsertTabWrapper()<cr>
 inoremap <s-tab> <c-n>

 "Rename file
 function! RenameFile()
   let old_name = expand('%')
   let new_name = input('New file name: ', expand('%'))
   if new_name != '' && new_name != old_name
     exec ':saveas ' . new_name
     exec ':silent !rm ' . old_name
     redraw!
   endif
 endfunction
 map <leader>j :call RenameFile()<cr>

 "Promote to Rspec Let
 function! PromoteToLet()
   :normal! dd
   :normal! P
   :.s/\(\w\+\) = \(.*\)$/let!(:\1) { \2 }/
   :normal ==
 endfunction
 :command! PromoteToLet :call PromoteToLet()
 map <leader>p :PromoteToLet<cr> }

 set runtimepath^=~/.vim/bundle/ctrlp.vim
