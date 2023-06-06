// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "iOSSnapshotTestCase",
    products: [
        .library(
            name: "iOSSnapshotTestCase",
            type: .dynamic,
            targets: [
                "iOSSnapshotTestCase",
                "iOSSnapshotTestCaseCore"
            ]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "iOSSnapshotTestCase",
            dependencies: ["iOSSnapshotTestCaseCore"]
        ),
        .target(
            name: "iOSSnapshotTestCaseCore",
            exclude: ["Resources/FBSnapshotTestCase-Info.plist"],
            publicHeadersPath: "Public"
        ),
        .testTarget(
            name: "iOSSnapshotTestCaseTests",
            dependencies: ["iOSSnapshotTestCase"],
            exclude: ["BUILD.bazel"],
            resources: [.process("Resources")]
        ),
    ]
)
