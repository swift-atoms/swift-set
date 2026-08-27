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
            name: "Set Apple Foundation Integration",
            targets: ["Set Apple Foundation Integration"]
        ),

        .library(
            name: "Set Test Support",
            targets: ["Set Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-cardinal.git",
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
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Hash", package: "swift-hash"),
            ]
        ),

        .target(
            name: "Set Apple Foundation Integration",
            dependencies: ["Set"]
        ),

        .target(
            name: "Set Test Support",
            dependencies: [
                "Set",
                .product(
                    name: "Cardinal Standard Library Integration",
                    package: "swift-cardinal"
                ),
                .product(
                    name: "Hash Standard Library Integration",
                    package: "swift-hash"
                ),
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "Set Tests",
            dependencies: [
                "Set",
                "Set Test Support",
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
