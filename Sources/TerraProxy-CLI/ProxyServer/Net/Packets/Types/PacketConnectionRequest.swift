//
//  PacketConnectionRequest.swift
//  
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

/// Payload Structure
/// Offset  |  Type  |  Description
///   0        UInt16   Message Length
///   1-x String Message
/// ----------------------------------
class PacketConnectionRequest: Packet{
    public var version: String = ""
    
    override init(packet: Data) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        let strlen = Int(try reader.readUInt8())
        self.version = try reader.readString(strlen)
    }
    
    override init(packet: Packet) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        let strlen = Int(try reader.readUInt8())
        self.version = try reader.readString(strlen)
    }
}
