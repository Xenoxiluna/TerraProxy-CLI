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

func HandlePacket(channel: Channel, bb: InboundIn, connection: PlayerConnection) {
    guard let packet: Packet = try? Packet(packet: Data(bb.getBytes(at: 0, length: bb.readableBytes)!)) else{
        print("Unable to parse Packet")
        channel.writeAndFlush(NIOAny.init(bb))
        return
    }
    
    switch packet.getType(){
    case PacketType.ConnectRequest:
        guard let crPacket = try? PacketConnectionRequest(packet: packet) else {
            print("Packet type: \(packet.getType())")
            print("Unable to parse Packet")
            channel.writeAndFlush(NIOAny.init(bb))
            return
        }
        print("Packet type: \(crPacket.getType())")
        print("Client version: \(crPacket.version)")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.PlayerInfo:
        guard let piPacket = try? PacketPlayerInfo(packet: packet) else {
            print("Packet type: \(packet.getType())")
            print("Unable to parse Packet")
            channel.writeAndFlush(NIOAny.init(bb))
            return
        }
        print("Packet type: \(piPacket.getType())")
        print("Character Name: \(piPacket.name)")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.InventorySlot:
        guard let iPacket = try? PacketInventorySlot(packet: packet) else {
            print("Packet type: \(packet.getType())")
            print("Unable to parse Packet")
            channel.writeAndFlush(NIOAny.init(bb))
            return
        }
        print("Packet type: \(iPacket.getType())")
        print("Item ID: \(iPacket.itemId)")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.PlayerHp:
        guard let psPacket = try? PacketPlayerHp(packet: packet) else {
            print("Packet type: \(packet.getType())")
            print("Unable to parse Packet")
            channel.writeAndFlush(NIOAny.init(bb))
            return
        }
        print("Packet type: \(psPacket.getType())")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.PlayerBuff:
        guard let psPacket = try? PacketPlayerBuff(packet: packet) else {
            print("Packet type: \(packet.getType())")
            print("Unable to parse Packet")
            channel.writeAndFlush(NIOAny.init(bb))
            return
        }
        print("Packet type: \(psPacket.getType())")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.PlayerMana:
        guard let psPacket = try? PacketPlayerMana(packet: packet) else {
            print("Packet type: \(packet.getType())")
            print("Unable to parse Packet")
            channel.writeAndFlush(NIOAny.init(bb))
            return
        }
        print("Packet type: \(psPacket.getType())")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.RequestWorldInfo:
        guard let wiPacket = try? PacketWorldInfo(packet: packet) else {
            print("Packet type: \(packet.getType())")
            print("WorldInfo Packet Bytes: \(packet.allPacketBytes)")
            print("Unable to parse Packet")
            channel.writeAndFlush(NIOAny.init(bb))
            return
        }
        print("Packet type: \(wiPacket.getType())")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.TileGetSection:
        guard let iPacket = try? PacketTileGetSection(packet: packet) else {
            print("Packet type: \(packet.getType())")
            print("Unable to parse Packet")
            channel.writeAndFlush(NIOAny.init(bb))
            return
        }
        print("Packet type: \(iPacket.getType())")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.Zones:
        guard let zPacket = try? PacketZones(packet: packet) else {
            print("Packet type: \(packet.getType())")
            print("Unable to parse Packet")
            channel.writeAndFlush(NIOAny.init(bb))
            return
        }
        print("Packet type: \(zPacket.getType())")
        print("Zones Packet Bytes: \(packet.allPacketBytes)")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.PlayerSpawn:
        guard let psPacket = try? PacketPlayerSpawn(packet: packet) else {
            print("Packet type: \(packet.getType())")
            print("Unable to parse Packet")
            channel.writeAndFlush(NIOAny.init(bb))
            return
        }
        print("Packet type: \(psPacket.getType())")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.PlayerUpdate:
        guard let puPacket = try? PacketPlayerUpdate(packet: packet) else {
            print("Packet type: \(packet.getType())")
            print("Unable to parse Packet")
            print("PlayerUpdate Packet Bytes: \(packet.allPacketBytes)")
            channel.writeAndFlush(NIOAny.init(bb))
            return
        }
        print("Packet type: \(puPacket.getType())")
        print("PlayerUpdate velocity y: \(puPacket.velx)")
        print("PlayerUpdate velocity y: \(puPacket.vely)")
        print("PlayerUpdate Packet Bytes: \(puPacket.allPacketBytes)")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.PlayerDamage:
        guard let pdPacket = try? PacketPlayerDamage(packet: packet) else {
            print("Packet type: \(packet.getType())")
            print("Unable to parse Packet")
            channel.writeAndFlush(NIOAny.init(bb))
            return
        }
        print("Packet type: \(pdPacket.getType())")
        print("PlayerUpdate Packet Bytes: \(pdPacket.allPacketBytes)")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    case PacketType.LoadNetModule:
        guard let nmPacket = try? PacketNetModule(packet: packet) else {
            print("Packet type: \(packet.getType())")
            print("Unable to parse Packet")
            channel.writeAndFlush(NIOAny.init(bb))
            return
        }
        print("Packet type: \(nmPacket.getType())")
        print("NetModule Command: \(nmPacket.command)")
        print("NetModule Mesage: \(nmPacket.message)")
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    default:
        print("Packet type: \(packet.getType())")
        print("Packet Bytes: \(packet.allPacketBytes)")
        /*if let s = bb.getString(at: bb.readerIndex, length: bb.readableBytes) {
            print("Got #\(bb.readableBytes) bytes:", s)
        }
        else {
            print("Got #\(bb.readableBytes) bytes:", bb)
        }*/
        channel.writeAndFlush(NIOAny.init(bb), promise: nil)
    }
}
