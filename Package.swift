// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Amplify",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "Amplify",
            targets: ["Amplify"]),
        
        .library(name: "AWSCognitoAuthPlugin",
                 targets: ["AWSCognitoAuthPlugin"]),
        
    ],
    dependencies: [
        .package(name: "AWSiOSSDKV2", url: "https://github.com/aws-amplify/aws-sdk-ios-spm.git", .upToNextMinor(from: "2.27.0")),
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", .exact("0.12.2"))
    ],
    targets: [
        .target(
            name: "Amplify",
            path: "Amplify",
            exclude: [
                "Info.plist",
                "Categories/DataStore/Model/Temporal/README.md"
            ]
        ),
        .target(
            name: "AWSPluginsCore",
            dependencies: [.target(name: "Amplify"),
                           .product(name: "AWSCore", package: "AWSiOSSDKV2")],
            path: "AmplifyPlugins/Core/AWSPluginsCore",
            exclude: [
                "Info.plist"
            ]
        ),
        .target(
            name: "AWSCognitoAuthPlugin",
            dependencies: [
                .target(name: "Amplify"),
                .target(name: "AWSPluginsCore"),
                .product(name: "AWSCore", package: "AWSiOSSDKV2"),
                .product(name: "AWSAuthCore", package: "AWSiOSSDKV2"),
                .product(name: "AWSMobileClientXCF", package: "AWSiOSSDKV2"),
                .product(name: "AWSCognitoIdentityProvider", package: "AWSiOSSDKV2"),
                .product(name: "AWSCognitoIdentityProviderASF", package: "AWSiOSSDKV2")],
            path: "AmplifyPlugins/Auth/AWSCognitoAuthPlugin",
            exclude: [
                "Resources/Info.plist"
            ]
        ),
    ]
)
