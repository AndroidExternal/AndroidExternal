# !/bin/bash
# Copyright (C) 2016 Android/External
# This file is free software; This group
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

cd external;

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

for repos in "$(cat AndroidExternal.repos)"; do
  rm -rf $repos;
  git clone https://github.com/AndroidExternal/$repos -b mm;
done;

cd ..
