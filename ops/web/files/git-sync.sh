#!/bin/sh
#http://stackoverflow.com/a/3879077
cd /project
if [ git diff-index --quiet HEAD -- ]; then
    git add .
    git commit -m "Grav Admin updates."
    git push origin master
fi
