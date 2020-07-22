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

class PlayerConnection {
    var LAST_PLAYER_ID: Int = 0
    var playerId: Int
    var playerName: String = ""
    var channel: Channel?
    var phase: PlayerConnectionState?

    init(){
        self.playerId = self.LAST_PLAYER_ID + 1
        self.channel = nil
        self.phase = nil
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
    
    func setPlayerId(playerId: Int) {
        self.playerId = playerId
    }

    func getPhase() -> PlayerConnectionState {
        return phase!
    }

    func setPhase(state: PlayerConnectionState) {
        phase = state
    }
}
