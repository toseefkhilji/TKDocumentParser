// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TKDocumentParser",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "TKDocumentParser",
            targets: ["TKDocumentParser"]),
    ],
    dependencies: [
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", .upToNextMajor(from: "0.9.19")),
        .package(url: "https://github.com/yahoojapan/SwiftyXMLParser.git", from: "5.6.0")
    ],
    targets: [
        .target(
            name: "TKDocumentParser",
            dependencies: [
                .product(name: "ZIPFoundation", package: "ZIPFoundation"),
                .product(name: "SwiftyXMLParser", package: "SwiftyXMLParser"),
            ],
            path: "Sources/TKDocumentParser"),
        .testTarget(
            name: "TKDocumentParserTests",
            dependencies: ["TKDocumentParser"],
            path: "Tests/TKDocumentParserTests"),
    ]
)
