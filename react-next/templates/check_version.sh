#!/bin/bash

echo "=== Environment Version Check ==="

echo -n "Node: "
node -v

echo -n "npm: "
npm -v

echo -n "npx: "
npx --version

echo -n "OS: "
lsb_release -d 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME

echo -n "Git: "
git --version

echo -n "GCC: "
gcc --version | head -n 1

echo -n "Make: "
make --version | head -n 1

