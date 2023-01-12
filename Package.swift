// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HttpFramework",
	platforms: [
		.macOS(.v10_15),
		.iOS(.v14)
		],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library( name: "HttpFramework", targets: ["HttpFramework"]),
        .library(name: "SWAPI", targets: ["SWAPI"]),
        ],
    dependencies: [],
    targets: [
        .target(name: "HttpFramework" ),
        .target(name: "SWAPI", dependencies: ["HttpFramework"]),
    		]
)
