// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ios-snapshot-test-case",
    platforms: [
        .iOS(.v8), .tvOS(.v10),
    ],
    products: [
        .library(
            name: "ios-snapshot-test-case",
            targets: ["ios-snapshot-test-case"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ios-snapshot-test-case",
            dependencies: [],
            path: "FBSnapshotTestCase",
            sources: ["Categories", "Core/*.m"]
        )
//        .testTarget(
//            name: "ios-snapshot-test-caseTests",
//            dependencies: ["ios-snapshot-test-case"]),
    ]
)
