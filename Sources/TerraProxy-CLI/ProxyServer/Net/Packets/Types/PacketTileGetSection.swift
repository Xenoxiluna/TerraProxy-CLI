//
//  PacketTileGetSection.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

/// Payload Structure
/// Offset  |  Type  |  Description
///   1-4        UInt32    x
///   5-8        UInt32    y
///
/// ----------------------------------
class PacketTileGetSection: Packet{
    public var x: UInt32 = 0
    public var y: UInt32 = 0
    
    override init(packet: Data) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.x = try reader.readUInt32()
        self.y = try reader.readUInt32()
    }
    
    override init(packet: Packet) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.x = try reader.readUInt32()
        self.y = try reader.readUInt32()
    }
}
