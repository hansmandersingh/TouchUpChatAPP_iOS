#!/bin/sh

git add .
echo "Please enter a commit message here"
read MESSAGE
git commit -m "$MESSAGE"