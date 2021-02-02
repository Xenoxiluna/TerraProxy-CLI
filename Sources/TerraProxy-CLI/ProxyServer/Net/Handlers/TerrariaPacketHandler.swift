//
//  TerrariaPacketHandler.swift
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
    
    private var connection: PlayerConnection
    private var packetDirection: TerrariaPacketContext
    
    public init(_ packetDirection: TerrariaPacketContext, _ playerConnection: PlayerConnection){
        self.packetDirection = packetDirection
        self.connection = playerConnection
    }
    
    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let bb = self.unwrapInboundIn(data)
        HandlePacket(context: context, bb: bb, connection: self.connection, self.packetDirection)
    }
    
    private func HandlePacket(context: ChannelHandlerContext, bb: InboundIn, connection: PlayerConnection, _ direction: TerrariaPacketContext) {
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
            try packet.decode(direction)
            print("Decode Successful on \(packet.getType()) for Player '\(connection.playerId):\(connection.playerName)'!")
        }catch{
            print("Decode failed on \(packet.getType()) for Player '\(connection.playerId):\(connection.playerName)'...")
            print("")
            context.fireChannelRead(NIOAny.init(bb))
            return
        }
        
        switch packet.getType(){
        case TerrariaPacketType.ConnectApproval:
            if connection.getConnectionState() == .Login {
                let appPacket = packet as! PacketConnectApproval
                connection.setPlayerId(Int(appPacket.playerId))
            }
            print("")
        case TerrariaPacketType.PlayerInfo:
            if connection.getConnectionState() == .Login {
                let appPacket = packet as! PacketPlayerInfo
                connection.playerName = appPacket.name
            }
            print("")
        case TerrariaPacketType.PlayerSpawnSelf:
            connection.setConnectionState(.InGame)
        case TerrariaPacketType.LoadNetModule:
            var appPacket = packet as! PacketLoadNetModule
            switch appPacket.netModuleType{
            case .Chat:
                let nmData = appPacket.netModule as! NetModuleChat
                if direction == .ClientToServer{
                    print("Chat Message: \(appPacket.context) - \(connection.playerName) - \(connection.playerId) - \(type(of: nmData.commandData)) - \((nmData.commandData as! NetModuleChat.ClientMsg).message)")
                }
            default:
                print("")
            }
        default:
            print("")
        }
        
        context.fireChannelRead(NIOAny.init(bb))
    }
    
    private func debugPacketInfo(_ packet: TerrariaPacket, _ connection: PlayerConnection, _ direction: TerrariaPacketContext){
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
