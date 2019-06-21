#!/bin/sh

set -eu

function ci_lib() {
    NAME=$1
    xcodebuild -project FBSnapshotTestCase.xcodeproj \
               -scheme "FBSnapshotTestCase iOS" \
               -destination "platform=iOS Simulator,name=${NAME}" \
               -sdk iphonesimulator \
               build-for-testing
    xcodebuild -project FBSnapshotTestCase.xcodeproj \
               -scheme "FBSnapshotTestCase iOS" \
               -destination "platform=iOS Simulator,name=${NAME}" \
               -sdk iphonesimulator \
               test-without-building
}

function ci_demo() {
    NAME=$1
    pushd FBSnapshotTestCaseDemo
    pod install
    xcodebuild -workspace FBSnapshotTestCaseDemo.xcworkspace \
               -scheme FBSnapshotTestCaseDemo \
               -destination "platform=iOS Simulator,name=${NAME}" \
               build-for-testing
    xcodebuild -workspace FBSnapshotTestCaseDemo.xcworkspace \
               -scheme FBSnapshotTestCaseDemo \
               -destination "platform=iOS Simulator,name=${NAME}" \
               test-without-building
    popd
}

function ci_carthage_demo() {
    NAME=$1
    pushd iOSSnapshotTestCaseCarthageDemo
    carthage bootstrap
    xcodebuild -project iOSSnapshotTestCaseCarthageDemo.xcodeproj \
               -scheme iOSSnapshotTestCaseCarthageDemo \
               -destination "platform=iOS Simulator,name=${NAME}" \
               build-for-testing
    xcodebuild -project iOSSnapshotTestCaseCarthageDemo.xcodeproj \
               -scheme iOSSnapshotTestCaseCarthageDemo \
               -destination "platform=iOS Simulator,name=${NAME}" \
               test-without-building
    popd
}

ci_lib "iPhone 7" && ci_demo "iPhone 7"
ci_lib "iPhone X" && ci_demo "iPhone X"
ci_lib "iPhone 7" && ci_carthage_demo "iPhone 7"
ci_lib "iPhone X" && ci_carthage_demo "iPhone X"
