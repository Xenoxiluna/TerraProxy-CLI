//
//  PacketPlayerBuff.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

/// Payload Structure
/// Offset  |  Type  |  Description
///   1        UInt8    playerId
///   2-3     UInt16  life
///   4-5     UInt16  maxLife
///
/// ----------------------------------
class PacketPlayerBuff: Packet{
    private let MAX_BUFFS = 22
    
    public var playerId: UInt8 = 0
    public var buffs: [UInt8] = []
    
    override init(packet: Data) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        
        self.playerId = try reader.readUInt8()
        
        for _ in 0..<self.MAX_BUFFS{
            buffs += [try reader.readUInt8()]
        }
    }
    
    override init(packet: Packet) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        
        self.playerId = try reader.readUInt8()
        
        for _ in 0..<self.MAX_BUFFS{
            buffs += [try reader.readUInt8()]
        }
    }
}
