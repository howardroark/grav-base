#!/bin/sh

cd /project
git add .

#http://stackoverflow.com/a/3879077
if ! git diff-index --quiet HEAD --; then
    git commit -m "Grav Admin updates."
    git push origin master
fi
