//
//  PlayerConnection.swift
//  TerrariaProxyServer
//
//  Created by Quentin Berry on 4/14/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation
import NIO
import NIOHTTP1

internal class PlayerConnection {
    var playerId: Int = 255
    var playerName: String = ""
    var channel: Channel?
    var state: PlayerConnectionState = .Login

    init(){}
    
    init(_ playerId: Int){
        self.playerId = playerId
    }

    func setChannel(channel: Channel) {
        self.channel = channel
    }

    /*func sendPacket(packet: Packet) {
        self.channel!.writeAndFlush(NIOAny.init(packet))
    }

    func sendPackets(packets: [Packet]) {
        for packet in packets {
            self.channel!.write(NIOAny(packet))
        }
        self.channel!.flush()
    }*/

    func getContext() -> Channel {
        return self.channel!
    }

    func getPlayerId() -> Int {
        return playerId
    }
    
    func setPlayerId(_ playerId: Int) {
        self.playerId = playerId
    }
}
