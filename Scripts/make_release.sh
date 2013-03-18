#!/bin/bash

rm -rf Release
mkdir -p Release/ADNKit
cd ADNKit && find . -iname "*.h" -exec cp -v "{}" "../Release/ADNKit/" \;
cd ../External/AFNetworking/AFNetworking && find . -iname "*.h" -exec cp -v "{}" "../../../Release/ADNKit/" \;
cd ../../../

xcodebuild clean build -target ADNKit-iOS -sdk iphoneos
xcodebuild build -target ADNKit-iOS -sdk iphonesimulator

lipo -create -output Release/libADNKit-iOS.a build/Release-iphoneos/libADNKit-iOS.a build/Release-iphonesimulator/libADNKit-iOS.a

xcodebuild clean build -target ADNKit-OSX

cp -R build/Release/* Release/
rm -rf build