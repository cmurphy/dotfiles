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
