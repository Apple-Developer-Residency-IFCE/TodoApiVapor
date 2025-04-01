// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "POCToDoListAPI",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "5.0.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "5.0.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
                .product(name: "Vapor", package: "vapor"),
            ]
        ),
        .executableTarget(
            name: "Run",
            dependencies: [
                .target(name: "App")
            ]
        )
    ]
)
