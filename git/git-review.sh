#!/bin/bash

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  cat <<EOF
USAGE: $(basename "$0") [REVSPEC...]
REVSPEC tricks:
  --cached/--staged   - files to be committed
  REV^!               - changes in particular commit (REV)
  master_ci...HEAD    - changes from last common ancestor with 'master_ci'
EOF
  exit
fi
revs="$1"

gitroot="$(git rev-parse --show-toplevel)"
cd "$gitroot"

dialog="$(which dialog whiptail 2>/dev/null | head -n1)"
[ -n "$dialog" ] || {
  echo "$0: neither 'dialog' nor 'whiptail' command found" >&2
  exit 1
}

# build list of differing files in correct format for 'dialog --menu'
menufiles=($(
  git diff --name-only "$@" -- |  # list files differing between specified revs,
    grep -vE '^.gitcc$' |         # filter out '.gitcc',
    nl                            # prepend index number to each filename
)) || exit 1

option=1
while true; do
  option=$(
    "$dialog" --default-item "$option" --menu \
      "Files changed for \"$@\":" \
      $(( $(tput lines)-5 )) $(( $(tput cols)-10 )) \
      $(( $(tput lines)-12 )) \
      "${menufiles[@]}" \
      3>&1 1>&2 2>&3
  )
  [[ -n "$option" ]] || break

  git difftool -y --tool=vimdiff "$@" -- "${menufiles[$((2*option-1))]}" || exit 1
done

