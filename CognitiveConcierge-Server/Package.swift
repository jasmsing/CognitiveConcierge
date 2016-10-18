import PackageDescription

let package = Package(
    name: "restaurant-recommendations",
    dependencies: [
       .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 1, minor: 0),
       .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 1, minor: 0),
       .Package(url: "https://github.com/IBM-Swift/Swift-cfenv.git", majorVersion: 1, minor: 7),
       .Package(url: "https://github.com/vherrin/swift-watson-sdk.git", Version(0, 4, 2))
    ]
)
