@echo off

set /P message=Commit Message:

echo adding all files to git
git add -A
cls

echo committing changes with message: %message%
git commit -am "%message%"
cls

echo pushing changes
git push
cls

echo building app
hugo
cls

echo pushing changes
cd public
git add -A
git commit -am "%message%"
git push
cls

echo done :)

PAUSE