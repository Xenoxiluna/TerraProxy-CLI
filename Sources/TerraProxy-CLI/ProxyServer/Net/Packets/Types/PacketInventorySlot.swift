//
//  PacketInventorySlot.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

/// Payload Structure
/// Offset  |  Type  |  Description
///   1        UInt8    playerId
///   2        UInt8    slot
///   3-4     UInt16  stack
///   5        UInt8    prefix
///   6-7     UInt16  itemId
///
/// ----------------------------------
class PacketInventorySlot: Packet{
    public var pid: UInt8 = 0
    public var slot: UInt8 = 0
    public var stack: UInt16 = 0
    public var prefix: UInt8 = 0
    public var itemId: UInt16 = 0
    
    override init(packet: Data) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.pid = try reader.readUInt8()
        self.slot = try reader.readUInt8()
        self.stack = try reader.readUInt16()
        self.prefix = try reader.readUInt8()
        self.itemId = try reader.readUInt16()
    }
    
    override init(packet: Packet) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.pid = try reader.readUInt8()
        self.slot = try reader.readUInt8()
        self.stack = try reader.readUInt16()
        self.prefix = try reader.readUInt8()
        self.itemId = try reader.readUInt16()
    }
}
