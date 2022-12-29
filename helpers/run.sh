#!/bin/bash -ex

EMACS='/Applications/Emacs.app/Contents/MacOS/Emacs'

if [[ -z "$EMACS" ]]; then
    echo "NO EMACS!!";
    exit 1;
else
    # Paradox
    # cd ~/.paradox
    cd ~/bin/lisp-projects/paradox/
    git fetch origin
    git checkout data &> /dev/null
    git pull &> /dev/null
    git merge origin/master
    cd ~/bin/lisp-projects/paradox/helpers
    /usr/bin/nice $EMACS --batch -Q \
           -L . -L .. -l paradox-counter.el \
           --eval '(setq debug-on-error t)' \
           -f paradox-generate-star-count
    git add .. &> /dev/null
    git commit -m "$(date)" &> /dev/null
    git push -v origin data:refs/heads/data &> /dev/null;
fi
