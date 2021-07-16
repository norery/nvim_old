# 从头配置最好用的 neovim 编辑器
几年前学习 Linux 的时候接触到了 vim 编辑器，当时给我的感觉就是怎么会有这么难用这么反人类的文本编辑器，连退出都要输入 `:wq` 才能搞定。后来无意中在 b 站看了 [The CW](https://space.bilibili.com/13081489?spm_id_from=333.788.b_765f7570696e666f.2) 的 vim 视频，才打开了新世界的大门，并一步一步把 vim 配置成自己最顺手的编辑器，这里就是想要把自己的配置记录下来，以备日后查阅。

如今 neovim 也在不断地发展中，好用的插件也层出不穷，因此本篇配置也会随着我的日常使用不断更新，有时遇到好用的插件我也会加进来，推荐给大家。

需要特地说明的是，本人目前使用的是 macOS 系统，终端工具使用的是 iterm2，shell 用的是 zsh & oh-my-zsh。得益于 macOS 上出色的包管理工具：Homebrew，在安装很多程序时都很方便。linux 和 windows 用户可能需要自己另外查阅相关文档进行安装。

## 一些软件的安装与配置
### neovim 的安装与配置

mac 用户使用 Homebrew 安装 neovim：
```shell
brew install neovim
```

使用 `:checkhealth` 可以发现 neovim 默认没有对 python3 进行支持，安装 pynvim 以添加对 python3 的支持：

```shell
pip3 install --user --upgrade pynvim
```
在 `~/.zshrc` 中设置，用 vi 代替 nvim，以后在终端就可以直接输入 vi 打开文件了：
```vim
if type nvim > /dev/null 2>&1; then
  alias vi='nvim'
fi
```
neovim 的配置文件的默认目录为：`~/.config/nvim/init.vim`，vim 用户转移到 neovim 有以下几种方式：
1. `cp ~/.vimrc ~/.config/nvim.init.vim`
2. 在 init.vim 文件中添加：

    ```shell
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc
    ```
3. 使用软链接的方式，将 ~/.vimrc 直接链接到 ~/.config/nvim/init.vim
    
    ```shell
    ln -s ../.vim ~/.config/nvim
    ln -s ../.vimrc ~/.vim/init.vim
    ```
    
+ 如果只想用 neovim 而完全摒弃 vim 的话，可以选用第一种方式，以后安装插件也在 nvim 的目录下安装。这是我目前使用的一种方式。
+ 后两种方式相当于将 nvim 链接到 vim 的配置中，更新配置时直接更改 ~/.vimrc，这两种方式的话更推荐第二种，因为软链接的方式会导致 [一些问题](https://zhuanlan.zhihu.com/p/68401965) 的出现。

### ranger 的安装与配置
mac 用户安装 ranger：
 ```shell
 brew install ranger
 ```
 首先复制一份默认的配置文件到 ~/.config/ranger 中，然后自己再配置：

```shell
ranger --copy-config=all
```
这时 ranger 会告诉我们，如果要使用自己定义的 rc.conf 文件，就需要将环境变量 RANGER_LOAD_DEFAULT_RC 设置为 False：

```shell
to stop ranger from loading both the default and your custom rc.conf, please set the environment variable RANGER_LOAD_DEFAULT_RC to FALSE
```

根据使用的 shell 不同，声明环境变量的方式也有不同：

+ 如果使用 fish shell，就在 `~/.config/fish/config.fish` 添加：

    ```shell
    set -g -x RANGER_LOAD_DEFAULT_RC  FALSE`
    ```

+ 如果用的是 zsh，则在 `~/.zshrc` 中添加：
```shell
export RANGER_LOAD_DEFAULT_RC=FALSE
```

> 生成的配置文件及功能：
> `commands.py` : 能通过 `:` 执行的命令。 可以在里面添加自己的命令，也可以从官方给出的函数 `https://github.com/ranger/ranger/wiki/Custom-Commands` 里摘取放到这里。
> `rc.conf` : 选项设置和快捷键
> `rifle.conf` : 指定不同类型的文件的默认打开程序。
> `scope.sh` : 预览脚本，怎么预览一个视频, pdf... 文件


#### devicons 插件 - 图标显示

为了使 ranger 能够显示图标，需要安装 nerdfont 字体，mac 用户可以使用：
```shell
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```
插件下载：
```shell
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
```
在 iterm2 的 Preference-Profiles-Text 中将 Non-ASCII 字体设置为下载的字体：Hack Nerd Font Mono
> 找不到大家说的 nerd-fonts-source-code-pro 字体？

![-w1011](media/16262480835026/16262734923911.jpg)
## vim 插件的安装与使用
### Vundle 插件管理器
[VundleVim/Vundle.vim](https://github.com/VundleVim/Vundle.vim) 是目前我正在使用的插件管理器，使用下来，我认为和 vim-plug 的使用体验相当，在插件安装目录和命令有所不同。

我的 Vundle 的文件存放位置为 `set rtp+=~/.config/bundle/Vundle.vim`，用户可以自行在.init.vim（.vimrc）中对此目录进行配置：
```vim
set nocompatible              " be iMproved, required
filetype off                  "required" 存放下载插件的目录
set rtp+=~/.config/bundle/Vundle.vim
call vundle#begin()  " 开始插件的下载
Plugin 'VundleVim/Vundle.vim'  " 首先需要下载 Vundle.vim 本体
Plugin 'tpope/vim-fugitive'   " 举个需要下载的插件的例子
call vundle#end()            " required
filetype plugin indent on    " required
```
安装插件时，只需要在相应位置添加：`Plugin 'gitOwnerName/PluginName`，然后保存并 Source，输入 `PluginInstall` 即可。

还有几个常用的命令：
+ PluginList：列出安装的 Plugins
+ PluginClean：删除不再使用的 Plugins
+ :h vundle：查看 vundle 手册

### vim 美化插件
首先介绍几个美化 vim 的插件，对于启动页、status/tabline 以及主题配色做了美化，增进使用和观看文档的体验。
#### vim-startify
[mhinz/vim-startify](https://github.com/mhinz/vim-startify) 是一个美化 vim 启动页的插件，会在首页增加一则名言警句，没什么好说的，开箱即用，加上就是了。
```vim
Plugin 'mhinz/vim-startify'
```
#### vim-ariline
[vim-airline/vim-airline](https://github.com/vim-airline/vim-airline) 给 vim 的状态栏和 tabline 做了美化，也是开箱即用无需做配置就很好看了。
```vim
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-airline/vim-airline'
```
#### vim-devicons
[ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons) 为一些 vim 插件添加了好看的图标支持，支持的插件有：NERDTree, vim-airline, CtrlP, powerline, denite, unite, lightline.vim, vim-startify, vimfiler, vim-buffet and flagship.

很明显，图标的支持需要首先安装 Nerd Fonts 字体。
```vim
Plugin 'ryanoasis/vim-devicons'
```
在 vim 配置中需要加入：
```vim
set encoding=UTF-8
```
#### gruvbox 主题配色
[morhetz/gruvbox](https://github.com/morhetz/gruvbox) 是我比较喜欢的一款 vim 配色，还有一款比较喜欢的配色方案是 [Solarized](https://github.com/altercation/vim-colors-solarized)。
```vim
Plugin 'morhetz/gruvbox'
```
![-w1430](media/16264047495637/16264110417861.jpg)
在 vim 中配置如下：
```vim
syntax enable
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_contrast_light='hard'
autocmd vimenter * ++nested colorscheme gruvbox
nnoremap <Leader>bd :set background=dark<CR>
```
默认使用 dark 配色，使用 `<LEADER>bl` 切换 light 配色，使用 `<LEADER>bd` 切换 dark 配色，但是在我的 mac 上 light 配色与作者展示的底色不同，我的配色黄的很离谱，所以基本只使用 dark 或者 light 的 hard 模式。
### vim 代码相关
#### 写 Latex 必备 -vimtex
[lervag/vimtex](https://github.com/lervag/vimtex) 是使用 vim 编写 Latex 的终极解决方案，配合 mac 的 pdf 阅读器 skim 以及 snippets 代码块可以实现 latex 的快速编写及编译。这一部分的配置及教程详见：如何在 vim 中优雅地书写 latex？
```vim
Plugin 'lervag/vimtex'
```
#### 代码补全神器 -coc.vim
首先安装：
```shell
brew install node
sudo npm i -g neovim yarn
```
安装 coc.nvim：
```vim
" For vim-plug users: use release branch(recommend)
Plug "neoclide/coc.nvim", {'branch':'release'}
"For vundle users
Plugin "neoclide/coc.nvim", {'branch':'release'}
```
在 `~/.vimrc` 中配置，安装 coc 扩展：
```vim
let g:coc_global_extensions = [
	\ 'coc-json',
	\ 'coc-diagnostic',
	\ 'coc-vimlsp',
	\ 'coc-jedi',
    \ 'coc-syntax',
    \ 'coc-snippets',
    \ 'coc-actions' ]
```
查看想用的语言应该用什么扩展：
> https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions

`coc-settings.json` 进行自定义配置，可以在 vim 中输入 `:CocConfig` 打开配置文件。
位于：`~/.config/nvim/coc-settings.json`

+ `Coclist extensions`：查看已安装的 coc 扩展
+ `CocUninstall coc-css`：卸载插件

#### snippets
可以使用 [Ultisnips](https://github.com/SirVer/ultisnips) 插件来获得 vim 中的 snips 支持，但是 coc 中也集成了很好用的 snips 插件：coc-snippets，结合 vim-snips 插件来获得各种语言的已有的 snips，可以获得很好的体验。

```vim
Plugin 'honza/vim-snippets'
```

在 ~/.config/nvim/coc-settings.json 中添加 snips 的路径：
```json
 "snippets.ultisnips.directories": [
    "$HOME/.config/nvim/Ultisnips/",
    "$HOME/.config/nvim/bundle/vim-snippets/UltiSnips/"
  ],
```
  
第一个是自己写的 snips 的路径，第二个是 vim-snippets 提供的 snips 的路径。
#### vim-indent-guides
[nathanaelkane/vim-indent-guides](https://github.com/nathanaelkane/vim-indent-guides) 为使用缩进实现代码功能的语言时，直观显示缩进的级别（半透明粗线）。
```vim
Plugin 'nathanaelkane/vim-indent-guides'
```
替代产品：`Plugin 'yggdroot/indentline'`

### 文本快速编辑
#### vim-surround
[tpope/vim-surround](https://github.com/tpope/vim-surround) 给我们提供了处理文本两端符号的快速操作方法。
```vim
Plugin 'tpope/vim-surround'
```
+ `ds`：delete a surrounding
    + `ds"`：删除两边的双引号
+ `cs`：change a surrounding
    + `cs"'`：将两边的双引号改为单引号
+ `ys`：add a surrounding
    + `ysiw"`：给当前单词加上双引号，单词与符号之间没有空格
  
#### wildfire.vim
[gcmt/wildfire.vim](https://github.com/gcmt/wildfire.vim) 是一款智能选择文本块的插件，可以使用 enter 快速选择被一定规则包裹的代码块，结合 vim-surround 可以实现文本块两端的快速操作，详见：[一个 Vim 插件不解决问题？那就两个！【Vim 插件推荐·第一期】](https://www.bilibili.com/video/BV1KT4y1c78p)。
```vim
Plugin 'gcmt/wildfire.vim'
```
#### vim-visual-multi
[mg979/vim-visual-multi](https://github.com/mg979/vim-visual-multi) 在 normal 模式下提供了类似 visual-block 的功能。
```vim
Plugin 'mg979/vim-visual-multi', {'branch': 'master'}
```

### 文件浏览及窗口管理
#### nerdtree
[preservim/nerdtree](https://github.com/preservim/nerdtree), 使用此插件，用户可以直观地浏览复杂的目录层次结构，快速打开文件进行读取或编辑，并执行基本的文件系统操作。自定义使用 `<Leader>v` 打开 nerdtree。
```vim
Plugin 'preservim/nerdtree'
```





