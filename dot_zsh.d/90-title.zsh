# title ================

# http://tekiomo.hatenablog.com/entry/20110518/1305730787

function changetitle {
  current_dir=`pwd | sed -e "s%\(/\([^.]\|\..\)\)[^/]*%\1%g"``pwd | sed -e "s%^.*/\([^.]\|\..\)\([^/]*\)$%\2%"`
  if [ $current_dir = "//" ]; then
    current_dir="/"
  fi
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

changetitle

function chpwd() {
  changetitle
}
