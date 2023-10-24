#!/bin/sh
set -e
goal="Fixing rollup resolve plugin error"
echo "Plan:"
echo "1. Install @rollup/plugin-node-resolve."

# 1. Install @rollup/plugin-node-resolve
npm install @rollup/plugin-node-resolve --save

echo "\033[32mDone: $goal\033[0m\n"