#!/bin/sh
# Goal: Fix missing package error in project
# Plan:
# 1. The error message shows that the package 'ws' is missing. So, the first step is to install this package using npm. 
# 2. Verify that the 'ws' package is listed in the dependencies in the package.json file.
# 3. Run 'npm start' to make sure the error is fixed.

npm install ws --save

if ! cat package.json | jq '.dependencies' | grep -q '"ws":'; then
    echo "'ws' package not added to package.json, manual intervention required!"
    exit 1
fi

echo "'ws' package has been successfully installed and added to package.json!"

npm start
