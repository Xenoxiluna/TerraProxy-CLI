//
//  PacketNetModule.swift
//  
//
//  Created by Quentin Berry on 5/5/20.
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
/*Packet type: LoadNetModule
NetModule Packet Bytes: [14, 0, 82, 1, 0, 3, 83, 97, 121, 4, 116, 101, 115, 116]

Header
14, 0, 82,

Payload
1, 0, 3, 83, 97, 121, 4, 116, 101, 115, 116


Load Net Module:
1, 0

Command: Say
3, 83, 97, 121

TextLength
4,

Text
116, 101, 115, 116*/
class PacketNetModule: Packet{
    public var netModuleId: UInt16 = 1
    public var command: CommandType = .Say
    public var message: String = ""
    
    override init(packet: Data) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.netModuleId = try reader.readUInt16()
        
        if let c = CommandType.init(rawValue: try reader.read7BitEncodedString()){
            self.command = c
        }
        
        self.message = try reader.read7BitEncodedString()
    }
    
    override init(packet: Packet) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.netModuleId = try reader.readUInt16()
        
        if let c = CommandType.init(rawValue: try reader.read7BitEncodedString()){
            self.command = c
        }
        
        self.message = try reader.read7BitEncodedString()
    }
    
    enum CommandType: String{
        case Say = "\u{3}Say"
        case Emote = "\u{5}Emote"
        case Roll = "\u{4}Roll"
        case Party = "\u{5}Party"
        case Playing = "\u{7}Playing"
    }
}
