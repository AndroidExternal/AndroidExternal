# !/bin/bash
# Copyright (C) 2016 Android/External
# This file is free software; This group
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# Check for options
while getopts "r" opt; do
  case $opt in
    r)
      echo "Only removing directories." >&2
      for repos in "$(cat external/AndroidExternal.repos)"; do rm -rf external/$repos; done;
      exit 0;
      ;;
    \?)
      echo "Usage: bash AndroidExternal.sh [-r]" >&2
      exit 1;
      ;;
  esac
done

# Enter external directory
cd external;

# Update Android/External provided repos
if [ -e "$(pwd)/AndroidExternal.repos" ]; then
  rm -rf AndroidExternal.repos;
fi;
if [ -n "$(which wget)" ]; then
  wget https://raw.githubusercontent.com/AndroidExternal/AndroidExternal/master/AndroidExternal.repos;
elif [ -n "$(which curl)" ]; then
  curl -O https://raw.githubusercontent.com/AndroidExternal/AndroidExternal/master/AndroidExternal.repos;
else
  echo "Error: Please install either wget or curl";
  exit 1;
fi;

# Sync repos
for repos in "$(cat AndroidExternal.repos)"; do
  rm -rf $repos;
  git clone https://github.com/AndroidExternal/$repos -b mm;
done;

# Return to root.
cd ..
