" Quick Start
" brew install tags
" brew install w3m
" gem install bitclust-dev
" gem install refe2
" :NeoBundleInstall

"カラースキーマ
colorscheme molokai
syntax on
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark

" 文字コード
set fenc=utf-8
" 自動インテント
set autoindent
" 行番号
set number
" ソフトタブ
set expandtab
" タブ文字を何文字分で表示するか
set tabstop=2
" 自動で挿入されるインデントの幅
set shiftwidth=2
" 曖昧検索
set incsearch
" 自動インデント
set smartindent
" 行頭行末でカーソルが止まらない
set whichwrap=b,s,h,l,<,>,[,]
" クリップボードをOSと連携
set clipboard=unnamed
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu
" ウインドウのタイトルバーにファイルのパス情報等を表示する
set title
" スペルチェック
set spelllang=en,cjk
" swpファイルを作らない
set noswapfile
" 全角スペース	の表示
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /　/
" viとの互換性カット
set nocompatible

" vimrc更新したら自動リロード
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
  autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END

" NeoBundle
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" NeoBundle Plugin
" =================== NERDTree =================
NeoBundle 'scrooloose/nerdtree'
" =================== NERDTree =================

" =================== submode =================
NeoBundle 'kana/vim-submode'
let s:bundle = neobundle#get("vim-submode")
function! s:bundle.hooks.on_source(bundle)
  " http://d.hatena.ne.jp/thinca/20130131/1359567419
  " ウィンドウサイズの変更キーを簡易化する
  " [C-w],[+]または、[C-w],[-]
  call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
  call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
  call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
  call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
  call submode#map('winsize', 'n', '', '>', '<C-w>>')
  call submode#map('winsize', 'n', '', '<', '<C-w><')
  call submode#map('winsize', 'n', '', '+', '<C-w>-')
  call submode#map('winsize', 'n', '', '-', '<C-w>+')
endfunction
" =================== submode =================

" =================== vim-slim =================
" vimでslimのシンタックスハイライトを行う
NeoBundle 'slim-template/vim-slim'
" =================== vim-slim =================

" =================== switch.vim =================
" ifやforで改行するとendを自動補完してくれる
NeoBundle 'tpope/vim-endwise'
" =================== switch.vim =================

" =================== unite =================
NeoBundle 'Shougo/unite.vim'
" =================== unite =================

" =================== vimproc =================
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
" =================== vimproc =================

" =================== tag { =================
  " =================== vim-tags =================
  " brew install tags
  NeoBundle 'szw/vim-tags'
  " =================== vim-tags =================

  " =================== alpaca_tags =================
  NeoBundle 'alpaca-tc/alpaca_tags'
  augroup AlpacaTags
    autocmd!
    if exists(':Tags')
      autocmd BufWritePost Gemfile TagsBundle
      autocmd BufEnter * TagsSet
      " 毎回保存と同時更新する場合はコメントを外す
      " autocmd BufWritePost * TagsUpdate
    endif
  augroup END
  " =================== alpaca_tags =================
" =================== } tag =================

" =================== vim-localvimrc =================
" .lvimrcが存在していれば読み込み
NeoBundle 'embear/vim-localvimrc'
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
  autocmd BufReadPre .vimprojects set ft=vim
augroup END
function! s:vimrc_local(loc)
  let files = findfile('.vimprojects', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
" =================== vim-localvimrc =================

" =================== Ruby Plugin { =================
  " =================== vim-rails =================
  " rails用のコードジャンプが豊富
  NeoBundle 'tpope/vim-rails'
  " =================== vim-rails =================

  " =================== ruby-matchit =================
  " def endに%で移動出来るようにする
  NeoBundle 'vim-scripts/ruby-matchit'
  if !exists('loaded_matchit')
    " matchitを有効化
    runtime macros/matchit.vim
  endif
  " =================== ruby-matchit =================

  " =================== unite-rails =================
  NeoBundle 'basyura/unite-rails'
  noremap :rc :<C-u>Unite rails/controller<CR>
  noremap :rm :<C-u>Unite rails/model<CR>
  noremap :rv :<C-u>Unite rails/view<CR>
  noremap :rh :<C-u>Unite rails/helper<CR>
  noremap :rs :<C-u>Unite rails/stylesheet<CR>
  noremap :rj :<C-u>Unite rails/javascript<CR>
  noremap :rr :<C-u>Unite rails/route<CR>
  noremap :rg :<C-u>Unite rails/gemfile<CR>
  noremap :rt :<C-u>Unite rails/spec<CR>
  " =================== unit-rails =================

  " =================== vim-ref vim-ref-ri =================
  " brew install w3m
  " gem install bitclust-dev
  " gem install refe2
  NeoBundle 'thinca/vim-ref'
  NeoBundle 'yuku-t/vim-ref-ri'
  let g:ref_use_vimproc=1
  let g:ref_refe_version=2
  let g:ref_refe_encoding = 'utf-8'
  " =================== vim-ref =================

" =================== } Ruby Plugin =================

" =================== vim-go { =================
NeoBundle 'fatih/vim-go'
" =================== } vim-go =================

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
