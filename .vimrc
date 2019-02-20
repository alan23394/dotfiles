" General settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader='\'			" setting a leader key for custom key shortcuts
let maplocalleader=','		" setting a local leader key for filetype plugins

filetype plugin indent on	" filetype plugins and indentation
syntax enable				" syntax highlighting

set number					" line numbering
set scrolloff=6				" space around the cursor when scrolling
set colorcolumn=80			" a big column at column 80
" set cursorline				" highlight the line with the cursor
set noruler					" disables the ruler, so <C-g> has useful info

set backspace=indent,eol,start	" more useful backspace behavior

set nojoinspaces			" why the hell would I want two spaces

set modeline				" interpret modelines in files
set modelines=1				" look at only one line at the top and bottom

set lazyredraw				" stop Vim from redrawing during macros

set splitbelow splitright	" sensible split directions

set hidden					" allow buffers to exist if they aren't visible

set wildmenu				" menu for tabbing
set wildmode=longest,full	" don't automatically complete a match
set wildignore=*.o,*.swp	" files to ignore with the wildmenu

" Nice searching
set ignorecase				" ignore case while searching a file,
set smartcase				" unless capital letters are used in the pattern.
set incsearch				" move the cursor to the first match while typing
set hlsearch				" highlight all search matches
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" Programming settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent				" keep same indent level on new lines
set smartindent				" smart indentation for C things

set showmatch				" briefly snap cursor to matching bracket
set matchtime=3				" quicker matching time

set tabstop=4				" tabs are size 4
set shiftwidth=4			" move lines by 4 when using >> and <<
set shiftround				" snap to width of 4 when using indent (>> and <<)
set noexpandtab				" don't turn tabs into spaces

set grepprg=grep\ -nH\ $*	" grep alias to show line number and filename

set formatoptions-=o		" don't allow repeat comment leaders with o/O
							" just A<CR> if you need a new comment leader
							" for real this saves more trouble than it causes

