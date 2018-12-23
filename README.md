# YCPortForwarder

[![Version](https://img.shields.io/cocoapods/v/YCPortForwarder.svg?style=flat)](https://cocoapods.org/pods/YCPortForwarder)
[![License](https://img.shields.io/cocoapods/l/YCPortForwarder.svg?style=flat)](https://cocoapods.org/pods/YCPortForwarder)
[![Platform](https://img.shields.io/cocoapods/p/YCPortForwarder.svg?style=flat)](https://cocoapods.org/pods/YCPortForwarder)

## Features

  A simple tcp package forwarder example using CocoaAsyncSocket. Help you to get konwn about the data flow though the specify port.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
Swift 4.2

## Installation

YCPortForwarder is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YCPortForwarder'
```

## Forwarding With TCP
```swift

fordwarder = YCPortForwarder(remoteHost: "192.168.1.1", remotePort: 22, toPort: 8888)
if let localPort = fordwarder?.start() {
    print("127.0.0.1:\(localPort) <===> 192.168.1.1:22")
}

```

## TODO

- [ ] UDP support
- [ ] Objc support


## Author

yicheng,yicheng.fzu@gmail.com

## License

YCPortForwarder is available under the MIT license. See the LICENSE file for more info.
