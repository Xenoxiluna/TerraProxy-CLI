//
//  PacketPlayerUpdate.swift
//  
//
//  Created by Quentin Berry on 5/10/20.
//

import Foundation
import SwiftyBytes

class PacketPlayerUpdate: Packet{
    public var playerId: UInt8 = 0
    public var control: UInt8 = 0
    public var pulley: UInt8 = 0
    public var item: UInt8 = 0
    public var x: Float32 = 0
    public var y: Float32 = 0
    public var velx: Float32 = 0
    public var vely: Float32 = 0
    
    override init(packet: Data) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.control = try reader.readUInt8()
        self.pulley = try reader.readUInt8()
        self.item = try reader.readUInt8()
        self.x = try reader.readFloat32()
        self.y = try reader.readFloat32()
        self.velx = try reader.readFloat32()
        self.vely = try reader.readFloat32()
    }
    
    override init(packet: Packet) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.control = try reader.readUInt8()
        self.pulley = try reader.readUInt8()
        self.item = try reader.readUInt8()
        self.x = try reader.readFloat32()
        self.y = try reader.readFloat32()
        self.velx = try reader.readFloat32()
        self.vely = try reader.readFloat32()
    }
}
