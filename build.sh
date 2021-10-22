#!/bin/sh

set -eu

function ci_lib() {
    NAME=$1
    xcodebuild -project FBSnapshotTestCase.xcodeproj \
               -scheme "FBSnapshotTestCase iOS" \
               -destination "platform=iOS Simulator,name=${NAME}" \
               -sdk iphonesimulator \
               build-for-testing | xcbeautify
    xcodebuild -project FBSnapshotTestCase.xcodeproj \
               -scheme "FBSnapshotTestCase iOS" \
               -destination "platform=iOS Simulator,name=${NAME}" \
               -sdk iphonesimulator \
               test-without-building | xcbeautify
}

function ci_demo() {
    NAME=$1
    pushd demos/FBSnapshotTestCaseDemo
    pod install
    xcodebuild -workspace FBSnapshotTestCaseDemo.xcworkspace \
               -scheme FBSnapshotTestCaseDemo \
               -destination "platform=iOS Simulator,name=${NAME}" \
               build-for-testing | xcbeautify
    xcodebuild -workspace FBSnapshotTestCaseDemo.xcworkspace \
               -scheme FBSnapshotTestCaseDemo \
               -destination "platform=iOS Simulator,name=${NAME}" \
               test-without-building | xcbeautify
    popd
}

function ci_demo_preprocessor() {
    NAME=$1
    pushd demos/FBSnapshotTestCaseDemo
    pod install
    xcodebuild -workspace FBSnapshotTestCaseDemo.xcworkspace \
               -scheme FBSnapshotTestCasePreprocessorDemo \
               -destination "platform=iOS Simulator,name=${NAME}" \
               build-for-testing | xcbeautify
    xcodebuild -workspace FBSnapshotTestCaseDemo.xcworkspace \
               -scheme FBSnapshotTestCasePreprocessorDemo \
               -destination "platform=iOS Simulator,name=${NAME}" \
               test-without-building | xcbeautify
    popd
}

function ci_carthage_demo() {
    NAME=$1
    pushd demos/iOSSnapshotTestCaseCarthageDemo
    carthage bootstrap --no-use-binaries --use-xcframeworks # we're using --no-use-binaries because carthage's archive doesn't yet create xcframeworks, and we're using --use-xcframeworks because of Xcode 12
    xcodebuild -project iOSSnapshotTestCaseCarthageDemo.xcodeproj \
               -scheme iOSSnapshotTestCaseCarthageDemo \
               -destination "platform=iOS Simulator,name=${NAME}" \
               build-for-testing | xcbeautify
    xcodebuild -project iOSSnapshotTestCaseCarthageDemo.xcodeproj \
               -scheme iOSSnapshotTestCaseCarthageDemo \
               -destination "platform=iOS Simulator,name=${NAME}" \
               test-without-building | xcbeautify
    popd
}

function ci_swiftpm_demo() {
    NAME=$1
    pushd demos/iOSSnapshotTestCaseSwiftPMDemo
    xcodebuild -project iOSSnapshotTestCaseSwiftPMDemo.xcodeproj \
               -scheme "iOSSnapshotTestCaseSwiftPMDemo (iOS)" \
               -destination "platform=iOS Simulator,name=${NAME}" \
               build-for-testing | xcbeautify
    xcodebuild -project iOSSnapshotTestCaseSwiftPMDemo.xcodeproj \
               -scheme "iOSSnapshotTestCaseSwiftPMDemo (iOS)" \
               -destination "platform=iOS Simulator,name=${NAME}" \
               test-without-building | xcbeautify
    popd
}

function test_bazel() {
    bazelisk test //src/iOSSnapshotTestCaseTests:iOSSnapshotTestCaseTests --test_output=all
}

ci_lib "iPhone 8" && ci_demo "iPhone 8" && ci_demo_preprocessor "iPhone 8"
ci_lib "iPhone 11" && ci_demo "iPhone 11" && ci_demo_preprocessor "iPhone 11"
ci_carthage_demo "iPhone 8"
ci_carthage_demo "iPhone 11"
ci_swiftpm_demo "iPhone 8"
ci_swiftpm_demo "iPhone 11"
test_bazel
