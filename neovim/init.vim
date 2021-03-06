" 文字コード
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
scriptencoding utf-8
set bomb
set binary

" Pythonのパス指定
let g:python_host_prog = $PYENV_ROOT . '/versions/py2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/py3/bin/python'

" Rubyのパス指定
let g:ruby_host_prog = $RBENV_ROOT . '/versions/2.7.4/bin/neovim-ruby-host'

" Nodeのパス指定
let g:node_host_prog = $NODENV_ROOT . '/versions/14.17.3/lib/node_modules/neovim/bin/cli.js'

" checkhealthを通すための設定
let g:loaded_perl_provider = 0

"-------------------------------------------------------------------------------
" Plugin
"-------------------------------------------------------------------------------

" NeoVim, VSCodeの判定
function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.config/nvim/plugged')

" NeoVimでのみ使用するプラグイン
" Color Scheme
Plug 'shaunsingh/nord.nvim', Cond(!exists('g:vscode'))

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', Cond(!exists('g:vscode'), { 'do': 'TSUpdate' })

" ステータスライン
Plug 'itchyny/lightline.vim', Cond(!exists('g:vscode'))

" 不要な空白を可視化・削除
Plug 'ntpeters/vim-better-whitespace', Cond(!exists('g:vscode'))

" インデントの可視化
Plug 'Yggdroot/indentLine', Cond(!exists('g:vscode'))

" ファイルエクスプローラ
Plug 'scrooloose/nerdtree', Cond(!exists('g:vscode'), { 'on': 'NERDTreeToggle' })

" Git操作
Plug 'tpope/vim-fugitive', Cond(!exists('g:vscode'))

" Gitの差分表示（ファイル上）
Plug 'airblade/vim-gitgutter', Cond(!exists('g:vscode'))

" Gitの差分表示（ファイルエクスプローラ上）
Plug 'xuyuanp/nerdtree-git-plugin', Cond(!exists('g:vscode'), { 'on': 'NERDTreeToggle' })

" 他言語パック
Plug 'sheerun/vim-polyglot', Cond(!exists('g:vscode'))

" if文などを自動で閉じる
Plug 'tpope/vim-endwise', Cond(!exists('g:vscode'))

" カッコなどを自動で閉じる
Plug 'jiangmiao/auto-pairs', Cond(!exists('g:vscode'))

" ウィンドウサイズの変更
Plug 'simeji/winresizer', Cond(!exists('g:vscode'))

" LSP
Plug 'neoclide/coc.nvim', Cond(!exists('g:vscode'), { 'branch': 'release' })

" NeoVimとVSCodeで異なるプラグインを使用する
" ファイル内ジャンプ（NeoVim）
Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))

" ファイル内ジャンプ（VSCode）
Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'))

" NeoVim, VSCodeの両方で使用するプラグイン
" カッコで囲む・カッコを変更する
Plug 'tpope/vim-surround'

" コメントアウト
Plug 'tpope/vim-commentary'

" オペレータを定義する
Plug 'kana/vim-operator-user'

" 置換というオペレータを追加する
Plug 'kana/vim-operator-replace'

" 繰り返せない操作を繰り返す
Plug 'tpope/vim-repeat'

" 選択範囲を拡縮する
Plug 'terryma/vim-expand-region'

" インクリメンタルサーチ
Plug 'junegunn/fzf.vim'

call plug#end()

"-------------------------------------------------------------------------------
" Plugin Settings
"-------------------------------------------------------------------------------
if exists('g:vscode')
  " vim-easymotion
  nmap s <Plug>(easymotion-s2)
else
  " treesitter
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
EOF

  " lightline.vim
  let g:lightline = { 'colorscheme': 'nord' }

  " Vim Better Whitespace
  let g:better_whitespace_enable=1
  let g:strip_whitespace_on_save=1
  let g:strip_whitespace_confirm=0
  let g:strip_whitelines_at_eof=1

  " NERDTree
  nmap <C-f> :NERDTreeToggle<CR>

  " vim-easymotion
  nmap s <Plug>(easymotion-overwin-f2)
endif

" vim-operator-replace
nmap _ <Plug>(operator-replace)

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"-------------------------------------------------------------------------------
" Shortcut
"-------------------------------------------------------------------------------
inoremap <silent> jj <ESC>
tnoremap <silent> <ESC> <C-\><C-n>

if exists('g:vscode')
  " VSCodeでvim-commentaryを使う
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine
endif

"-------------------------------------------------------------------------------
" 基本設定
"-------------------------------------------------------------------------------
" 全角記号の位置ずれ対応
set ambiwidth=double

" すべてのモードでマウス操作を可能にする
set mouse=a

" バックアップファイルを作成しない
set nobackup

" ファイル編集前の作業コピーを作成しない
set noswapfile

" 保存されていないファイルがある時、終了前に保存確認をする
set confirm

" 保存されていないファイルがある時でも、保存せず他のファイルを表示
set hidden

" 終了時に元のウィンドウタイトルが復元できない場合の設定
set titleold="Terminal"

" ウィンドウタイトルにファイル名を表示
set titlestring=%F

" True Colorを使用
set termguicolors

" 新規ウィンドウを右に作成
set splitright

" 新規ウィンドウを下に作成
set splitbelow

"-------------------------------------------------------------------------------
" 表示設定
"-------------------------------------------------------------------------------
if !exists('g:vscode')
  " 行番号の表示
  set number

  " 右下に行・列の番号を表示
  set ruler

  " タイトル表示
  set title

  " 不可視文字を表示
  set list

  " 表示できない文字を16進数で表示
  set display=uhex

  " 不可視文字の置き換え設定
  set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

  " 常にステータスラインを表示
  set laststatus=2

  " ステータスラインの表示内容
  set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

  " 対応括弧に<と>のペアを追加
  set matchpairs& matchpairs+=<:>

  " カラースキーマ
  colorscheme nord
endif

" カーソル行をハイライト
set cursorline

" 80行目に色を付ける
set colorcolumn=80

" 上下スクロールの視界を確保
set scrolloff=5

" 左右スクロールの視界を確保
set sidescrolloff=16

" 左右カーソル移動で行跨ぎする
set whichwrap=b,s,h,l,<,>,[,]

" 行を折り返さない
set nowrap

"-------------------------------------------------------------------------------
" 検索/置換設定
"-------------------------------------------------------------------------------
" 小文字で検索した場合は大文字小文字を無視
set ignorecase

" 大文字を含む検索では大文字小文字を無視しない
set smartcase

" 検索をファイルの先頭へループする
set wrapscan

" fzf
set rtp+=/usr/local/opt/fzf

"-------------------------------------------------------------------------------
" 編集設定
"-------------------------------------------------------------------------------
" タブ幅
set tabstop=2

" インデント幅(tabstopの値を使用する）
set shiftwidth=0

" タブの代わりにスペース
set expandtab

" 前の行に基づくインデント
" set autoindent

" 前の行の末尾に合わせてインデントを増減
set smartindent

"-------------------------------------------------------------------------------
" terminal
"-------------------------------------------------------------------------------
" デフォルトで起動するシェルをzshに変更
set sh=zsh

"-------------------------------------------------------------------------------
" other
"-------------------------------------------------------------------------------
" vim-gitgutterでの変更の反映を短くする
set updatetime=100
