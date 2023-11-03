#!/bin/sh

git add .
read MESSAGE
git commit -m "$MESSAGE"