//
//  PacketPlayerSpawn.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

/// Payload Structure
/// Offset  |  Type  |  Description
///   1        UInt8    playerId
///   2-3     UInt16  spawnX
///   4-5     UInt16  spawnY
///
/// ----------------------------------
class PacketPlayerSpawn: Packet{
    public var playerId: UInt8 = 0
    public var spawnX: UInt16 = 0
    public var spawnY: UInt16 = 0
    
    override init(packet: Data) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.spawnX = try reader.readUInt16()
        self.spawnY = try reader.readUInt16()
    }
    
    override init(packet: Packet) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.spawnX = try reader.readUInt16()
        self.spawnY = try reader.readUInt16()
    }
}
