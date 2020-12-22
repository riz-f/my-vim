"{{{━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━Configuration━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

" Since vim 8.0 defaults.vim will not be loaded if the vimrc file is found,
" though defaults.vim contains usefull stuff so include it despite
if v:version >= 800
	unlet! skip_defaults_vim
	source $VIMRUNTIME/defaults.vim
endif

" Do not add <EOL> at the end of file if it did not exist in the original file
set nofixeol

" When opening a new file the current buffer is not unloaded but it becomes hidden
" so you do not have to save changes of the current file every time you jump to a new file
set hidden

" Size of a bottom cmd
set cmdheight=2

" How often is a swap file written to a disk, also affects CursorHold
set updatetime=400

" Shows a line number
set number

" Highlights all matches while searching
set hlsearch

" Changes comments color
hi Comment ctermfg=DarkGray

" Show tab characters as symbols
set list
set listchars=tab:▶\ 
hi SpecialKey ctermfg=DarkCyan
" Designate when spaces are being typed after tabs by inserting at the place of
" the first space ║ symbol
set conceallevel=2
set concealcursor=nv
highlight Conceal ctermbg=White ctermfg=Gray
call matchadd('Conceal', '\t\zs ', 99, -1, {'conceal':'║'})
augroup show_space_after_tab
	autocmd!
	autocmd WinEnter * silent! call matchadd('Conceal', '\t\zs ', 99, 12222, {'conceal':'║'})
augroup END

" Highlights incorrect whitespaces, \s is an atom that correpsonds to
" a space or a tab. :h pattern-atoms
let MyFormatErrorBg=9
exe "highlight MyFormatError ctermbg=" . MyFormatErrorBg
" Spaces before tab
call matchadd('MyFormatError', ' \+\ze\t')
augroup hi_trailing_whitespaces
	autocmd!
	autocmd WinEnter * silent! call matchadd('MyFormatError', ' \+\ze\t', 10, 12223)
	" Trailing whitespaces but not in insert mode
	" call matchadd('MyFormatError', '\s\+$')
	autocmd InsertEnter * match MyFormatError /\s\+\%#\@200<!$/
	autocmd InsertLeave * match MyFormatError /\s\+$/
	autocmd VimEnter,WinEnter * match MyFormatError /\s\+$/
augroup END

if has("cscope")
	" Use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
	set cscopetag
	" Check cscope for definition of a symbol before checking ctags
	set csto=0
	" cscope.out location is used as a prefix to construct an absolute path
	set csre
	" Process all cscope/tags we have set from outter environmental variables
	if $CSCOPE_DB != ""
		let s:csdb_list = split($CSCOPE_DB, ':')
		for i in s:csdb_list
			exec "cs add " . i
		endfor
	endif
	if $CTAGS_DB != ""
		let s:ctdb_list = split($CTAGS_DB, ':')
		for i in s:ctdb_list
			exec "set tags+=" . i
		endfor
	endif
	set cscopeverbose
endif

" Always show the signcolumn, since plugins for a language support needs it
" for example to output diagnostics.
if has("patch-8.1.1564")
" Recently vim can merge signcolumn and number column into one
	set signcolumn=number
else
	set signcolumn=yes
endif

" Vimscript file specific folding
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
set foldlevel=99

if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
	set grepformat^=%f:%l:%c:%m
endif

let maplocalleader ="."

let windowmaximizecounter = 0

"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━}}}

"{{{━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━Plugin specific configuration━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

" Plugin: nerdtree
let NERDTreeShowHidden=1

" Plugin: ctrlp
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
\ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
" Do not limit file search on big projects
let g:ctrlp_max_files=0

" Plugin: coc.nvim
let g:coc_global_extensions = [
	\'coc-clangd',
	\'coc-json'
	\]

" Plugin: vim-localvimrc
let g:localvimrc_persistent=1

" Plugin: vim-projectroot
let g:rootmarkers = ['.projectroot', 'compile_commands.json', '.git']
function AutoProjectRootCD()
	try
		if &ft != 'help'
			ProjectRootCD
		endif
	catch
	" Silently ignore invalid buffers
	endtry
endfunction
augroup root_dir
	autocmd!
	autocmd BufEnter * call AutoProjectRootCD()
augroup END

"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━}}}


"{{{━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━Shortcuts━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

