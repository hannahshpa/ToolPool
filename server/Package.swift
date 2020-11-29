// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "server",
    platforms: [
       .macOS(.v10_15)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/GraphQLSwift/Graphiti.git", from: "0.22.0"),
        .package(url: "https://github.com/vapor/postgres-kit.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(name:"SwiftJWT", url: "https://github.com/Kitura/Swift-JWT.git", from: "3.0.0"),
        .package(name: "AWSSDKSwift", url: "https://github.com/soto-project/soto.git", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Graphiti", package: "Graphiti"),
                .product(name: "PostgresKit", package: "postgres-kit"),
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "SwiftJWT", package: "SwiftJWT"),
                .product(name: "S3", package: "AWSSDKSwift"),
                .product(name: "SES", package: "AWSSDKSwift"),
                .product(name: "IAM", package: "AWSSDKSwift")
                    
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite the use of
                // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
                // builds. See <https://github.com/swift-server/guides#building-for-production> for details.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .target(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
