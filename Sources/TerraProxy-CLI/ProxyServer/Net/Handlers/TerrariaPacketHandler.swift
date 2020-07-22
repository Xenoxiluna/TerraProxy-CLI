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

class TerrariaPacketHandler: ChannelInboundHandler{
    typealias InboundIn = ByteBuffer
    
    private var connection: PlayerConnection = PlayerConnection()
    private var packetDirection: PacketDirection = .none
    
    public init(){}
    
    public init(_ packetDirection: PacketDirection){
        self.packetDirection = packetDirection
    }
    
    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let bb = self.unwrapInboundIn(data)
        HandlePacket(context: context, bb: bb, connection: self.connection, self.packetDirection)
    }
    
    private func HandlePacket(context: ChannelHandlerContext, bb: InboundIn, connection: PlayerConnection, _ direction: PacketDirection) {
        let packetData = bb.getBytes(at: 0, length: bb.readableBytes)!
        if packetData[0] > packetData.count{
            print("INVALID PACKET! \(direction)")
            print("Invalid Packet Bytes: \(packetData))")
            context.fireChannelRead(NIOAny.init(bb))
            return
        }
        
        guard var packet = try? TerrariaPacketFactory.decodePacket(packet: packetData) else {
            print("Parse failed! \(direction)")
            print("Failed bytes: \(packetData))")
            print("")
            context.fireChannelRead(NIOAny.init(bb))
            return
        }
        
        debugPacketInfo(packet, connection, direction)
        
        do{
            try packet.decode()
            print("Decode Successful on \(packet.getType()) for Player '\(connection.playerId):\(connection.playerName)'!")
        }catch{
            print("Decode failed on \(packet.getType()) for Player '\(connection.playerId):\(connection.playerName)'...")
            print("")
            context.fireChannelRead(NIOAny.init(bb))
            return
        }
        
        switch packet.getType(){
        case TerrariaPacketType.ConnectApproval:
            let appPacket = packet as! PacketConnectApproval
            connection.setPlayerId(playerId: Int(appPacket.playerId))
            print("")
        case TerrariaPacketType.PlayerInfo:
            let appPacket = packet as! PacketPlayerInfo
            connection.playerName = appPacket.name
            print("")
        default:
            print("")
        }
        
        context.fireChannelRead(NIOAny.init(bb))
    }
    
    private func debugPacketInfo(_ packet: TerrariaPacket, _ connection: PlayerConnection, _ direction: PacketDirection){
        /**
                TODO
        Split packets like the following:
        Swift Packet type: PacketPlayerInventorySlot
        Packet Type: PlayerInventorySlot
        Decoded Packet Bytes: [11, 0, 5, 0, 23, 0, 4, 0, 0, 226, 13, 11, 0, 5, 0, 24, 0, 1, 0, 0, 24, 5])
        
        Decoded Packet Bytes: [11, 0, 5, 0, 26, 0, 6, 0, 0, 56, 11, 11, 0, 5, 0, 27, 0, 1, 0, 81, 215, 13])
        
        Swift Packet type: PacketItemOwner
        Packet Type: ItemOwner
        Decoded Packet Bytes: [6, 0, 22, 34, 0, 0, 27, 0, 21, 37, 0, 0, 0, 129, 71, 0, 32, 216, 69, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 184, 0, 6, 0, 22, 37, 0, 0, 27, 0, 21, 38, 0, 3, 158, 129, 71, 0, 48, 215, 69, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 71, 0, 6, 0, 22, 38, 0, 0, 27, 0, 21, 52, 0, 125, 200, 130, 71, 0, 48, 215, 69, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 6, 0, 22, 52, 0, 0])
        
        Swift Packet type: PacketItemDrop
        Packet Type: ItemDrop
        Decoded Packet Bytes: [27, 0, 21, 14, 0, 193, 166, 131, 71, 0, 32, 214, 69, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 23, 0, 6, 0, 22, 14, 0, 0, 27, 0, 21, 18, 0, 19, 143, 131, 71, 0, 48, 214, 69, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 71, 0, 6, 0, 22, 18, 0, 0, 27, 0, 21, 25, 0, 49, 67, 133, 71, 0, 208, 213, 69, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 57, 1, 6, 0, 22, 25, 0, 0, 27, 0, 21, 26, 0, 0, 89, 133, 71, 0, 16, 214, 69, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 51, 1, 6, 0])

        Parse failed!
        Failed bytes: [22, 26, 0, 0, 27, 0, 21, 29, 0, 27, 155, 133, 71, 0, 240, 213, 69, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 5, 0, 6, 0, 22, 29, 0, 0, 27, 0, 21, 32, 0, 163, 202, 133, 71, 0, 32, 214, 69, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 23, 0, 6, 0, 22, 32, 0, 0, 27, 0, 21, 33, 0, 11, 194, 133, 71, 0, 48, 214, 69, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 71, 0, 6, 0, 22, 33, 0, 0, 27, 0, 21, 34, 0, 19, 185, 133, 71, 0, 32, 214, 69, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0])
        */
        
        print("""
        Swift Packet type: \(type(of: packet))
        Packet Type: \(packet.getType())
        PlayerID: \(connection.playerId)
        PlayerName: \(connection.playerName)
        Direction: \(direction)
        Packet Bytes: \(packet.bytes)
        """)
    }

}
