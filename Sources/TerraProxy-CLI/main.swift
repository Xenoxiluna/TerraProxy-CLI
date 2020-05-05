//
//  main.swift
//  TerrariaProxyServer
//
//  Created by Quentin Berry on 5/4/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation
import Logging

let target = HostInfo.ip(host: "10.0.0.24", port: 7777)
let source = HostInfo.ip(host: "127.0.0.1", port: 7777)
let logger = Logger(label: "com.example.TerraProxy-CLI.main")
let proxy  = ProxyServer(source: source, target: target, logger: logger)

proxy.start { result in
    switch result {
        case .failure(let error):
            logger.error("Failed to start proxy server: \(error)")
        case .success:
            logger.info("Proxy Server Started: \(source) <--> \(target)")
    }
}
RunLoop.main.run()
