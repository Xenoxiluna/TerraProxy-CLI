//
//  ProxySourceInbound.swift
//  TerrariaProxyServer
//
//  Created by Quentin Berry on 5/4/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//
import Foundation
import NIO
import Logging

class ProxySourceInBound : ChannelInboundHandler {
	
	public typealias InboundIn   = ByteBuffer
	public typealias OutboundOut = ByteBuffer


	private let group: MultiThreadedEventLoopGroup
	private let target: HostInfo
	private let logger: Logger
	private var connectionState : ConnectionState
    private var playerConnection: PlayerConnection
	private var channels: [ObjectIdentifier : Channel] = [:]
	
	private let channelsSyncQueue = DispatchQueue(label: "channelsQueue")
	
    public init(group: MultiThreadedEventLoopGroup, target: HostInfo, logger: Logger, playerConnection: PlayerConnection) {
		self.group = group
		self.target = target
		self.logger = logger
		self.connectionState = .idle
        self.playerConnection = playerConnection
	}

	public func channelActive(context: ChannelHandlerContext) {
		let source = context.channel
        
		if let s = source.localAddress{
			self.logger.info("Incoming connection: \(s.ipAddress!):\(s.port!)")
		}
	}

	public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
		let id = ObjectIdentifier(context.channel)
		switch connectionState {
		case .idle:
		    self.handleInitialData(context: context, data: data)
		case .beganConnecting:
		    break
		case .connected:
		    channelsSyncQueue.async {
                if let channel = self.channels[id] {
                    _ = channel.writeAndFlush(data)
                }
		    }
		}
	}

	public func channelInactive(context: ChannelHandlerContext) {
		let id = ObjectIdentifier(context.channel)
		self.channelsSyncQueue.async {
            if let channel = self.channels[id] {
                if let s = channel.localAddress{
                        self.logger.info("Closing connection: \(s.ipAddress!):\(s.port!)")
                }
                channel.close(mode: .all, promise: nil)
            }
        }
	}
    
    private func handleInitialData(context: ChannelHandlerContext, data: NIOAny) {
        self.connectionState = .beganConnecting
        let source = context.channel
        let id     = ObjectIdentifier(context.channel)

        let bootstrap = ClientBootstrap(group: self.group)
            .channelOption(ChannelOptions.socket(SocketOptionLevel(SOL_SOCKET), SO_REUSEADDR), value: 1)
            .channelInitializer { channel in
                channel.pipeline.addHandlers([ByteToMessageHandler(FrameDecoder()), TerrariaPacketHandler(.ServerToClient, self.playerConnection)]).flatMap{ _ in
                    channel.pipeline.addHandler( ProxyTargetInBound(group: self.group, source: source, logger: self.logger) )
                }
            }

        let completion = { (result: Result<Channel,Error>) in
            switch result {
                case .failure(let error):
                    print(error)
                
                case .success(let channel):
                    self.channelsSyncQueue.async {
                        if let s = channel.localAddress{
                            self.logger.info("Connection Successful: \(s.ipAddress!):\(s.port!)")
                        }
                        self.channels[id] = channel
                        self.connectionState = .connected
                        _ = channel.writeAndFlush(data)
                    }
            }
        }
        
        switch target {
            case .ip(host: let host, port: let port):
                bootstrap.connect(host: host, port: port).whenComplete(completion)
            
            case .unixDomainSocket(path: let path):
                bootstrap.connect(unixDomainSocketPath: path).whenComplete(completion)
        }
    }
}
