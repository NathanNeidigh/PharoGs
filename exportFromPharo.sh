#!/bin/sh

set -x
set -e

if [ ! -d pharo ]; then   # create Pharo directory
  mkdir -p pharo
fi
cd pharo
if [ ! -d Pharo.app ]; then   # get VM
  if [ `uname` == 'Darwin' ]; then
    wget https://files.pharo.org/get-files/110/pharo-vm-Darwin-x86_64-stable.zip
  else
    wget https://files.pharo.org/get-files/110/pharo-vm-Linux-x86_64-stable.zip
  fi
  unzip *.zip
  rm *.zip
fi
if [ ! -f PharoV60.sources ]; then   # get sources
  wget https://files.pharo.org/get-files/70/sources.zip
  unzip *.zip
  rm *.zip
fi

echo "Get Pharo minimal image"
if [ -z "$PHAROGS" ]; then   # get image & changes
  wget http://files.pharo.org/image/110/latest-minimal-64.zip
  if [ -f *.changes ]; then
    rm *.changes
  fi
  if [ -f *.image ]; then
    rm *.image
  fi
  unzip *.zip
  rm *.zip
else
  cp $PHAROGS/bootstrap-cache/Pharo11.0-SNAPSHOT-metacello-* .
fi
cd ..

if [ ! -d classes ]; then
  mkdir -p classes
fi
if [ -f classes/Object.gs ]; then
  rm classes/*
fi
if [ -f output/Object.out ]; then
  rm output/*
fi
if [ -f PharoGs.tpz ]; then
  rm PharoGs.tpz
fi
if [ -f PharoGs.out ]; then
  rm *.out
fi
if [ -f PharoDebug.log ]; then
  rm PharoDebug.log
fi
if [ `uname` == 'Darwin' ]; then
  ./pharo/Pharo.app/Contents/MacOS/pharo ./pharo/Pharo11.0-*.image exportFromPharo.st
else
  ./pharo/pharo ./pharo/Pharo11.0-*.image exportFromPharo.st
fi
