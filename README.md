# AYINetwork

[![CI Status](https://img.shields.io/travis/aaayia/AYINetwork.svg?style=flat)](https://travis-ci.org/aaayia/AYINetwork)
[![Version](https://img.shields.io/cocoapods/v/AYINetwork.svg?style=flat)](https://cocoapods.org/pods/AYINetwork)
[![License](https://img.shields.io/cocoapods/l/AYINetwork.svg?style=flat)](https://cocoapods.org/pods/AYINetwork)
[![Platform](https://img.shields.io/cocoapods/p/AYINetwork.svg?style=flat)](https://cocoapods.org/pods/AYINetwork)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

swift='3.2'

## Installation

AYINetwork is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AYINetwork'
```
## Example
```swift
struct HTTPTarget: WKTarget {
    var baseURLString: String { return "http://127.0.0.1:8000" }
    var headers: [String : String] = [:]
}

class LoginRequest: WKRequest {
    let username = "zhangsan"
    let password = "12345678" 
    override func loadRequest() {
        super.loadRequest()
        self.path = "/login"
        self.method = .post
    }
}

struct User: Decodable {
    var id: Int
    var name: String
    var token: String
}

HTTPNetwork.request(LoginRequest()) { (response) in
            if let user = response.decode(to:User.self) {   
            }else if response.error != nil {
                //show error
            }
        }
```
## Author

aaayia, twilightzzy@126.com

## License

AYINetwork is available under the MIT license. See the LICENSE file for more info.


