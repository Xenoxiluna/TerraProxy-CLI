// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "TerraProxy-CLI",
    products: [
        .executable(name: "TerraProxy-CLI", targets: ["TerraProxy-CLI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "TerraProxy-CLI", dependencies: ["NIO", "NIOHTTP1", "Logging"]),
    ]
)
