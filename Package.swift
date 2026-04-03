// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorLottieSplashScreen",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "CapacitorLottieSplashScreen",
            targets: ["LottieSplashScreenPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "8.0.0"),
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.5.2")
    ],
    targets: [
        .target(
            name: "LottieSplashScreenPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm"),
                .product(name: "Lottie", package: "lottie-ios")
            ],
            path: "ios/Sources/LottieSplashScreenPlugin"),
        .testTarget(
            name: "LottieSplashScreenPluginTests",
            dependencies: ["LottieSplashScreenPlugin"],
            path: "ios/Tests/LottieSplashScreenPluginTests")
    ]
)
