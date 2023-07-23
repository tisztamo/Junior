#!/bin/sh
# Goal: Remove all .nojekyll files
# Plan:
# 1. Use the find command to search for files named .nojekyll in the current directory and all subdirectories.
# 2. Use the -delete option of find command to remove these files.

find . -name ".nojekyll" -type f -delete