" Good commenting behavior for norm-style C comments (TODO autocommand)
"set comments=s:/*,mb:**,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" Statusbar settings {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2			" use statusbar on all windows

" from help/options.txt:
" When displaying a flag, Vim removes the leading comma, if any, when
" that flag comes right after plaintext.  This will make a nice display
" when flags are used like in the examples below.
" When all items in a group becomes an empty string (i.e. flags that are
" not set) and a minwid is not set for the group, the whole group will
" become empty.  This will make a group like the following disappear
" completely from the statusline when none of the flags are set. >
" 	:set statusline=...%(\ [%M%R%H]%)...

" Filename block
set statusline=%0*			" filename color (also focused color)
set statusline+=\ 			" space separator
set statusline+=%.30f		" show relative path to file, wrapped at 30 chars
set statusline+=\ 			" space separator
set statusline+=%(\|\ %r\ %)	" group with readonly flag and spaces

" Filetype block
set statusline+=%#st_filet#	" filetype color
set statusline+=%(\ %y\ %)	" group with filetype and spaces

" Modified block
set statusline+=%#st_modif#	" modified color
set statusline+=%(\ %m\ %)	" group with modified flag and spaces

" Middle block
set statusline+=%#st_norm#	" middle color
set statusline+=%=			" separator (jump to other side of screen)

" Ascii block
set statusline+=%#st_ascii#	" ascii color
set statusline+=\ 			" space separator
set statusline+=%3b,		" ascii value of cursor char in decimal
set statusline+=\ 			" space separator
set statusline+=%-2B		" ascii value of cursor char in hexadecimal
set statusline+=\ 			" space separator

" Ruler block
set statusline+=%#st_ruler#	" ruler color
set statusline+=\ 			" space separator
set statusline+=%2v,
set statusline+=\ 			" space separator
set statusline+=%-2l		" line number, total lines in file
set statusline+=\ 			" space separator

" Position block
set statusline+=%0*			" percentage (also focused color)
set statusline+=\ 			" space separator
set statusline+=%2L
set statusline+=\ \|\ 		" space-bar-space separator
set statusline+=%P			" percentage of file (top, bot, all, or percent)
set statusline+=\ 			" space separator
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" Highlight groups / Colors {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark			" forcing my terminal to have light colors

" Highlight group for extra spaces
highlight ExtraWhitespace ctermbg=yellow
" Highlight group for characters past column 80
highlight OverLength ctermbg=red ctermfg=none cterm=bold

" picking a color scheme
if $TERM == "linux"
	colorscheme eight_color
else
	colorscheme dark_green
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" Latex stuff {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" some defaults for using vim as a latex editor, requires a plugin iirc
" I don't use these anymore but I keep them around in case I want to later
let g:Tex_Flavor = "latex"
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='mupdf'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" Autocommands {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" make template files appear as cpp files
augroup cpp_template
	autocmd!
	autocmd BufNewFile,BufReadPost *.template set filetype=cpp
augroup END

" open the matching .c file if I try to open a .o file (TODO make a function)
" Maybe a little interactive "Did you mean __? (y/n)"
augroup ignore_object_file
	autocmd!
	autocmd BufRead *.o edit <afile>:r.c
augroup END

" autocommands for c file highlighting files (TODO filetype plugin)
" autocmd BufEnter,BufNew FileType c let ew_match = matchadd('ExtraWhitespace', '\s\+$\| \+\ze\t\|\t\zs \+')
" autocmd BufEnter,BufNew FileType c let ol_match = matchadd('OverLength', '\%81v.\+')
"autocmd BufLeave FileType c call matchdelete(ew_match);
"autocmd BufLeave FileType c call matchdelete(ol_match);
augroup c_matches
	autocmd!
	autocmd FileType c autocmd BufEnter <buffer> match OverLength /\%81v.\+/
	autocmd FileType c autocmd BufLeave <buffer> match
	autocmd FileType c autocmd BufEnter <buffer> 2match ExtraWhitespace /\s\+$/
	autocmd FileType c autocmd InsertEnter <buffer> 2match ExtraWhitespace /\s\+\%#\@<!$/
	autocmd FileType c autocmd InsertLeave <buffer> 2match ExtraWhitespace /\s\+$/
	autocmd FileType c autocmd BufLeave <buffer> 2match
augroup END

" some stupid test
"augroup ExtraWhitespace_so
"	autocmd! * <buffer>
"	autocmd BufEnter	<buffer> match ExtraWhitespace /\s\+$/
"	autocmd InsertEnter <buffer> match ExtraWhitespace /\s\+\%#\@<!$/
"	autocmd InsertLeave <buffer> match ExtraWhitespace /\s\+$/
"augroup END

augroup filetype_helpers
	autocmd!
	" better norm comments for c files
	autocmd Filetype c setlocal comments=s:/*,mb:**,ex:*/,://
	" fold comments in c files
	autocmd Filetype c setlocal foldmethod=marker foldmarker=/*,*/
	" turn off automatic folding on Makefiles
	autocmd Filetype make setlocal foldmethod=manual
	" vim commenting
	autocmd Filetype vim nnoremap <buffer> <LocalLeader>c I" <Esc>
	autocmd Filetype vim nnoremap <buffer> <LocalLeader>C ^2x<Esc>
	" bash commenting
	autocmd Filetype sh nnoremap <buffer> <LocalLeader>c I# <Esc>
	autocmd Filetype sh nnoremap <buffer> <LocalLeader>C ^2x<Esc>
augroup END

" Terminal settings to remove numbers
augroup terminal_settings
	autocmd!
	autocmd TermOpen * setlocal nonumber norelativenumber
	" TODO terminal statusline differences
    "autocmd TermOpen * setlocal statusline=%{b:term_title}
augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" Insert mode remaps {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lovely esc shortcuts
inoremap jk <Esc>
inoremap <Leader><Leader> <Esc>

" uppercase last word
inoremap <C-u> <Esc>gUiwea

" auto-brackets shortcut for programming (TODO filetype plugin)
inoremap {} {<CR>}<Esc>O

" auto comment shortcut
inoremap <Leader>sc /*<Enter>/<Esc>O

" delete comment leader
inoremap <C-c> <C-u>

" switch to last buffer
inoremap <Leader>bl <Esc>:b #<CR>

" jump to tag
inoremap <Leader><Space> <Esc>/<++><CR>:noh<CR>cf>

" Function shortcuts
inoremap <Leader>fps ft_putstr(
inoremap <Leader>fpe ft_putendl(
inoremap <Leader>fpc ft_putchar(
inoremap <Leader>fpcn ft_putchar('\n');
inoremap <Leader>fpn ft_putnbr(
inoremap <Leader>fpr ft_printf("%\n", <++>);<C-o>F\
iabbr fpr ft_printf("%\n", <++>);<C-o>F\
inoremap <Leader>pr printf("%\n", <++>);<C-o>F\

" Changing windows
inoremap <A-h> <Esc><C-w>h
inoremap <A-j> <Esc><C-w>j
inoremap <A-k> <Esc><C-w>k
inoremap <A-l> <Esc><C-w>l
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" Normal mode remaps {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" toggle numbers
nnoremap <Leader>n :set number!<CR>
" toggle relative numbers
nnoremap <Leader>r :set relativenumber!<CR>

" move line up
nnoremap + ddkP
" move line down
nnoremap - ddp

" insert empty line below
nnoremap <Leader>o o<Esc>
" insert empty line above
nnoremap <Leader>O O<Esc>

" disables last highlight
nnoremap <CR> :noh<CR>

" highlights last visual selection
nnoremap vv `<v`>
nnoremap vV `<V`>
nnoremap vb `<<C-v>`>

" highlight a commented block
nnoremap <Leader>hc <Esc>$?\/\*<CR>V/\*\/<CR>
" highlight a function
nnoremap <Leader>hf [[kv][

" toggles fold
nnoremap <Space> za
" changes foldmethod to marker, and foldmarker to {{{,}}}
nnoremap <Leader>f{ :set foldmethod=marker foldmarker={{{,}}}<CR>
" like above, but uses /*,*/
nnoremap <Leader>f/ :set foldmethod=marker foldmarker=/*,*/<CR>
" sets foldmethod to manual
nnoremap <Leader>fm :set foldmethod=manual<CR>

" Commenting shortcuts (TODO move to filetype plugins)
nnoremap <Leader>c I//<Esc>
nnoremap <Leader>C ^2x
nnoremap <Leader>sC $?\/\*<CR>dd/\*\/<CR>dd2<C-o>:noh<CR>

" good for quickly putting a breakpoint-style printing statement
nnoremap <Leader>wt owrite(1,"t",1);<Esc>

" surround current line with {}
nnoremap <Leader>s{ O{<Esc>jo}<Esc>k==
" delete {} around line (really just deletes above and below lines
nnoremap <Leader>d{ kddjddk

" opens my notes file/folder in a small split for quick notes
nnoremap <Leader>sn :12sp ~/notes<CR>

" sources current file
nnoremap <Leader>so :source %<CR>
" sources vimrc
nnoremap <Leader>sv :source ~/.vimrc<CR>
" edits vimrc
nnoremap <Leader>ev :edit ~/.vimrc<CR>
" edits bashrc
nnoremap <Leader>eb :edit ~/.bashrc<CR>

" opens a manpage
nnoremap <Leader>m <Esc>:Man

" Edit a file in the home directory
nnoremap <Leader>eh <Esc>:edit ~/

" switches to last buffer
nnoremap <Leader>bl :buffer #<CR>
" switches to first terminal buffer
nnoremap <Leader>bt :buffer term<Tab><CR>
" deletes buffer and switches to last buffer
nnoremap <Leader>bd :buffer #<CR>:bdelete #<CR>

" Cursor modes {{{
"""""""""""""""""""""""""""""""""""""""""""""
" Snap cursor to center
nnoremap <Leader>zc :set scrolloff=99<CR>:set scrolloff=6<CR>
" Lock cursor to center
nnoremap <Leader>zz zz:set scrolloff=99<CR>
" Return cursor to normal
nnoremap <Leader>zn :set scrolloff=6<CR>
" Turn off scrolloffset
nnoremap <Leader>zo :set scrolloff=0<CR>
""""""""""""""""""""""""""""""""""""""""""}}}
" Scrolling modes {{{
"""""""""""""""""""""""""""""""""""""""""""""
" scroll up a line without moving the cursor
nnoremap <A-e> <C-e>j
nnoremap <A-y> <C-y>k

" Line moving maps for different modes (TODO function)
" nnoremap j <C-e>j
" nnoremap k <C-y>k
nnoremap <C-j> j
nnoremap <C-k> k

" scroll up a line
nnoremap <Ins> <C-y>
" scroll down a line
nnoremap <Del> <C-e>
""""""""""""""""""""""""""""""""""""""""""}}}
" Window navigation {{{
"""""""""""""""""""""""""""""""""""""""""""""
" Changing windows
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" Fullscreen window
nnoremap <C-w>f <C-w>_<C-w><bar>
" Tab naviaation
nnoremap <A-S-h> gT
nnoremap <A-S-l> gt
""""""""""""""""""""""""""""""""""""""""""}}}

" Terminal opening shortcuts
nnoremap <Leader>tt :tabe term://bash<CR>a
nnoremap <Leader>tv :vs term://bash<CR>a
nnoremap <Leader>ts :sp term://bash<CR>a
nnoremap <Leader>tb :term<CR>a
nnoremap <Leader>td :buffer #<CR>:bdelete! #<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" Visual mode remaps {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" esc shortcut
vnoremap <Leader><Leader> <Esc>

" wrap a selection with a Norm c comment
vnoremap <Leader>sn <Esc>'<<C-v>'><S-i>** <Esc>ko/*<Esc>'>o/<Esc>
" remove the Norm comment in a selection
vnoremap <Leader>sN <Esc>'<<C-v>'>lld'<dd'>dd

" wrap a selection with normal c comments
vnoremap <Leader>sc <Esc>'>o*/<Esc>'<O/*<Esc>
" remove the comments in a selection
vnoremap <Leader>sC <Esc>'<dd'>dd

" insert comments at the start of each line in a visual selection
vnoremap <Leader>cc <Esc>'<<C-v>'><S-i>// <Esc>
" remove the comment in a selection
vnoremap <Leader>cC <Esc>'<<C-v>'>lld

" surround selection with brackets, and indent it properly
vnoremap <Leader>s{ <Esc>'<O{<Esc>'>o}<Esc>='<

" surround a selection with parenthesis
vnoremap <Leader>s( <Esc>`>a)<Esc>`<i(<Esc>
" surround a selection with double quotes
vnoremap <Leader>s" <Esc>`>a"<Esc>`<i"<Esc>
" remove surrounding characters (not highlighted)
vnoremap <Leader>ds <Esc>`>lx<Esc>`<hx<Esc>

" highlight function
vnoremap <Leader>f [[ko][
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" Command mode remaps {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quickly kill a line
cnoremap <Leader><Leader> <C-c>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" Terminal remaps {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nice esc shortcut, jk is inconvenient for scrolling and <c-\><c-n> sucks
tnoremap <Leader><Leader> <C-\><C-n>

" Window navigation
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
" Tab naviaation
tnoremap <A-S-h> <C-\><C-N>gT
tnoremap <A-S-l> <C-\><C-N>gt

" Shortcut for man
tnoremap <Leader>m <C-\><C-N>:Man

" Edit a file in the home directory
tnoremap <Leader>eh <C-\><C-N>:edit ~/

" Buffer navigation
tnoremap <Leader>bl <C-\><C-N>:b #<CR>

" Command shortcuts! How fun!
tnoremap <A-s> <C-\><C-n>:call VisualMapper(g:commander)<cr>

" Function for the terminal shortcuts. snagged from /u/idobai on reddit
function! VisualMapper(commands, ...)
	let common_prefix = "" | let key_count = 1
	if a:0 > 0 | let common_prefix = a:1 | endif
	if a:0 > 1 | let key_count = a:2 | endif
	let key_and_cmd = {}
	for [key_and_name, cmd] in a:commands
		echo key_and_name
		let key_and_cmd[split(key_and_name, "\\s\\+>")[0]] = cmd
	endfor
	echo "> "
	let KeyReader = {-> nr2char(getchar())}
	call feedkeys(common_prefix . key_and_cmd[join(map(range(key_count), KeyReader), '')])
endfunction

 let g:commander = [
 \  ["n > Start NetworkManager",	"isudo systemctl start NetworkManager\n"],
 \  ["N > Stop NetworkManager",		"isudo systemctl stop NetworkManager\n"],
 \  ["c > List Connections",		"inmcli -p c show --active\n"],
 \  ["D > List Disks",				"isudo fdisk -l\n"],
 \  ["g > Grep",					"igrep -r --color --exclude-dir=\".git\" \""],
 \  ["i > Grep Including ",			"igrep -r --color --exclude-dir=\".git\" --include=\"*."],
 \  ["h > Show processes (htop)",	"ihtop -u $USER\n"],
 \  ["p > Show processes (ps)",		"ips ux\n"],
 \  ["q > Cancel",					"i"]]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" Things I need to look into still {{{
"	statusline:
"		preview marker
"		buffer number
"	reading:
"		object-motions
"		local-options
"		setlocal
"		map-local
"		autocmd
"			events
"		syntax on vs syntax enable
"		verbose
"		syntax
"		default highlights
"		arglist
"		modeline
"		sandbox
"		preview window
"		highlight
"		last-position-jump
"	read the defaults
"	read the index
"		window commands
"		square bracket commands
"		g commands
"	alterate leader possibilities
"		- is nice
"		, is useful, but it's functionality can be moved
"		<CR> would be nice
"		<Space> seems like it would be weird
"	colorscheme
"		t_Co
"		good 8 color scheme
"	preview window
"	path
"	quickfix
"	marks
"	jump list
"	tabline
"	fillchars
"	listchars
"	making a filetype plugin for normal text files
"		set textwidth=79 (last column text looks gross)
"	making a filetype plugin for c files
"		setting comments
"			comment wrapping with textwidth, and not source code
"			comment auto-formatting with fo+=a
"			set textwidth=79 (last column text looks gross)
"		setting highlight groups
"		maybe use syntax highlighting instead of matchadd to allow
"		buffer-specific highlighting
" }}}

" vim: foldmethod=marker foldmarker={{{,}}}
