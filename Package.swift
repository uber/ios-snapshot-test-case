// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "FBSnapshotTestCase",
    platforms: [
        .iOS(.v10), .tvOS(.v10),
    ],
    products: [
        .library(
            name: "FBSnapshotTestCase",
            type: .dynamic,
            targets: ["FBSnapshotTestCase", "FBSnapshotTestCaseCore"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FBSnapshotTestCase",
            dependencies: ["FBSnapshotTestCaseCore"],
            path: "FBSnapshotTestCase",
            sources: ["Support"]
        ),
        .target(
            name: "FBSnapshotTestCaseCore",
            path: "FBSnapshotTestCase",
            sources: ["Categories",
                      "FBSnapshotTestCase.h",
                      "FBSnapshotTestCase.m",
                      "FBSnapshotTestCasePlatform.h",
                      "FBSnapshotTestCasePlatform.m",
                      "FBSnapshotTestController.h",
                      "FBSnapshotTestController.m"],
            publicHeadersPath: "Public"
        ),
        .testTarget(
            name: "FBSnapshotTestCaseTests",
            dependencies: ["FBSnapshotTestCase"],
            path: "FBSnapshotTestCaseTests",
            sources: ["FBSnapshotControllerTests.m"]
        ),
    ]
)
