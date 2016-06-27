# !/bin/bash
# Copyright (C) 2016 Android/External
# This file is free software; This group
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

unset RMONLY

while getopts ":a" opt; do
  case $opt in
    r)
      echo "Only removing directories." >&2
      RMONLY=true;
      ;;
    \?)
      echo "Usage: bash AndroidExternal.sh [-r]" >&2
      ;;
  esac
done

cd external;

if [ -e "$(pwd)/AndroidExternal.repos" ]; then
  rm -rf AndroidExternal.repos;
  if [ -n "$RMONLY" ]; then
    exit 0;
  fi;
fi;

if [ -n "$(which wget)" ]; then
  wget https://raw.githubusercontent.com/AndroidExternal/AndroidExternal/master/AndroidExternal.repos;
elif [ -n "$(which curl)" ]; then
  curl -O https://raw.githubusercontent.com/AndroidExternal/AndroidExternal/master/AndroidExternal.repos;
else
  echo "Error: Please install either wget or curl";
  exit 1;
fi;

for repos in "$(cat AndroidExternal.repos)"; do
  rm -rf $repos;
  git clone https://github.com/AndroidExternal/$repos -b mm;
done;

cd ..
