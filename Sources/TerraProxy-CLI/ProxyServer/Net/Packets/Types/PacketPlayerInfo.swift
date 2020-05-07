//
//  PacketPlayerInfo.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

/// Payload Structure
/// Offset  |  Type  |  Description
///   1        UInt8    playerId
///   2        UInt8    skinVariant
///   3        UInt8    hair
///   4-x     String   playernane
///   5        UInt8    hairDye
///   6        UInt8    hideVisuals
///   7        UInt8    hideVisuals2
///   8        UInt8    hideMisc
///   9-11   UInt8    hairColor
///   12-15 UInt8    playerId
///   16-19 UInt8    playerId
///   20-23 UInt8    playerId
///   24-27 UInt8    playerId
///   28-31 UInt8    playerId
///   32-35 UInt8    playerId
///   36      UInt8    playerId
///
/// ----------------------------------
class PacketPlayerInfo: Packet{
    public var playerId: UInt8 = 0
    public var skinVariant: UInt8 = 0
    public var hair: UInt8 = 0
    public var name: String = ""
    public var hairDye: UInt8 = 0
    public var hideVisuals: UInt8 = 0
    public var hideVisuals2: UInt8 = 0
    public var hideMisc: UInt8 = 0
    public var hairColor: [UInt8] = []
    public var skinColor: [UInt8] = []
    public var eyeColor: [UInt8] = []
    public var shirtColor: [UInt8] = []
    public var underShirtColor: [UInt8] = []
    public var pantsColor: [UInt8] = []
    public var shoeColor: [UInt8] = []
    public var difficulty: UInt8 = 0
    
    override init(packet: Data) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.skinVariant = try reader.readUInt8()
        self.hair = try reader.readUInt8()
        self.name = try reader.readNullTerminatedStringNoTrail()
        self.hairDye = try reader.readUInt8()
        self.hideVisuals = try reader.readUInt8()
        self.hideVisuals2 = try reader.readUInt8()
        self.hideMisc = try reader.readUInt8()
        self.hairColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.skinColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.eyeColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.shirtColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.underShirtColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.pantsColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.shoeColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.difficulty = try reader.readUInt8()
    }
    
    override init(packet: Packet) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.skinVariant = try reader.readUInt8()
        self.hair = try reader.readUInt8()
        self.name = try reader.readNullTerminatedStringNoTrail()
        self.hairDye = try reader.readUInt8()
        self.hideVisuals = try reader.readUInt8()
        self.hideVisuals2 = try reader.readUInt8()
        self.hideMisc = try reader.readUInt8()
        self.hairColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.skinColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.eyeColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.shirtColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.underShirtColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.pantsColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.shoeColor = [try reader.readUInt8(),try reader.readUInt8(),try reader.readUInt8()]
        self.difficulty = try reader.readUInt8()
    }
}
