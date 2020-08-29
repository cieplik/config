#!/bin/bash

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  echo "USAGE: $(basename "$0") [REVSPEC...]"
  exit
fi

cd "$(git rev-parse --show-toplevel)"

QUERY_FILE=`mktemp ${TMPDIR:-/tmp}/git-review.query.XXXXXXXXXX`
while [ -f $QUERY_FILE ]; do
  git diff --name-only "$@" \
| fzf \
    --bind "ctrl-d:cancel" \
    --bind "ctrl-l:execute(echo {q} > $QUERY_FILE)+abort" \
    --bind "enter:execute(stty -F /dev/tty -ixon; git difftool --no-prompt "$@" -- {} < /dev/tty)" \
    --no-mouse `# to make text selection work` \
    --preview "git diff --color "$@" {} " \
    --preview-window "right:75%" \
    --query "$(cat $QUERY_FILE && rm $QUERY_FILE)"
done
