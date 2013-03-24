#!/bin/bash

rm -rf Release
mkdir -p Release/ADNKit
mkdir -p Release/ADNKit+AFNetworking
cd ADNKit && find . -iname "*.h" -exec cp -v "{}" "../Release/ADNKit/" \;
find . -iname "*.h" -exec cp -v "{}" "../Release/ADNKit+AFNetworking/" \;
cd ../External/AFNetworking/AFNetworking && find . -iname "*.h" -exec cp -v "{}" "../../../Release/ADNKit+AFNetworking/" \;
cd ../../../

xcodebuild clean build -target ADNKit-iOS -sdk iphoneos
xcodebuild clean build -target ADNKit-AFNetworking-iOS -sdk iphoneos
xcodebuild clean build -target ADNKit-iOS -sdk iphonesimulator
xcodebuild clean build -target ADNKit-AFNetworking-iOS -sdk iphonesimulator

lipo -create -output Release/libADNKit-iOS.a build/Release-iphoneos/libADNKit-iOS.a build/Release-iphonesimulator/libADNKit-iOS.a

lipo -create -output Release/libADNKit-AFNetworking-iOS.a build/Release-iphoneos/libADNKit-AFNetworking-iOS.a build/Release-iphonesimulator/libADNKit-AFNetworking-iOS.a

xcodebuild clean build -target ADNKit-OSX

cp -R build/Release/* Release/
rm -rf build