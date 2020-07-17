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
    if packetData[0] != packetData.count{
        print("INVALID PACKET!")
        print("INVALID BYTES: \(packetData))")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
        return
    }
    guard var packet = try? TerrariaPacketFactory.decodePacket(packet: packetData) else {
        print("Parse failed!")
        print("Failed bytes: \(packetData))")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
        return
    }
    
    print("Swift Packet type: \(type(of: packet))")
    print("Packet Type: \(packet.getType())")
    
    do{
        try packet.decode()
        print("Decoded Packet Bytes: \(packet.bytes))")
    }catch{
        print("Decode failed...")
        print("Failed Packet Bytes: \(packet.bytes))")
        return
    }
    
    switch packet.getType(){
    case TerrariaPacketType.ConnectApproval:
        let appPacket = packet as! PacketConnectApproval
        connection.setPlayerId(playerId: Int(appPacket.playerId))
    default:
        print("")
    }
    
    channel.writeAndFlush(NIOAny.init(bb), promise: nil)
}
