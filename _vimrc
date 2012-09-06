
" =============================================================
" => General
" =============================================================

let mapleader=","
let g:mapleader=","

set nocompatible

set autoread
set history=400
colorscheme desert					" Theme
filetype plugin on
filetype indent on

" Editing related
set number
set tabstop=4
set noexpandtab						" ��ʹ�ÿո�
set softtabstop=4
set shiftwidth=4
set cursorline
set showmatch
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
set mouse=a
set selectmode=
set mousemodel=popup
set keymodel=
set selection=inclusive
set smartindent						" �Զ�����
set cindent							" C��ʽ������

" Display related
set ru
set sm
set hls
set incsearch
set nowrapscan
set hlsearch
syntax on

" statusline
set laststatus=2
set statusline=%f%m%r%h\ %w\ CWD:\ %{getcwd()}%h\ \ INFO:\ %{&ff}/%{&fenc!=''?&fenc:&enc}\ \ LINE:\ %l/%L:%c

" �����۵�
set foldenable
set foldmethod=indent
set foldlevel=100
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR>

"------------------------------
" Platform Dependent Settings
"------------------------------

" OS Function
function! MyOS()
	if has("win32")
        return "windows"
    else
        let os=substitute(system('uname'), '\n', '', '')
        if os == 'Darwin' || os == 'Mac' || os == 'FreeBSD'
            return "bsd"
        else
            return "unix"
        endif
    endif
endfunction

" VIM Tools Settings
if MyOS() == "windows"
	let $VIMBINFILES = $VIM.'\vimfiles\bin\'
	let $CMD_CTAGS	= $VIMBINFILES.'ctags.exe'
	let $CMD_GREP	= $VIMBINFILES.'grep.exe'
	let $CMD_FGREP	= $VIMBINFILES.'fgrep.exe'
	let $CMD_EGREP	= $VIMBINFILES.'egrep.exe'
	let $CMD_AGREP	= $VIMBINFILES.'grep.exe'
	let $CMD_FIND	= $VIMBINFILES.'find.exe'
elseif MyOS() == "unix"
	let $CMD_CTAGS	= 'ctags'
	let $CMD_GREP	= 'grep'
	let $CMD_FGREP	= 'fgrep'
	let $CMD_EGREP	= 'egrep'
	let $CMD_AGREP	= 'grep'
	let $CMD_FIND	= 'find'
else
	let $CMD_CTAGS	= '/usr/local/bin/ctags'
	let $CMD_GREP	= 'grep'
	let $CMD_FGREP	= 'fgrep'
	let $CMD_EGREP	= 'egrep'
	let $CMD_AGREP	= 'grep'
	let $CMD_FIND	= 'find'
endif

"------------------------------
" File Formats And Encodings
"------------------------------

" Formats relate
set ffs=unix,dos,mac
nmap <leader>fd :se ff=dos<CR>
nmap <leader>fu :se ff=unix<CR>
nmap <leader>fm :se ff=mac<CR>

" Encoding relate
set encoding=utf-8					" vim�ڲ�����
set termencoding=utf-8				" �ն��Լ�ϵͳ����
set fileencoding=utf-8				" Ĭ���ļ�����utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
if MyOS() == "windows"
	set langmenu=zh_CN.UTF-8
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim	
	language message zh_CN.UTF-8
endif

" ��Ҫʹ�÷�UTF-8�򿪵���Ŀ
autocmd BufNewFile,BufRead */server/*.{c,h,cpp,py},*/server/*Makefile* set fileencoding=cp936
autocmd BufNewFile,BufRead */libevlite.git/*.{c,h,cpp},*/libevlite.git/*Makefile* set fileencoding=cp936

"------------------------------
" GUI Settings
"------------------------------

if has("gui_running")
    set guioptions-=m	" ���ز˵���
    set guioptions-=T	" ���ع�����
    set guioptions-=L	" ������������
    set guioptions-=r	" �����Ҳ������
    set guioptions-=b	" ���صײ�������
	"set showtabline=2
	"set noantialias	" Mac Anti-Alias
	set nowrap	
	if MyOS() == "windows"
		set guifont=Lucida\ Sans\ Typewriter:h11
	else
		set guifont=andale\ mono:h14
		"set guifont=menlo:h14
	endif
	let psc_style='cool'
else
	set wrap
endif

"------------------------------
" Global Keymap Settings
"------------------------------

" Paste to Command Mode
cmap	<C-p>	<C-r>"
" Save Tags
map		<F5>	:execute '!'.$CMD_CTAGS." -R --c++-kinds=+p --fields=+iaS --extra=+q" <CR>
" Explore Buffers
nmap	<Tab>	:buffers <CR>
" Shutdown HighLight
nmap <leader>c	:nohls <CR>

" ============================================================================
" => Plugins Settings
" ============================================================================

" Tag List
let Tlist_Ctags_Cmd = $CMD_CTAGS
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1

" Mini Buffer Explorer
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplMapWindowNavArrows = 1

" Window Manager
let g:defaultExplorer = 0
let g:winManagerWidth = 40
let g:winManagerWindowLayout='FileExplorer|TagList'
map <silent> <F8> :WMToggle<CR> 

" Grep
let Grep_Find_Use_Xargs = 0
let Grep_Path = $CMD_GREP
let Fgrep_Path = $CMD_FGREP
let Egrep_Path = $CMD_EGREP
let Agrep_Path = $CMD_AGREP
let Grep_Find_Path = $CMD_FIND
let Grep_Skip_Dirs = '.svn .git'
nnoremap <silent> <leader>f : Grep<CR>
nnoremap <silent> <leader>F : Rgrep<CR>
nmap <leader>cw :cw<CR>
nmap <leader>cc :cclose<CR> 

" Omni
let OmniCpp_DefaultNamespaces = ["std"]
let OmniCpp_GlobalScopeSearch = 1 " 0 or 1
let OmniCpp_NamespaceSearch = 1 " 0 , 1 or 2
let OmniCpp_DisplayMode = 1 
let OmniCpp_ShowScopeInAbbr = 0
let OmniCpp_ShowPrototypeInAbbr = 1 
let OmniCpp_ShowAccess = 0
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1 
set completeopt=menuone,menu,longest

" fencview
let g:fencview_autodetec = 1

" ============================================================================
" Functions
" ============================================================================

