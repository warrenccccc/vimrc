"自己配置的vim"

"常用设置"
"禁用Vi,启用Vim的增强功能"
set nocompatible

"启动语法高亮"
syntax on

"高亮搜索,配合/和？搜索"
set hlsearch

"启用增量搜索,实时更新并显示匹配的第一个结果，而不必等到整个搜索模式输入完成"
set incsearch

"显示行号"
set number

"光标位置,编辑器窗口的右下角显示光标的位置（行号和列号）"
set ruler

"在新行自动应用前一行的缩进"
set autoindent

"智能缩进，根据代码结构比如{}自动调整缩进"
set smartindent

"insert模式下F2进入粘贴模式，再按F2退出粘贴模式"
set pastetoggle=<F2>

"设置折叠方式,za切换折叠状态，zo打开光标所在处的折叠,zR打开当前文件中的所有折叠"
set foldmethod=indent

"历史记录"
set history=1000

"将制表符转换为空格,按下Tab键时会插入空格而不是实际的制表符"
set expandtab

"自动补全"
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap < <><Esc>i
inoremap " ""<Esc>i

"vim映射，首先定义leader键为,"
"insert模式下,w等同于 ESC + :w + enter"
"normal模式下,w等同于 ESC + :w + enter"
"insert模式下jj等同于ESC"
"ctrl h j k l 上下左右切换窗口"
let mapleader=','
noremap <leader>w <ESC>:w<cr>
inoremap <leader>w <Esc>:w<cr>
inoremap jj <Esc>'^
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l

"自定义一个命令FormatJSON，用于格式化JSON数据"
com! FormatJSOw  N %!python3 -m json.tool

"不需要sudo vim打开文件，然后保存文件"
"cnoremap表示在命令行模式下映射按键"
":w!! 用于保存文件"
"sudo 来保存文件，% 代表当前文件名，tee 命令会将输出写入文件"
cnoremap w!! w !sudo tee % >/dev/null

"初始化插件管理器"
"目录树插件"
call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Yggdroot/indentLine'

Plug 'preservim/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'brooth/far.vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'majutsushi/tagbar'
Plug 'lfv89/vim-interestingwords'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
"结束插件管理器"
call plug#end()

" 启用 Dracula 颜色主题
colorscheme dracula

"目录树快捷键"
",v 找到搜索文件在整个目录树的位置"
",g 显示或者隐藏目录树"
"let NERDTreeShowHiddne=1 显示隐藏文件"
"let NERDTreeIgnore忽略文件"
nnoremap <leader>v :NERDTreeFind<cr>
nnoremap <leader>g :NERDTreeToggle<cr>
let NERDTreeShowHiddne=1
let NERDTreeIgnore = [
        \ '.git$', '\.hg$', '\.svn$', '\stversions$']
"VimEnter：这是事件类型，表示当 Vim 完全启动并且进入主编辑状态时触发"
"*：通配符，表示该命令在所有文件类型下都适用"
"NERDTree：这个命令打开 NERDTree 文件浏览器"
"|：把两个命令连在一起，意思是执行完 NERDTree 后再执行下一个命令"
"wincmd p：切换窗口，p 表示光标切换到上一个窗口。这意味着，Vim 启动时先打开 NERDTree，然后光标会切换回到主编辑窗口，而不是停留在 NERDTree 窗口中"
autocmd VimEnter * NERDTree | wincmd p

"文件内搜索代码 ss"
nmap ss <Plug>(easymotion-s2)

"python-mode"
"确保 Python-mode 在 Python 3 环境下工作"
"开启自动删除行末多余的空格功能"
"K查看当前光标所在位置的 Python 文档"
"Ctrl + [ 来跳转到 Python 中的函数、类或变量定义处"
"启用 Python-mode 的代码检查功能，用于代码静态分析"
"配置 Python-mode 使用 pyflakes、pep8、mccabe 和 pylint 来检查代码问题，包括语法错误、代码风格问题等"
"设置代码行的最大长度为 120 个字符。代码风格检查器会根据这个设置提示是否超过行长度限制"
let g:pymode_python = 'python3'
let g:pymode_trim_whitespaces = 1
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
let g:pymode_rope_goto_definition_bind = "<C-]>"
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['pyflakes','pep8','mccabe','pylint']
let g:pymode_options_max_line_length = 120


"tagbar设置"
",t等同于:TagbarToggle 回车"
nnoremap <leader>t :TagbarToggle<CR>
