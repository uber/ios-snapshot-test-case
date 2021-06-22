// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ios-snapshot-test-case",
    products: [
        .library(
            name: "ios-snapshot-test-case",
            targets: ["ios-snapshot-test-case"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ios-snapshot-test-case",
            dependencies: []),
    ]
)
