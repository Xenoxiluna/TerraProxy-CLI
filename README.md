# WORK IN PROGRESS
# `TerraProxy-CLI`
Terraria Proxy Server built with the intention of modifying packets on the fly. It currently does nothing but identify and display all packets that go through it. The proxy is asynchronous thanks to SwiftNIO and can support multiple users.
  
### You can find Binaries under [Releases](https://github.com/Xenoxiluna/TerraProxy-CLI/releases) if available.

## Compatibility
| OS |
|---|
| macOS 10.15.X |
| Ubuntu 18.04 X86-64bit |
| Ubuntu 18.04 ARM64/32 |

 ## Usage
 From terminal, run the following:
 
 `TerraProxy-CLI --proxy-target <IP or Hostname> --target-port <port> --proxy-source <IP or Hostname> --source-port <port>`
 
 For example:
 This will proxy your connection to the terraria server at terraserver.com on port 7777(terraserver.com:7777). Proxy source is the local ip in which the proxy server is running on. 
 
 `TerraProxy-CLI --proxy-target terraserver.com --target-port 7777 --proxy-source 127.0.0.1 --source-port 7777`
 
 When in game, you would connect to 127.0.0.1 on port 7777
 
 ## Dependencies

- [Swift-NIO v2.22.0](https://github.com/apple/swift-nio)
- [Swift-Log 1.4.0](https://github.com/apple/swift-log)
- [Swift-Argument-Parser 0.0.6](https://github.com/apple/swift-argument-parser)
- [SwiftyBytes 0.4.3](https://github.com/Xenoxiluna/SwiftyBytes)
- [XTerraPacket 0.7.1](https://github.com/Xenoxiluna/XTerraPacket)

 ## Building
 To build on linux & macOS:
 
 git clone https://github.com/Xenoxiluna/TerraProxy-CLI.git<br/>
 cd TerraProxy-CLI<br/>
 swift build

 ## License

 `TerraProxy-CLI` is licensed under the [MIT License](LICENSE)
