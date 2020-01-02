// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SystemIcons",
    dependencies: [
        .package(url: "https://github.com/groue/GRMustache.swift", from: "4.0.1"),
        .package(url: "https://github.com/crossroadlabs/Regex.git", from: "1.2.0")
    ],
    targets: [
        .target(
            name: "SystemIcons",
            dependencies: ["Mustache", "Regex"]),
        .testTarget(
            name: "SystemIconsTests",
            dependencies: ["SystemIcons"]),
    ]
)
