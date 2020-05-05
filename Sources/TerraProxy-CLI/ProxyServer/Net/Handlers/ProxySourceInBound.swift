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


	private let group           : MultiThreadedEventLoopGroup
	private let target          : HostInfo
    private let logger          : Logger
    private var connectionState : ConnectionState
	private var channels        : [ObjectIdentifier : Channel] = [:]
	
    private var connection: PlayerConnection = PlayerConnection()
	private let channelsSyncQueue = DispatchQueue(label: "channelsQueue")
	
	let targetIntercept : [ChannelHandler]
	
    public init(group: MultiThreadedEventLoopGroup, target: HostInfo, logger: Logger, targetIntercept:[ChannelHandler] = []) {
		self.group           = group
		self.target          = target
		self.targetIntercept = targetIntercept
        self.logger          = logger
        self.connectionState = .idle
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
                    let bb = self.unwrapInboundIn(data)
                    HandlePacket(channel: channel, bb: bb, connection: self.connection)
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
                channel.pipeline.addHandlers(self.targetIntercept).flatMap{ _ in
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
                        self.connection.setChannel(channel: channel)
                        self.connectionState = .connected
                        //_ = channel.writeAndFlush(data)
                        let bb = self.unwrapInboundIn(data)
                        HandlePacket(channel: channel, bb: bb, connection: self.connection)
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
