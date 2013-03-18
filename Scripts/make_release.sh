#!/bin/bash

rm -rf Release
mkdir -p Release/ADNKit
cd ADNKit && find . -iname "*.h" -exec cp -v "{}" "../Release/ADNKit/" \;
cd ../External/AFNetworking/AFNetworking && find . -iname "*.h" -exec cp -v "{}" "../../../Release/ADNKit/" \;
cd ../../../

xcodebuild clean build -target ADNKit-iOS
xcodebuild clean build -target ADNKit-OSX

cp -R build/Release/* Release/
cp build/Release-iphoneos/*.a Release/
rm -rf build