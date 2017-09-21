@echo off

set /P message=Commit Message:

echo adding all files to git
git add -A

echo committing changes with message: %message%
git commit -am "%message%"

echo pushing changes
git push

echo building app
hugo

echo pushing changes
cd public
git add -A
git commit -am "%message%"
git push

echo done :)

PAUSE