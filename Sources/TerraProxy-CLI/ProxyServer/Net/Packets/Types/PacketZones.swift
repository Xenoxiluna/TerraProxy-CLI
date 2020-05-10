//
//  PacketZones.swift
//  
//
//  Created by Quentin Berry on 5/10/20.
//

import Foundation
import SwiftyBytes

/// Payload Structure
/// Offset  |  Type  |  Description
///   1-4        UInt32    x
///   5-8        UInt32    y
///
/// ----------------------------------
class PacketZones: Packet{
    public var s1: UInt8 = 0
    public var s2: UInt16 = 0
    public var s3: UInt16 = 0
    public var s4: UInt16 = 0
    public var s5: UInt8 = 0
    public var s6: UInt8 = 0
    public var s7: UInt16 = 0
    public var s8: UInt16 = 0
    
    override init(packet: Data) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.s1 = try reader.readUInt8()
        self.s2 = try reader.readUInt16()
        self.s3 = try reader.readUInt16()
        self.s4 = try reader.readUInt16()
        self.s5 = try reader.readUInt8()
        self.s6 = try reader.readUInt8()
        self.s7 = try reader.readUInt16()
        self.s8 = try reader.readUInt16()
    }
    
    override init(packet: Packet) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.s1 = try reader.readUInt8()
        self.s2 = try reader.readUInt16()
        self.s3 = try reader.readUInt16()
        self.s4 = try reader.readUInt16()
        self.s5 = try reader.readUInt8()
        self.s6 = try reader.readUInt8()
        self.s7 = try reader.readUInt16()
        self.s8 = try reader.readUInt16()
    }
}
