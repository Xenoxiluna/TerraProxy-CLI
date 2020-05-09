// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "TerraProxy-CLI",
    products: [
        .executable(name: "TerraProxy-CLI", targets: ["TerraProxy-CLI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/apple/swift-log.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "0.0.5")),
        .package(url: "https://github.com/Xenoxiluna/SwiftyBytes.git", .upToNextMinor(from:"0.2.0")),
    ],
    targets: [
        .target(name: "TerraProxy-CLI", dependencies: ["NIO", "NIOHTTP1", "Logging", "ArgumentParser", "SwiftyBytes"]),
    ]
)
