" __  ____   __ __     _____ __  __ ____   ____ 
"|  \/  \ \ / / \ \   / /_ _|  \/  |  _ \ / ___|AA
"| |\/| |\ V /   \ \ / / | || |\/| | |_) | |    
"| |  | | | |     \ V /  | || |  | |  _ <| |___ 
"|_|  |_| |_|      \_/  |___|_|  |_|_| \_\\____|
"                                               


" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/bundle/Vundle.vim'))
	silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
	autocmd VimEnter PluginInstall --sync | source $MYVIMRC
endif

if empty(glob('~/.config/nvim/bundle/wildfire.vim/autoload/wildfire.vim'))
	autocmd VimEnter PluginInstall --sync | source $MYVIMRC
endif

"==============================    一、基础设置    ==============================
syntax on          " 打开代码高亮:
set number         " 打开行号显示:
set relativenumber " 仅显示当前行数，其余显示距当前行的距离
set cursorline     " 在当前行下显示一条线:
set wrap           " 让字不会超出当前窗口，自动到下一行:
set showcmd        " 让底下的一栏显示当前打出的字母：
set wildmenu       " 在命令模式时自动代码补全：
set hlsearch       " 设置搜索高亮：
" 每次打开一个文件，不会高亮之前的显示结果:
exec "nohlsearch"    
set incsearch        " 设置边输入边高亮：
set ignorecase       " 搜索时忽略大小写:
" 开启智能大小写搜索，搜:vimRC能搜到vimRC，但搜不到VIMRC,但搜索vimrc，都可以搜到
set smartcase
" 按F2进入粘贴模式==‘：set paste’ `set unpaste`
set pastetoggle=<F2>
" 允许vim使用鼠标
set mouse=a
set encoding=UTF-8
let &t_ut=''
"设置tab的缩进长度
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
" 永远保证光标在的位置距离屏幕最上和最下方都有5行：
set scrolloff=5
set tw=0
set indentexpr=
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
" 让vim在命令模式和写入模式时的光标不一样：
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set laststatus=2
set autochdir
" 新打开vim时，光标处于上次退出时的位置，有用!
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" 开关拼写检查：
" map <LEADER>sc :set spell!<CR>

