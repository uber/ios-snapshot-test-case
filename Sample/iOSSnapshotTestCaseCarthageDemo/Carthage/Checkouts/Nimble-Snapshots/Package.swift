// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Nimble-Snapshots",
    platforms: [
        .iOS(.v9), .tvOS(.v10),
    ],
    products: [
        .library(
            name: "Nimble-Snapshots",
            type: .dynamic,
            targets: ["Nimble-Snapshots"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", .exact("8.0.2")),
        .package(url: "https://github.com/bfernandesbfs/ios-snapshot-test-case.git", .branch("spm")),
    ],
    targets: [
        .target(
            name: "Nimble-Snapshots",
            dependencies: ["Nimble", "ios-snapshot-test-case"],
            path: "Nimble_Snapshots",
            sources: ["Core", "Categories/*.m"]
        ),
//        .testTarget(
//            name: "Nimble-SnapshotsTests",
//            dependencies: ["Nimble-Snapshots"]),
    ]
)
