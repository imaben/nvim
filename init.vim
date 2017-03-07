call plug#begin()
Plug '2072/PHP-Indenting-for-VIm'
"Plug 'phpvim/phpfold.vim'
Plug 'imaben/phpcd.vim'
Plug 'majutsushi/tagbar'
Plug 'hynek/vim-python-pep8-indent'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'lvht/fzf-mru'|Plug 'junegunn/fzf'

Plug 'bling/vim-airline'
Plug 'tomasr/molokai'
Plug 'cakebaker/scss-syntax.vim'
Plug 'evanmiller/nginx-vim-syntax'
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'wavded/vim-stylus'
Plug 'xsbeats/vim-blade'
Plug 'vim-scripts/progressbar-widget'

Plug 'Townk/vim-autoclose'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'rking/ag.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/DrawIt'
Plug 'vim-scripts/matchit.zip'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'rdnetto/YCM-Generator', {'branch':'stable'}
Plug 'vimwiki/vimwiki'
Plug 'junegunn/gv.vim'
Plug 'vim-scripts/vimgdb'
Plug 'wsdjeg/vim-chat'
Plug 'scrooloose/nerdcommenter'

" Golang {{{
Plug 'fatih/vim-go'
" }}}
call plug#end()

filetype plugin indent on
syntax on
color molokai
set colorcolumn=80
set cursorline
set linebreak
set fileformat=unix
set fileencodings=utf-8,gbk
set nospell
set noswapfile
set nobackup
set ignorecase " 搜索内容不区分大小写
set smartcase " 搜索内容中有大写字母时则区分大小写
set smartindent " 根据文件类型智能缩进
set pastetoggle=<leader>v " 切换粘贴模式快捷键
set mouse-=a
set nu

nnoremap <CR> :noh<CR><CR>

" 折行配置 {{{
func! ExpandTab(len)
	setlocal expandtab
	execute 'setlocal shiftwidth='.a:len
	execute 'setlocal softtabstop='.a:len
	execute 'setlocal tabstop='.a:len
endfunc
autocmd FileType html,css,scss,javascript call ExpandTab(2)
autocmd FileType php,python,json,nginx call ExpandTab(4)
autocmd FileType c,cpp,h call ExpandTab(4)

" vim 配置或者脚本文件使用特定标记进行折叠
autocmd FileType vim setlocal foldmethod=marker " }}}
" 将光标跳转到上次打开当前文件的位置 {{{
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
			\ execute "normal! g`\"" |
			\ endif " }}}
" 清理行尾空白字符，md 文件除外 {{{
autocmd BufWritePre * if &filetype != 'markdown' |
			\ :%s/\s\+$//e |
			\ endif " }}}

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" 插件配置 " {{{
" Tagbar
nnoremap <silent> <leader>t :TagbarToggle<CR>
let g:tagbar_compact = 1
let g:tagbar_sort = 0
"{{{
let g:tagbar_type_php = {
	\ 'ctagsbin'  : 'phpctags',
	\ 'ctagsargs' : '-f -',
	\ 'kinds'     : [
		\ 'd:Constants:0:0',
		\ 'v:Variables:0:0',
		\ 'f:Functions:1',
		\ 'i:Interfaces:0',
		\ 'c:Classes:0',
		\ 'p:Properties:0:0',
		\ 'm:Methods:1',
		\ 'n:Namespaces:0',
		\ 't:Traits:0',
	\ ],
	\ 'sro'        : '::',
	\ 'kind2scope' : {
		\ 'c' : 'class',
		\ 'm' : 'method',
		\ 'f' : 'function',
		\ 'i' : 'interface',
		\ 'n' : 'namespace',
		\ 't' : 'trait',
	\ },
	\ 'scope2kind' : {
		\ 'class'     : 'c',
		\ 'method'    : 'm',
		\ 'function'  : 'f',
		\ 'interface' : 'i',
		\ 'namespace' : 'n',
		\ 'trait'     : 't',
	\ }
\ }

" NERD Tree
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
nnoremap <silent> <leader>f :NERDTreeFind<CR>
" 所有编辑窗口关闭后自动关闭 NERDTree
autocmd bufenter * if (winnr("$") == 1 && &filetype == 'nerdtree') | q | endif

" vim-airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
" let g:airline_theme='luna'
hi Normal             ctermbg=NONE
hi Statement          ctermbg=NONE
hi Title              ctermbg=NONE
hi Todo               ctermbg=NONE
hi Underlined         ctermbg=NONE
hi ErrorMsg           ctermbg=NONE
hi LineNr             ctermbg=NONE

" PHPCD
autocmd CompleteDone * pclose " 补全完成后自动关闭预览窗口
autocmd FileType php setlocal omnifunc=phpcd#CompletePHP

" vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1

" set max lenght for the mru file list
let g:fzf_mru_file_list_size = 10 " default value
" set path pattens that should be ignored
let g:fzf_mru_ignore_patterns = 'fugitive\|\.git/\|\_^/tmp/' " default value
nnoremap <silent> <C-p> :FZF<CR>
nnoremap <silent> <C-u> :FZFMru<CR>
