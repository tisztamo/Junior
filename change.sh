#!/bin/sh
# Goal: Rename build:docs to build:doc in package.json
# Plan:
# 1. Use jq to rename the "build:docs" property to "build:doc" in the "scripts" object of the package.json file.
# 2. Save the modified JSON back to package.json.

jq '.scripts |= with_entries(if .key == "build:docs" then .key = "build:doc" else . end)' ./package.json > temp.json && mv temp.json package.json
