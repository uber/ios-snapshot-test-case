#!/bin/sh

set -eu

function ci_lib() {
    if [ "$1" = "iOS" ]; then
      SCHEME="FBSnapshotTestCase iOS"
      DESTINATION="platform=iOS Simulator,name=$2"
      SDK="iphonesimulator"
    elif [ "$1" = "OSX" ]; then
      SCHEME="FBSnapshotTestCase macOS"
      DESTINATION="platform=OS X"
      SDK="macosx"
    fi
    xcodebuild -project FBSnapshotTestCase.xcodeproj \
               -scheme "${SCHEME}" \
               -destination "${DESTINATION}" \
               -sdk "${SDK}" \
               build test
}

function ci_demo() {
    if [ "$1" = "iOS" ]; then
      PROJECT="FBSnapshotTestCaseDemo"
      DESTINATION="platform=iOS Simulator,name=$2"
    elif [ "$1" = "OSX" ]; then
      PROJECT="FBSnapshotTestCaseDemoMacOS"
      DESTINATION="platform=OS X"
    fi
    pushd "${PROJECT}"
    pod install
    xcodebuild -workspace "${PROJECT}".xcworkspace \
               -scheme "${PROJECT}" \
               -destination "${DESTINATION}" \
               build test
    popd
}

ci_lib "iOS" "iPhone 7" && ci_demo "iOS" "iPhone 7"
ci_lib "iOS" "iPhone X" && ci_demo "iOS" "iPhone X"
ci_lib "OSX" #&& ci_demo "OSX" ##the demo app tests fail a.t.m. being unable to find the key window while running from the command line
