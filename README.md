# HapTick

Simple and elegant way to add haptic feedback to your App 📲 .

## Features

- [x] Easy to use 
- [x] Prebuild feedbacks
- [x] Ability to add own feedbacks

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but Alamofire does support its use on supported platforms.

Once you have your Swift package set up, adding HapTick as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/B4kus/HapTick", .upToNextMajor(from: "1.1.0"))
]
```
## Usage

Firstly import HapTick

```swift
import Haptic
```

Next choose the place where you want to use it and add

```swift
try? HapticsEventManager.shared.playPattern(type: .press)
```

It is simple as that :)

## Credits

HapTick is owned and maintained by Szymon Szysz.

## License

HapTick is released under the MIT license.
