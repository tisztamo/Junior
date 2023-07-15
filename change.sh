#!/bin/sh
# Goal: Rename the project to @aijunior/dev and change description
# Plan:
# 1. Change the name field in package.json to "@aijunior/dev".
# 2. Change the description field in package.json to "Your AI Contributor".
# 3. No new files are needed for this task.

# Updating package.json with new project name and description
jq '.name = "@aijunior/dev"' package.json > package_temp.json && mv package_temp.json package.json
jq '.description = "Your AI Contributor"' package.json > package_temp.json && mv package_temp.json package.json

echo "Project renamed to @aijunior/dev and description changed to 'Your AI Contributor' successfully"
