// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-set",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [

        .library(
            name: "Set",
            targets: ["Set"]
        ),

        .library(
            name: "Set Standard Library Integration",
            targets: ["Set Standard Library Integration"]
        ),

        .library(
            name: "Set Apple Foundation Integration",
            targets: ["Set Apple Foundation Integration"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-hash.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Set",
            dependencies: [
                .product(name: "Hash", package: "swift-hash"),
                .product(name: "Index", package: "swift-index"),
            ]
        ),

        .target(
            name: "Set Standard Library Integration",
            dependencies: [
                "Set"
            ]
        ),

        .target(
            name: "Set Apple Foundation Integration",
            dependencies: [
                "Set",
                "Set Standard Library Integration",
            ]
        ),

        .testTarget(
            name: "Set Tests",
            dependencies: [
                "Set"
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
