#!/bin/bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Builds a go binary in a temporary location and moves it into the apps/APPNAME/bin directory

APPNAME=$1

# Make temp directory
tmpDir=$(mktemp -d)
cd apps/$APPNAME
export CGO_ENABLED=0
export GOARCH=amd64
export GOOS=linux
echo "Building $APPNAME into $tmpDir"
go build -a -installsuffix cgo -ldflags '-s -w' -o $tmpDir/$APPNAME
binDirectory=bin/
echo "Clearing $binDirectory"
rm -rf $binDirectory
mkdir -p $binDirectory
echo "Moving $APPNAME into $binDirectory"
mv $tmpDir/$APPNAME $binDirectory/$APPNAME
