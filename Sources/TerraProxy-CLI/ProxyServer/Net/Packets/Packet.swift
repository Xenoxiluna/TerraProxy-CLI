//
//  Packet.swift
//  TerrariaProxyServer
//
//  Created by Quentin Berry on 4/14/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation
import SwiftyBytes

/// Legacy Packet Structure
/// Offset  |  Type  |  Description
///   0        UInt16   Message Length
///   1        UInt8     Message Type
///   2    *     Payload
/// ----------------------------------

public class Packet{
    public var allPacketBytes: [UInt8] = []
    public var length: UInt16 = 0
    public var type: PacketType = .Other
    public var payload: [UInt8] = []
    
    init(packet: Data) throws{
        let packetData = BinaryReadableData(data: packet)
        let packetReader = BinaryReader(packetData)
        self.allPacketBytes.append(contentsOf: packet)
        self.length = try packetReader.readUInt16()
        if let ptype = PacketType(rawValue: try packetReader.readUInt8()){
            self.type = ptype
        }
        self.payload = try packetReader.read(packet.count - packetReader.readIndex)
    }
    
    init(packet: Packet) throws{
        self.allPacketBytes = packet.allPacketBytes
        self.length = packet.length
        self.type = packet.type
        self.payload = packet.payload
    }
    
    init(length: UInt16, packetBytes: [UInt8], type: PacketType) {
        self.allPacketBytes = packetBytes
        self.length = length
        self.type = type
    }
    
    func getType() -> PacketType {
        return self.type
    }
}
