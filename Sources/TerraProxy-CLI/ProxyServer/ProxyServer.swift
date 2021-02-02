//
//  ProxyServer.swift
//  TerrariaProxyServer
//
//  Created by Quentin Berry on 5/4/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation
import NIO
import Logging

public class ProxyServer {
	let group: MultiThreadedEventLoopGroup
	let source: HostInfo
	let target: HostInfo
    let logger: Logger
	
    public init(source: HostInfo, target: HostInfo, logger: Logger, group: MultiThreadedEventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)) {
		self.source = source
		self.target = target
		self.group = group
        self.logger = logger
	}
	
	public func start(then complete: @escaping (Result<Void,Error>) -> Void) {
        self.logger.info("Initializing proxy...")
		let bootstrap = ServerBootstrap(group: group)
			.serverChannelOption(ChannelOptions.backlog, value: 256)
			.serverChannelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
			.childChannelInitializer { channel in
                channel.pipeline.addHandlers(self.createHandlers())
			}
			.childChannelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
			.childChannelOption(ChannelOptions.maxMessagesPerRead, value: 16)
			.childChannelOption(ChannelOptions.recvAllocator, value: AdaptiveRecvByteBufferAllocator())
		
        self.logger.info("Proxy Initialized!")
        
		let completion = { (result: Result<Channel,Error>) in
			switch result {
				case .failure(let error):
                    complete(.failure(error))
				case .success:
                    complete(.success(()))
			}
		}
		
		switch source {
			case .ip(host: let host, port: let port): bootstrap.bind(host: host, port: port).whenComplete(completion)
			case .unixDomainSocket(path: let path): bootstrap.bind(unixDomainSocketPath: path).whenComplete(completion)
		}
	}
	
	public func stop(then complete: @escaping (Error?) -> Void) {
        self.logger.info("Stopping proxy server...")
		group.shutdownGracefully(queue: DispatchQueue.main, complete)
	}
    
    private func createHandlers() -> [ChannelHandler]{
        let playerConn: PlayerConnection = PlayerConnection()
        
        return [ByteToMessageHandler(FrameDecoder()), TerrariaPacketHandler(.ClientToServer, playerConn), ProxySourceInBound(group: self.group, target: self.target, logger: self.logger, playerConnection: playerConn)]
    }
}
