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
            name: "FBSnapshotTestCaseCore",
            path: "FBSnapshotTestCase",
            sources: ["Core"],
            publicHeadersPath: "Core"
        ),
        .target(
            name: "FBSnapshotTestCase",
            dependencies: ["FBSnapshotTestCaseCore"],
            path: "FBSnapshotTestCase",
            sources: ["Core-Support"]
        ),
        .testTarget(
            name: "FBSnapshotTestCaseTests",
            dependencies: ["FBSnapshotTestCaseCore"],
            path: "FBSnapshotTestCaseTests",
            sources: ["Core"]
        ),
    ]
)
