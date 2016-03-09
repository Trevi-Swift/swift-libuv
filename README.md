# Libuv for Swift

[![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Mac OS X](https://img.shields.io/badge/platform-osx-lightgrey.svg?style=flat)](https://developer.apple.com/swift/)
[![Ubuntu](https://img.shields.io/badge/platform-linux-lightgrey.svg?style=flat)](http://www.ubuntu.com/)
![Apache 2](https://img.shields.io/badge/license-Apache2-blue.svg?style=flat)

## Overview
A module for using libuv in Swift language.

## Versioning
Swift-libuv follows the semantic versioning scheme. The API change and backwards compatibility rules are those indicated by SemVer.

## Installation
You must build libuv before using the module.

```shell
$ git clone "https://github.com/Trevi-Swift/swift-libuv.git"
$ cd swift-libuv
$ make all
```

Or you can build and install libuv manually. But you modify `module.modulemap` in this case.

1. Clone [libuv](https://github.com/libuv/libuv.git)
2. `cd libuv`
3. `sh autogen.sh`
4. `./configure --prefix=/usr`
5. `make install` (with `sudo` as needed)
6. modify `module.modulemap` :
    ```swift
        module Libuv [system] {
            header "/usr/include/uv.h"
            link "uv"
            export *
        }
    ```


## Usage
Add dependency to your `Package.swift` file :

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "https://github.com/Trevi-Swift/swift-libuv.git", majorVersion: 1)
    ]
)
```

Then you can import the module and use `libuv` functions :

```swift
import Libuv

let loop = uv_default_loop()
uv_run(loop, UV_RUN_DEFAULT)
print("Event loop: \(loop)")
```

**Warning** : You may set the environment variable when executing after building.
```shell
$ export LD_LIBRARY_PATH=/path/to/module/lib:"$LD_LIBRARY_PATH"
```