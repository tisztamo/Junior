#!/bin/sh
# Goal: Rename bin command and add a new one
# Plan:
# 1. Update the "bin" field in the package.json file to rename the existing command and add a new command

# Command to update the package.json
jq '.bin |= { "junior": "src/main.js", "junior-web": "npm start" }' package.json > tmp.json && mv tmp.json package.json
