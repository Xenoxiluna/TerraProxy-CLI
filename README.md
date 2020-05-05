# WORK IN PROGRESS
# `TerraProxy-CLI`
  Terraria Proxy Server

 ## Usage
 From terminal, run the following:
 
 `TerraProxy-CLI --proxy-target <IP or Hostname> --target-port <port> --proxy-source <IP or Hostname> --source-port <port>`
 
 For example:
 This will proxy your connection to the terraria server at terraserver.com on port 7777(terraserver.com:7777). Proxy source is the local ip in which the proxy server is running on. 
 
 `TerraProxy-CLI --proxy-target terraserver.com --target-port 7777 --proxy-source 127.0.0.1 --source-port 7777`
 
 When in game, you would connect to 127.0.0.1 on port 7777
 
 ## Dependencies

- [Swift-NIO v2.16.0](https://github.com/apple/swift-nio)
- [Swift-Log 1.2.0](https://github.com/apple/swift-log)
- [Swift-Argument-Parser 0.0.5](https://github.com/apple/swift-argument-parser)
- [BinarySwift](https://github.com/Szaq/BinarySwift)

 ## Building
 To build on linux:
 
 `git clone https://github.com/Xenoxiluna/TerraProxy-CLI.git
 cd TerraProxy-CLI
 swift build`

 ## License

 `TerraProxy-CLI` is licensed under the [MIT License](LICENSE)
