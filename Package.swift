// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "JokeGenerator",
	platforms: [
		.iOS(.v17),
	],
	products: [
		.library(
			name: "JokeGenerator",
			targets: ["JokeGenerator"]),
	],
	targets: [
		.target(name: "JokeGenerator"),
	]
)
