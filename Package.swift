// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FBSnapshotTestCase",
    platforms: [
        .iOS(.v8), .tvOS(.v10),
    ],
    products: [
        .library(
            name: "FBSnapshotTestCase",
            type: .dynamic,
            targets: ["FBSnapshotTestCase"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FBSnapshotTestCase",
            path: "FBSnapshotTestCase",
            sources: ["Core"],
            publicHeadersPath: "Core"
        ),
        .testTarget(
            name: "FBSnapshotTestCaseTests",
            dependencies: ["FBSnapshotTestCase"],
            path: "FBSnapshotTestCaseTests",
            sources: ["Core"]
        ),
    ]
)
