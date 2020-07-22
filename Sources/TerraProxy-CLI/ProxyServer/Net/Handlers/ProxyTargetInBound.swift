//
//  ProxyTargetInBound.swift
//  TerrariaProxyServer
//
//  Created by Quentin Berry on 5/4/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//
import Foundation
import NIO
import Logging

class ProxyTargetInBound : ChannelInboundHandler {
	
	public typealias InboundIn   = ByteBuffer
	public typealias OutboundOut = ByteBuffer

	let group       : MultiThreadedEventLoopGroup
	let source      : Channel
	let logger      : Logger
	
    public init(group: MultiThreadedEventLoopGroup, source: Channel, logger: Logger) {
		self.group       = group
		self.source      = source
		self.logger      = logger
	}
	
	public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
		_ = source.writeAndFlush(data)
	}
	
	public func channelInactive(context: ChannelHandlerContext) {
		source.close(mode: .all, promise: nil)
	}
}
