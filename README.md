# WeatherForecast iOS App

## Pre-conditions

- install Carthage [Download link](https://github.com/Carthage/Carthage/releases/download/0.38.0/Carthage.pkg)
- Github [Carthage](https://github.com/Carthage/Carthage)

## Linter
- install [SwiftLint](https://github.com/realm/SwiftLint)

```sh
brew install swiftlint
```

## Build

```sh
./carthage.sh update --platform iOS --no-use-binaries --use-netrc --use-xcframeworks
```

- use `platform` flag to build only for iOS to save time and disk space
- use `no-use-binaries` to build from sources

#### Notice
- Should set xcframework embed&&sign in Build General

### OR

Re-build frameworks if needed

```sh
carthage build --platform iOS --use-xcframeworks
```

#### Xcode Version
version: 13.2.0 above

## Confluence

- Swift Code Styles Guide - [Swift Code Styles](https://github.com/raywenderlich/swift-style-guide)


## Test
