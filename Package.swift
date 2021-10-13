// swift-tools-version:5.3
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
            exclude: ["Categories",
                      "FBSnapshotTestCase.h",
                      "FBSnapshotTestCase.m",
                      "FBSnapshotTestCasePlatform.h",
                      "FBSnapshotTestCasePlatform.m",
                      "FBSnapshotTestController.h",
                      "FBSnapshotTestController.m",
                      "FBSnapshotTestCase-Info.plist"],
            sources: ["Support"]
        ),
        .target(
            name: "FBSnapshotTestCaseCore",
            path: "FBSnapshotTestCase",
            exclude: ["Support",
                      "FBSnapshotTestCase-Info.plist"],
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
            exclude: ["FBSnapshotTestCaseTests-Info.plist",
                      "square-copy.png",
                      "rect_shade.png",
                      "square.png",
                      "square_with_text.png",
                      "BUILD.bazel",
                      "rect.png",
                      "square_with_pixel.png"],
            sources: ["FBSnapshotControllerTests.m"]
        ),
    ]
)
