#!/bin/bash

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  echo "USAGE: $(basename "$0") [REVSPEC...]"
  echo "REVSPEC tricks:"
  echo "  --cached/--staged   - files to be committed"
  echo "  REV^!               - changes in particular commit (REV)"
  echo "  master_ci...HEAD    - changes from last common ancestor with 'master_ci'"
  exit
fi

cd "$(git rev-parse --show-toplevel)"                      # cd to repo root dir

dialog="$(which dialog whiptail 2>/dev/null | head -n1)"
[ -n "$dialog" ] || {
  echo "$0: neither 'dialog' nor 'whiptail' command found" >&2
  exit 1
}

while true; do
  # build list of differing files in correct format for 'dialog --menu'
  readarray -t menufiles < <(
    git diff --name-only "$@" -- |         # list files differing between specified revs,
    nl -s'<newline>'             |         # prepend index number to each filename
    sed 's/<newline>/\n/g'      || exit 1
  )

  option=$(
    "$dialog" --default-item "${option:-1}" --menu                             \
      "Files changed for \"$@\":"                                              \
      $(( $(tput lines)-5 )) $(( $(tput cols)-10 ))                            \
      $(( $(tput lines)-12 ))                                                  \
      "${menufiles[@]}"                                                        \
      3>&1 1>&2 2>&3
  )
  [[ -n "$option" ]] || break

  git difftool -y "$@" -- "${menufiles[$((2*option-1))]}" || exit 1
done

