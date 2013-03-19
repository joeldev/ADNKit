#!/bin/bash

rm -rf Release
mkdir -p Release/ADNKit
cd ADNKit && find . -iname "*.h" -exec cp -v "{}" "../Release/ADNKit/" \;
cd ../Pods/AFNetworking/AFNetworking && find . -iname "*.h" -exec cp -v "{}" "../../../Release/ADNKit/" \;
cd ../../../

OUTPUT_DIR="`echo $(pwd)/build/`"

xcodebuild clean -workspace ADNKit.xcworkspace -scheme ADNKit-OSX -configuration Release SYMROOT=${OUTPUT_DIR}
xcodebuild clean -workspace ADNKit.xcworkspace -scheme ADNKit-iOS -configuration Release SYMROOT=${OUTPUT_DIR}

xcodebuild build -workspace ADNKit.xcworkspace build -scheme ADNKit-iOS -sdk iphoneos -configuration Release SYMROOT=${OUTPUT_DIR}
xcodebuild build -workspace ADNKit.xcworkspace build -scheme ADNKit-iOS -sdk iphonesimulator -configuration Release SYMROOT=${OUTPUT_DIR}
xcodebuild build -workspace ADNKit.xcworkspace build -scheme ADNKit-OSX -configuration Release SYMROOT=${OUTPUT_DIR}

lipo -create -output Release/libADNKit-iOS.a build/Release-iphoneos/libADNKit-iOS.a build/Release-iphonesimulator/libADNKit-iOS.a

cp -R build/Release/* Release/
rm Release/libPods-ADNKit-OSX.a
rm -rf build