" press space twice to jump to the next '<++>' and edit it, 有什么用啊
"map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" 调用figlet，生成艺术字
map tx :r !figlet
"==============================  二、键位映射  ==============================
" vim下有个leader键，默认是反斜杠，就好像是win键，但是vim下空格键用处不大，所以可以将leader键设置为空格键。
let mapleader=" "
" 使用jj进入normal模式,减少esc键的使用频率
inoremap jj <Esc>`^ 
"noremap 用于建立键盘映射
noremap J 5j
noremap K 5k
" 把n和N换成=和-，zz表示该行居中，所以按下=的意思就是查找下一个并居中
noremap = nzz
noremap - Nzz
"将leader键加回车键改为取消搜索高亮:
noremap <LEADER><CR> :nohlsearch<CR>
" 每次按下R就可以刷新令文件生效了
map S :w!<CR>
map s :<nop>
map Q :q<CR>
map R :source $MYVIMRC<CR>

"-----------------------------  2.1 窗口管理  ---------------------------------
" 分屏操作：向右、向上分屏: sj，sk，并把光标直接移动到刚分的屏上。
map sj :set splitright<CR>:vsplit<CR>
map sk :set splitbelow<CR>:split<CR>
" insert模式中，使用ctrl+h/j/k/l/移动光标到左/下/上/右窗口
"inoremap <C-h> <Left>
"inoremap <C-j> <DOwn>
"inoremap <C-k> <Up>
"inoremap <C-l> <Right>
"inoremap <C-d> <DElETE>
" normal模式中，使用 leader+h/j/k/l移动到左/下/上/右窗口
map <LEADER>l <C-w>l
map <LEADER>k <C-w>k
map <LEADER>h <C-w>h
map <LEADER>j <C-w>j
" 上下分屏和左右分屏互相切换
map sv <C-w>t<C-w>H
map sh <C-w>t<C-w>K
" 窗口大小调整
map <up> :res -5<CR>
map <down> :res +5<CR>
map <left> :vertical resize +5<CR>
map <right> :vertical resize -5<CR>
" 新建一个标签页
map tu :tabe<CR>
" 新建一个标签页，并把光标移到右边的标签页上
map tj :+tabnext<CR>
" 新建一个标签页，并把光标移到左边的标签页上
map tk :-tabnext<CR>

"==============================  三、插件安装  ==============================
"------------------------------  3.1 Vundle Plug  ------------------------------
" Use: PluginInstall
" Plugin store in dir: ~/.vim/bundle
set nocompatible
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-airline/vim-airline'
Plugin 'mhinz/vim-startify'
Plugin 'preservim/nerdtree'
Plugin 'lervag/vimtex'
Plugin 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
Plugin 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'morhetz/gruvbox'
Plugin 'ryanoasis/vim-devicons'
" Plugin 'yggdroot/indentline'
Plugin 'mg979/vim-visual-multi', {'branch': 'master'}
"Plugin 'SirVer/ultisnips'   " Track the engine.
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'hdima/python-syntax'
Plugin 'nathanaelkane/vim-indent-guides'
" Markdown
Plugin 'instant-markdown/vim-instant-markdown'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'dkarter/bullets.vim'
Plugin 'rlue/vim-barbaric'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-commentary'
" Plugin 'preservim/nerdcommenter'
Plugin 'junegunn/goyo.vim'
" Plugin 'junegunn/limelight.vim'
Plugin 'mbbill/undotree'
Plugin 'liuchengxu/vista.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'vim-autoformat/vim-autoformat'
Plugin 'kevinhwang91/rnvimr'
Plugin 'airblade/vim-gitgutter'
Plugin 'jiangmiao/auto-pairs'

call vundle#end()
filetype plugin indent on

"------------------------------  3.2 vim-plug  ------------------------------
"call plug#begin('~/.vim/plugged')
"Plug 'scrooloose/nerdtree'
"call plug#end()

"==============================  四、插件配置  ==============================
"------------------------------  vimtex config  ------------------------------
" ===
" === vimtex config
" === 
let g:tex_flavor = 'latex'
""是否开启自动报错，值为0代表不出现自动报错，可以手动:copen来查看错误
"let g:vimtex_quickfix_mode = 0

" ===
" === skim pdf config
" === 这样配置后，我们就可以通过 vimtex 默认的 \lv 快捷键（在按住 \ 的时候，连续点击 l 和 v）来正向同步当前 Neovim 光标位置到 PDF 预览位置，也可以通过「Ctrl + 点击 PDF 预览相应位置」来反向同步 Neovim 光标位置了
let g:vimtex_view_general_viewer
\ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

" This adds a callback hook that updates Skim after compilation
let g:vimtex_compiler_callback_hooks = ['UpdateSkim']

let g:vimtex_compiler_progname='nvr'

" 设置反向搜索时需要定位到nvim中打开的tex窗口
function! SetServerName()
  if has('win32')
    let nvim_server_file = $TEMP . "/curnvimserver.txt"
  else
    let nvim_server_file = "/tmp/curnvimserver.txt"
  endif
  let cmd = printf("echo %s > %s", v:servername, nvim_server_file)
  call system(cmd)
endfunction

augroup vimtex_common
    autocmd!
    autocmd FileType tex call SetServerName()
augroup END

" 使用命令:VimtexTocToggle 即可唤出vimtex自动生成的TOC
let g:vimtex_toc_config = {
\ 'name' : 'TOC',
\ 'layers' : ['content', 'todo', 'include'],
\ 'split_width' : 25,
\ 'todo_sorted' : 0,
\ 'show_help' : 1,
\ 'show_numbers' : 1,
\}

"------------------------------  coc.vim config  ------------------------------
" ===
" === coc.vim
" ===
let g:coc_global_extensions = [
	\ 'coc-json',
	\ 'coc-diagnostic',
	\ 'coc-vimlsp',
	\ 'coc-jedi',
  \ 'coc-syntax',
  \ 'coc-snippets',
  \ 'coc-translator',
  \ 'coc-actions' ]
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" 使tab管用
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" ctrl+l激活补全
inoremap <silent><expr> <c-l> coc#refresh()
" 使用leader+h显示当前函数的文档
function! Show_documentation()
	call CocActionAsync('highlight')
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
" 与窗口切换的快捷键重了
" nnoremap <LEADER>h :call Show_documentation()<CR>
" 简化输入命令的方式
nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<cr>
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nnoremap <c-c> :CocCommand<CR>
" Text Objects
xmap kf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap kf <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap kc <Plug>(coc-classobj-i)
omap kc <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
" nmap tt :CocCommand explorer<CR>
" coc-translator
nmap ts <Plug>(coc-translator-p)
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>aw  <Plug>(coc-codeaction-selected)w
" coctodolist
" nnoremap <leader>tn :CocCommand todolist.create<CR>
" nnoremap <leader>tl :CocList todolist<CR>
" nnoremap <leader>tu :CocCommand todolist.download<CR>:CocCommand todolist.upload<CR>
" coc-tasks
noremap <silent> <leader>ts :CocList tasks<CR>
" coc-snippets
imap <C-u> <Plug>(coc-snippets-expand)
imap <C-e> <Plug>(coc-snippets-expand-jump)
vmap <C-j> <Plug>(coc-snippets-select)
" 选择预先设计的空位进行编辑
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
let g:snips_author = 'TinTingo'
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc

"------------------------------  Ultisnips  ------------------------------
" ===
" === Ultisnips
" ===
"let g:tex_flavor = "latex"
"inoremap <c-n> <nop>
"let g:UltiSnipsExpandTrigger="<c-j>"
"let g:UltiSnipsJumpForwardTrigger="<c-j>"
"let g:UltiSnipsJumpBackwardTrigger="<c-k>"
"let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips/']
"silent! au BufEnter,BufRead,BufNewFile * silent! unmap <c-r>
"" Solve extreme insert-mode lag on macOS (by disabling autotrigger)
"augroup ultisnips_no_auto_expansion
"    au!
"    au VimEnter * au! UltiSnips_AutoTrigger
" augroup END

" ===
" === python-syntax
" ===
let g:python_highlight_all = 1

" ===
" === vim-indent-guides
" ===
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 1
silent! unmap <LEADER>ig
autocmd WinEnter * silent! unmap <LEADER>ig


" ===
" === Goyo and limelight
" === 
map <LEADER>gy :Goyo<CR>

" ===
" === Undotree
" ===
let g:undotree_DiffAutoOpen = 0
map L :UndotreeToggle<CR>

" ===
" === ale
" ===
let b:ale_linters = ['flake8','pylint']
let b:ale_fixers = ['autopep8', 'yapf']

" ===
" === nerdtree
" === 
" open a nerdtree
nnoremap <leader>v :NERDTreeFind<cr> 
nnoremap <leader>g :NERDTreeToggle<cr>
" 令nerdtree显示隐藏文件
let NERDTreeShowHidden=1
"忽略这些文件
let NERDTreeIgnore = [
            \ '\.git$', '\.hg$', '\.svn$', '\.stversions$', '\.pyc$', '\.pyo$', '\.svn$', '\.swp$',
            \ '\.DS_Stores$', '\.sass-cache$', '__pycache__$', '\.egg-info$', '\.ropeprojects$',
            \ ]

" ===
" === easymotion
" === 
" 寻找2个字符
nmap ss <Plug>(easymotion-s2)
nmap s <Plug>(easymotion-s)
map <Leader> <Plug>(easymotion-prefix)
" ===
" === python-mode
" === 
let g:pymode_python = 'python3'
" 保存文件的时候删除无用的空白符
let g:pymode_trim_whitespaces = 1
let g:pymode_doc=1
let g:pymode_doc_bind = 'k'
let g:pymode_rope_goto_definition_bind = "<C-]>"
" 开启静态检查
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pylint']
let g:pymode_options_max_line_length = 120

" ===
" === Vista.vim
" ===
noremap <LEADER>i :Vista!!<CR>
noremap <c-t> :silent! Vista finder coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
" function! NearestMethodOrFunction() abort
" 	return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
" set statusline+=%{NearestMethodOrFunction()}
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:scrollstatus_size = 15

" ===
" === vim-easy-align
" === 按某一字符多行对齐
" 一般是可视模式下选中多行，按ga*=就可以按=对齐
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ===
" === vim-autoformat
" ===
noremap tf :Autoformat<CR>
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
" to disable autoindent for filetypes that have incompetent indent files, use
autocmd FileType vim,tex let b:autoformat_autoindent=0

" ===
" === rnvimr
" === 同时打开nerdtree和rnvimr时会有bug
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_draw_border = 0
" let g:rnvimr_bw_enable = 1
highlight link RnvimrNormal CursorLine
nnoremap <silent> <LEADER>r :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': &columns,
            \ 'height': &lines,
            \ 'col': 0,
            \ 'row': 0,
            \ 'style': 'minimal' }
let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]

" ===
" === vim.GitGutter
" ===
" let g:gitgutter_signs = 0
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
" autocmd BufWritePost * GitGutter
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>

"==============================  六、主题配置  ==============================
" 需要把主题配置的命令放在vundle等插件管理器初始化的后面才能保证一进入vim就可以有颜色，如果放在前面的话，进入vim后需要shift+r刷新一下才能有颜色。
syntax enable
" === solarized主题配色
" ===
" ===
"set background=dark
"colorscheme solarized

" === gruvbox主题配色
" ===
" ===
"set background=dark
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_contrast_light='hard'
autocmd vimenter * ++nested colorscheme gruvbox
nnoremap <Leader>bd :set background=dark<CR>
nnoremap <Leader>bl :set background=light<CR>

" TODO: 为何vundle插件自动下载的插件存放在.vim下？ <17-07-21, TinTingo> "
