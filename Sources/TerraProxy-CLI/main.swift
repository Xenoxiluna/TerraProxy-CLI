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

struct Proxy: ParsableCommand {
    @Option(help: "IP Address of the server you are connecting to.")
    var proxyTarget: String
    
    @Option(help: "Port of the server you are connecting to.")
    var targetPort: Int
    
    @Option(help: "IP Address of the proxy server.")
    var proxySource: String
    
    @Option(help: "Port of the proxy server.")
    var sourcePort: Int
    
    @Flag(help: "Start proxy with debug logs")
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
        if debugMode{
            logger.logLevel = .debug
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
        
        print("Welcome to TerraProxy!")
        print("Type 'help' for a list of commands")
        var shouldQuit = false
        while !shouldQuit{
            print("Please enter a command: ")
            let input = getInput()
            switch input{
            case "start":
                let proxy  = ProxyServer(source: source, target: target, logger: logger)
                proxy.start { result in
                    switch result {
                        case .failure(let error):
                            logger.error("Failed to start proxy server: \(error)")
                        case .success:
                            logger.info("Proxy Server Started: \(source) <--> \(target)")
                    }
                }
            case "quit":
                proxy.stop(then: { result in
                    switch result {
                        case .some(let error):
                            logger.error("Failed to stop proxy server: \(error)")
                        default:
                            logger.info("Proxy Server stopped!")
                    }
                })
                shouldQuit = true
            case "loglevel":
                print("Not Implemented")
                print(logger.logLevel)
            case "help":
                print("""
                Command List:
                help
                loglevel
                start
                quit

                """)
            default:
                print("Command not recognized!")
            }
        }
        //RunLoop.main.run()
    }
}

/*struct Info: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line proxy tool for Terraria",
        subcommands: [Proxy.self])

    init() { }
}*/

func getInput() -> String {
  let keyboard = FileHandle.standardInput
  let inputData = keyboard.availableData
  let strData = String(data: inputData, encoding: String.Encoding.utf8)!
  return strData.trimmingCharacters(in: CharacterSet.newlines)
}

//Info.main()
Proxy.main()
