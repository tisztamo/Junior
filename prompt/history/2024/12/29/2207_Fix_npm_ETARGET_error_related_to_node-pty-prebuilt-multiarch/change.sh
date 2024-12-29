#!/bin/sh
set -e

goal="Fix npm ETARGET error related to node-pty-prebuilt-multiarch"
echo "Plan:"
echo "1. Verify node-pty-prebuilt-multiarch@^0.10.1 availability on npm."
echo "2. Update package.json with a valid version if necessary."
echo "3. Clear npm cache to prevent corruption issues."
echo "4. Synchronize package-lock.json and package.json if out of sync."
echo "5. Re-run npm ci to ensure dependencies are installed."

# Step 1: Verify package version availability
PACKAGE="node-pty-prebuilt-multiarch"
VERSION="0.10.1"

echo "Checking availability of $PACKAGE@$VERSION on npm..."
npm show "$PACKAGE@$VERSION" version > /dev/null 2>&1 || {
  echo "$PACKAGE@$VERSION not found. Attempting to find the latest version..."
  LATEST_VERSION=$(npm show "$PACKAGE" version)
  echo "Latest available version of $PACKAGE is $LATEST_VERSION. Updating package.json..."

  # Step 2: Update package.json with the latest version
  jq ".dependencies[\"$PACKAGE\"] = \"^$LATEST_VERSION\"" package.json > package.json.tmp && mv package.json.tmp package.json
  echo "Updated $PACKAGE to version ^$LATEST_VERSION in package.json."
}

# Step 3: Clear npm cache
echo "Clearing npm cache..."
npm cache clean --force

# Step 4: Synchronize package-lock.json with package.json
echo "Ensuring package.json and package-lock.json are in sync..."
npm install

# Step 5: Re-run npm ci
echo "Running npm ci to install dependencies..."
npm ci

echo "\033[32mDone: $goal\033[0m\n"
