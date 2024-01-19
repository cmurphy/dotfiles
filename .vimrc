" Prettify
set number
color evening
"color elflord

" Tabbing
"set ts=2
set ts=4
set autoindent
set expandtab

" Ignores
set wildignore+=*.class

" Whitespace indicators
set list listchars=tab:>·,trail:·

" Keyboard remapping
map <F1> <Esc>
imap <F1> <Esc>

" Preserve terminal background
hi Normal ctermbg=none

" Set line length for commit messages
au FileType gitcommit set tw=72

" Set line length for markdown/RST
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.rst setlocal textwidth=80

" Use tabs for go
au BufRead,BufNewFile *.go set noexpandtab
" Needed for vim-go
filetype plugin on

" Set E501 marker for python
au BufRead,BufNewFile *.py setlocal colorcolumn=80
hi ColorColumn ctermbg=LightGray

" Normal copy paste behavior
set mouse=r

" syntax highlighting
syntax on

" Underline function
function! s:Underline(chars)
  let chars = empty(a:chars) ? '-' : a:chars
  let nr_columns = virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)

" go to last position
au BufReadPost * if &ft != "gitcommit" && line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif
