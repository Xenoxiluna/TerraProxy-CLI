//
//  PacketHandler.swift
//  TerrariaProxyServer
//
//  Created by Quentin Berry on 4/13/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation
import NIO
import NIOHTTP1
import XTerraPacket

/// This is the type of data the `channelRead` method receives from NIO.
typealias InboundIn = ByteBuffer

func HandlePacket(channel: Channel, bb: InboundIn, connection: PlayerConnection) {
    
    let packetData = bb.getBytes(at: 0, length: bb.readableBytes)!
    guard var packet = try? TerrariaPacketFactory.decodePacket(packet: packetData) else {
        print("Parse failed!")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
        return
    }
    print("Swift Packet type: \(type(of: packet))")
    print("Packet Type: \(packet.getType())")
    
    do{
        try packet.decode()
    }catch{
        print("Decode failed...")
    }
    channel.writeAndFlush(NIOAny.init(bb), promise: nil)
}