nnoremap H 0
vnoremap H 0
nnoremap L $
vnoremap L $
inoremap kj <esc>
nnoremap 0 <nop>
vnoremap 0 <nop>
nnoremap $ <nop>
vnoremap $ <nop>
inoremap <esc> <nop>
vnoremap <esc> <nop>

" Window maximize/restore
nnoremap <silent> <C-w>o :if windowmaximizecounter == 0<CR> :NERDTreeClose<CR> :mksession! ~/session.vim<CR> :wincmd o<CR> :let windowmaximizecounter = 1<CR> :else<CR> :echom "Maximized window already exists"<CR> :endif<CR>
nnoremap <silent> <C-w>u :if windowmaximizecounter == 1<CR> :source ~/session.vim<CR> :let windowmaximizecounter = 0<CR> :else<CR> :echom "Nothing to restore"<CR> :endif<CR>

let mapleader ="\<Space>"

nnoremap <leader>- :m-2<CR>
nnoremap <leader>+ :m+1<CR>
nnoremap <leader>n :set number!<CR>
nnoremap <leader>w :set wrap!<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>/ :noh<CR>

" Buffer shortcuts
" Move to the next buffer
nnoremap <leader>l :bnext<CR>
" Move to the previous buffer
nnoremap <leader>h :bprevious<CR>
" Close the current buffer and move to the previous one
nnoremap <leader>q :bd<CR>
" Show all opened buffers and their status
nnoremap <leader>bl :ls<CR>
" Switch a buffer by its number
nnoremap <leader>bs :buffers<CR>:buffer<Space>

" Tab shortcuts
" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
" Put window to new tab
noremap <leader>t :tab sp<cr>

" Cscope/ctags
" The following maps all invoke one of the following cscope search types:
"
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cursor calls
"   'S'   struct: find struct definition under cursor
" All of the maps involving the <cfile> macro use '^<cfile>$': this is so
" that searches over '#include <time.h>" return only references to
" 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
" files that contain 'time.h' as part of their name).
nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-\>S :cs find t struct <C-R>=expand("<cword>")<CR> {<CR>
" Using 'CTRL-spacebar' makes the vim window split vertically
nnoremap <C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@>S :vert scs find t struct <C-R>=expand("<cword>")<CR> {<CR>
" Using 'CTRL-spacebar-spacebar' makes the vim window split horizontal
nnoremap <C-@><C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@><C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@><C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@><C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@><C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@><C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-@><C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <C-@><C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-@><C-@>S :scs find t struct <C-R>=expand("<cword>")<CR> {<CR>
" find and add cscope/ctags DB related to the currently opened file, that is %:p
function! s:AddCscopeDB()
	let s:return_value = generic#FindFileUpwards(expand('%:p'), "cscope.out")
	if (!empty(s:return_value))
		execute "cs add " . s:return_value
	else
		echom "Cscope.out is not found"
	endif
endfunc
function! s:AddCtagsDB()
	let s:return_value = generic#FindFileUpwards(expand('%:p'), "tags")
	if (!empty(s:return_value))
		execute "set tags+=" . s:return_value
	else
		echom "Tags file is not found"
	endif
endfunc
nnoremap <leader>cs :call <SID>AddCscopeDB()<CR>
nnoremap <leader>ct :call <SID>AddCtagsDB()<CR>

" Cycle popup menu (e.g. completion menu) with Tab, confirm completion with Enter
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <leader>f :silent grep! <cword> \| copen<CR><C-l>

let mapleader =","

nnoremap <leader>t :set list!<CR>
nnoremap <leader>w :call generic#RevertHighlightBgGrp("MyFormatError", MyFormatErrorBg)<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR> :echom ".vimrc sourced"<CR>
nnoremap <leader>l :left<CR>
nnoremap <leader>f :call generic#Search()<CR>

"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━}}}


"{{{━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━Plugin specific shortcuts━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

let mapleader ="\<Space>"

" Plugin: nerdtree
" Open file explorer
nnoremap <F1> :NERDTreeToggle<CR>
" Open current file in file explorer
noremap <leader>r :NERDTreeFind<cr>

" Plugin: tagbar
" Structure of source file
nnoremap <F2> :TagbarToggle<CR>

let mapleader =","

" Plugin: coc.nvim
nnoremap <silent><nowait> <leader>so :<C-u>CocList -I symbols<cr>
nnoremap <leader>r :CocRestart<CR>

"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━}}}

