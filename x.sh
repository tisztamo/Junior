#!/bin/bash

# Módosítások mentése, ha vannak
git stash

# Átváltás a main ágra
git checkout main

# Legfrissebb változtatások lehúzása
git pull origin main

# Új ág létrehozása a keyboard-bindings néven
git checkout -b keyboard-bindings

# Módosítások visszaállítása, ha voltak
git stash apply

# Üzenet a felhasználónak
echo "Az új 'keyboard-bindings' ág létrejött az origin/main legutóbbi állapotából."

