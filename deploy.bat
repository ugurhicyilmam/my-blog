@echo off

set /P message=Commit Message:

echo adding all files to git
git add -A
cls

echo committing changes with message: %message%
git commit -am %message%
cls

echo pushing changes
git push
cls


PAUSE