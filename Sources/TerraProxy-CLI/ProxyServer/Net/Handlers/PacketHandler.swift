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

/// This is the type of data the `channelRead` method receives from NIO.
typealias InboundIn = ByteBuffer

/// Packet Structure
/// Offset  |  Type  |  Description
///   0       Int32    Message Length
///   1       Byte     Message Type
///   2        *       Payload
/// ----------------------------------
/// new byte[] { 0, 0, 1 }
func HandlePacket(channel: Channel, bb: InboundIn, connection: PlayerConnection){
    let packet: Packet = Packet(packet: bb)
    
    switch packet.getType(){
    case PacketType.ConnectRequest:
        print("Packet type: \(packet.getType())")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.PlayerInfo:
        print("Packet type: \(packet.getType())")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.InventorySlot:
        print("Packet type: \(packet.getType())")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.RequestWorldInfo:
        print("Client Requested World Information")
        print("Packet type: \(packet.getType())")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.LoadNetModule:
        let nmPacket = PacketNetModule(packet: bb)
        print("Packet type: \(nmPacket.getType())")
        print("NetModule Packet Bytes: \(nmPacket.packetBytes)")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    default:
        print("Packet type: \(packet.getType())")
        /*if let s = bb.getString(at: bb.readerIndex, length: bb.readableBytes) {
            print("Got #\(bb.readableBytes) bytes:", s)
        }
        else {
            print("Got #\(bb.readableBytes) bytes:", bb)
        }*/
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    }
}
