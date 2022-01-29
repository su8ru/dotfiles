# env ================

export LANG=en_US.utf8
export LC_ALL=en_US.utf8
export TZ='Asia/Tokyo'

export EDITOR=vim
export VISUAL=vim
export GPG_TTY=$(tty)

export IP=`hostname -I | cut -f1 -d' '`

export DENO_INSTALL="/home/subaru/.deno"
export BREW_INSTALL="/home/linuxbrew/.linuxbrew"
export SCREENDIR=$HOME/.screen

export PATH="\
$HOME/.anyenv/bin:\
$HOME/.local/bin:\
$HOME/.yarn/bin:\
$HOME/.composer/vendor/bin:\
/usr/local/custom:\
$DENO_INSTALL/bin:\
$BREW_INSTALL/bin:\
$PATH"

# anyenv ================

if hash anyenv 2>/dev/null; then
  eval "$(anyenv init -)"
fi

# phpbrew
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# color ================

autoload -Uz colors
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
colors

# comp ================

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                              /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# history ================

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# alias ================

alias nyarn='yarn'
alias explorer='explorer.exe'
alias clip='clip.exe'
alias pwsh='pwsh.exe'
alias gpp='g++-9 main.cpp -o ./a.out'
alias py3='python3'
alias :q
alias grep='grep --color=auto'

function phpstorm() {
  SCRIPT='/mnt/c/Users/subaru/.bin/PhpStorm.cmd'
  LOCATION="$(wslpath -w $1)"
  pushd "$(dirname "$SCRIPT")" >> /dev/null
  cmd.exe "$SCRIPT" "$LOCATION"
  popd >> /dev/null
}

# setopt ================

setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob
setopt correct
setopt appendhistory
setopt incappendhistory
setopt +o nomatch
setopt nonomatch

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# key ================

# https://wiki.archlinux.org/index.php/Zsh#Key_bindings

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# History search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# prompt ================

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
setopt prompt_subst

# 記号について
#   - : WorkingTreeに変更がある場合(Indexにaddしていない変更がある場合)
#   + : Indexに変更がある場合(commitしていない変更がIndexにある場合)
#   ? : Untrackedなファイルがある場合
#   * : remoteにpushしていない場合
# https://yonchu.hatenablog.com/entry/20120506/1336335973

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "-"
zstyle ':vcs_info:git:*' formats '%s,%u%c,%b'
zstyle ':vcs_info:git:*' actionformats '%s,%u%c,%b|%a'

function _update_vcs_info_msg() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  local _vcs_name _status _branch_action _host
  if [ -n "$vcs_info_msg_0_" ]; then
    _vcs_name=$(echo "$vcs_info_msg_0_" | cut -d , -f 1)
    _status=$(_git_untracked_or_not_pushed $(echo "$vcs_info_msg_0_" | cut -d , -f 2))
    _branch_action=$(echo "$vcs_info_msg_0_" | cut -d , -f 3)
    psvar[1]=" ${_branch_action}${_status}"
  fi
  if [ -n "$SSH_CONNECTION" ]; then
    _host="@%F{blue}%m%F{white}"
  fi
  # 左側プロンプト
  PROMPT="
[%F{cyan}%n%F{white}$_host %F{yellow}%d%F{white}%1(v|%F{green}%1v|)%F{yellow}${VIRTUAL_ENV:+($(basename "$VIRTUAL_ENV"))}%F{white}]
$ "
}

add-zsh-hook precmd _update_vcs_info_msg

#
# Untrackedなファイルが存在するか未PUSHなら記号を出力
#   Untracked: ?
#   未PUSH: *
#
function _git_untracked_or_not_pushed() {
  local git_status head remotes stagedstr
  local  staged_unstaged=$1 not_pushed="*" untracked="?"
  # カレントがgitレポジトリ下かどうか判定
  if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = "true" ]; then
    # statusをシンプル表示で取得
    git_status=$(git status -s 2> /dev/null)
    # git status -s の先頭が??で始まる行がない場合、Untrackedなファイルは存在しない
    if ! echo "$git_status" | grep "^??" > /dev/null 2>&1; then
      untracked=""
    fi

    # stagedstrを取得
    zstyle -s ":vcs_info:git:*" stagedstr stagedstr
    # git status -s の先頭がAで始まる行があればstagedと判断
    if [ -n "$stagedstr" ] && ! printf "$staged_unstaged" | grep "$stagedstr" > /dev/null 2>&1 \
      && echo "$git_status" | grep "^A" > /dev/null 2>&1; then
      staged_unstaged=${staged_unstaged}${stagedstr}
    fi

    # HEADのハッシュ値を取得
    #  --verify 有効なオブジェクト名として使用できるかを検証
    #  --quiet  --verifyと共に使用し、無効なオブジェクトが指定された場合でもエラーメッセージを出さない
    #           そのかわり終了ステータスを0以外にする
    head=$(git rev-parse --verify -q HEAD 2> /dev/null)
    if [ $? -eq 0 ]; then
      # HEADのハッシュ値取得に成功
      # リモートのハッシュ値を配列で取得
      remotes=($(git rev-parse --remotes 2> /dev/null))
      if [ "$remotes[*]" ]; then
        # リモートのハッシュ値取得に成功(リモートが存在する)
        for x in ${remotes[@]}; do
          # リモートとHEADのハッシュ値が一致するか判定
          if [ "$head" = "$x" ]; then
            # 一致した場合はPUSH済み
            not_pushed=""
            break
          fi
        done
      else
        # リモートが存在しない場合
        not_pushed=""
      fi
    else
      # HEADが存在しない場合(init直後など)
      not_pushed=""
    fi

    # Untrackedなファイルが存在するか未PUSHなら記号を出力
    if [ -n "$staged_unstaged" -o -n "$untracked" -o -n "$not_pushed" ]; then
      printf "${staged_unstaged}${untracked}${not_pushed}"
    fi
  fi
  return 0
}

precmd () {
  vcs_info
}

# title ================

# http://tekiomo.hatenablog.com/entry/20110518/1305730787

function changetitle {
  # pwdを二回も実行しているのがなんかダサい...
  current_dir=`pwd | sed -e "s%\(/\([^.]\|\..\)\)[^/]*%\1%g"``pwd | sed -e "s%^.*/\([^.]\|\..\)\([^/]*\)$%\2%"`
  if [ $current_dir = "//" ]; then
    current_dir="/"
  fi
  # タイトル用に整形
  # title=[${USER}@${HOST%%.*}]${current_dir}
  local _host
  if [ -n "$SSH_CONNECTION" ]; then
    _host="$(hostname | cut -d "." -f 1):"
  fi
  title=${_host}${current_dir}
  case "${TERM}" in
    xterm*|kterm*|rxvt*)
      echo -ne "\033]0;${title}\007"
    ;;  
    screen*)
      echo -ne "\033P\033]0;${title}\007\033\\"
    ;;  
  esac
}

# zsh起動時にとりあえず実行
changetitle

# cd実行後に変更
function chpwd() {
  changetitle
}

# Screenの場合、window切り替え時に前のwindowのタイトルがTerminal(＆タブ)のタイトルとして
# 残ってしまうのでせめてcdコマンド以外のコマンドでも実行前にタイトルを変更
preexec () {
  changetitle
}
