//
//  main.swift
//  TerrariaProxyServer
//
//  Created by Quentin Berry on 5/4/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation
import ArgumentParser
import Logging

struct TerraProxy: ParsableCommand {
    @Option(help: "IP Address of the server you are connecting to.")
    var proxyTarget: String
    
    @Option(help: "Port of the server you are connecting to.")
    var targetPort: Int
    
    @Option(help: "IP Address of the proxy server.")
    var proxySource: String
    
    @Option(help: "Port of the proxy server.")
    var sourcePort: Int
    
    @Flag(help: "Start proxy in debug mode(NOT IMPLEMENTED)")
    var debugMode: Bool

    @Option(help: "Change logger label.")
    var loggerlabel: String?

    func run() throws {
        let target = HostInfo.ip(host: proxyTarget, port: targetPort)
        let source = HostInfo.ip(host: proxySource, port: sourcePort)
        
        var logger: Logger
        if let s = loggerlabel{
            logger = Logger(label: s)
        }else{
            logger = Logger(label: "com.example.TerraProxy-CLI.main")
        }
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
    }
}

TerraProxy.main()
