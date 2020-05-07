//
//  PacketLegacyWorldInfo.swift
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
class PacketLegacyWorldInfo: Packet{
    public var time: UInt32 = 0
    public var dayMoonInfo: UInt8 = 0
    public var moonPhase: UInt8 = 0
    public var maxTilesX: UInt32 = 0
    public var maxTilesY: UInt32 = 0
    public var spawnX: UInt16 = 0
    public var spawnY: UInt16 = 0
    public var worldSurface: UInt16 = 0
    public var rockLayer: UInt16 = 0
    public var worldId: UInt32 = 0
    public var worldName: String = ""
    public var worldNameOffset: UInt32 = 0
    public var moonType: UInt8 = 0
    public var treeBackground: UInt8 = 0
    public var corruptionBackground: UInt8 = 0
    public var jungleBackground: UInt8 = 0
    public var snowBackground: UInt8 = 0
    public var hallowBackground: UInt8 = 0
    public var crimsonBackground: UInt8 = 0
    public var desertBackground: UInt8 = 0
    public var oceanBackground: UInt8 = 0
    public var iceBackStyle: UInt8 = 0
    public var jungleBackStyle: UInt8 = 0
    public var hellBackStyle: UInt8 = 0
    public var windSpeedSet: Float32 = 0
    public var cloudNumber: UInt8 = 0
    public var tree1: UInt32 = 0
    public var tree2: UInt32 = 0
    public var tree3: UInt32 = 0
    public var treeStyle1: UInt8 = 0
    public var treeStyle2: UInt8 = 0
    public var treeStyle3: UInt8 = 0
    public var treeStyle4: UInt8 = 0
    public var caveBack1: UInt32 = 0
    public var caveBack2: UInt32 = 0
    public var caveBack3: UInt32 = 0
    public var caveBackStyle1: UInt8 = 0
    public var caveBackStyle2: UInt8 = 0
    public var caveBackStyle3: UInt8 = 0
    public var caveBackStyle4: UInt8 = 0
    public var rain: Float32 = 0
    public var eventInfo1: UInt8 = 0
    public var eventInfo2: UInt8 = 0
    public var eventInfo3: UInt8 = 0
    public var eventInfo4: UInt8 = 0
    public var eventInfo5: UInt8 = 0
    public var invasionType: UInt8 = 0
    public var lobby: UInt64 = 0
    public var sandstormSeverity: UInt8 = 0
    
    override init(packet: Data) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.time = try reader.readUInt32()
        self.dayMoonInfo = try reader.readUInt8()
        self.moonPhase = try reader.readUInt8()
        self.maxTilesX = try reader.readUInt32()
        self.maxTilesY = try reader.readUInt32()
        self.spawnX = try reader.readUInt16()
        self.spawnY = try reader.readUInt16()
        self.worldSurface = try reader.readUInt16()
        self.rockLayer = try reader.readUInt16()
        self.worldId = try reader.readUInt32()
        self.worldName = try reader.readNullTerminatedStringNoTrail()
        self.worldNameOffset = try reader.readUInt32()
        self.moonType = try reader.readUInt8()
        self.treeBackground = try reader.readUInt8()
        self.corruptionBackground = try reader.readUInt8()
        self.jungleBackground = try reader.readUInt8()
        self.snowBackground = try reader.readUInt8()
        self.hallowBackground = try reader.readUInt8()
        self.crimsonBackground = try reader.readUInt8()
        self.desertBackground = try reader.readUInt8()
        self.oceanBackground = try reader.readUInt8()
        self.iceBackStyle = try reader.readUInt8()
        self.jungleBackStyle = try reader.readUInt8()
        self.hellBackStyle = try reader.readUInt8()
        self.windSpeedSet = try reader.readFloat32()
        self.cloudNumber = try reader.readUInt8()
        self.tree1 = try reader.readUInt32()
        self.tree2 = try reader.readUInt32()
        self.tree3 = try reader.readUInt32()
        self.treeStyle1 = try reader.readUInt8()
        self.treeStyle2 = try reader.readUInt8()
        self.treeStyle3 = try reader.readUInt8()
        self.treeStyle4 = try reader.readUInt8()
        self.caveBack1 = try reader.readUInt32()
        self.caveBack2 = try reader.readUInt32()
        self.caveBack3 = try reader.readUInt32()
        self.caveBackStyle1 = try reader.readUInt8()
        self.caveBackStyle2 = try reader.readUInt8()
        self.caveBackStyle3 = try reader.readUInt8()
        self.caveBackStyle4 = try reader.readUInt8()
        self.rain = try reader.readFloat32()
        self.eventInfo1 = try reader.readUInt8()
        self.eventInfo2 = try reader.readUInt8()
        self.eventInfo3 = try reader.readUInt8()
        self.eventInfo4 = try reader.readUInt8()
        self.eventInfo5 = try reader.readUInt8()
        self.invasionType = try reader.readUInt8()
        self.lobby = try reader.readUInt64()
        self.sandstormSeverity = try reader.readUInt8()
    }
    
    override init(packet: Packet) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.time = try reader.readUInt32()
        self.dayMoonInfo = try reader.readUInt8()
        self.moonPhase = try reader.readUInt8()
        self.maxTilesX = try reader.readUInt32()
        self.maxTilesY = try reader.readUInt32()
        self.spawnX = try reader.readUInt16()
        self.spawnY = try reader.readUInt16()
        self.worldSurface = try reader.readUInt16()
        self.rockLayer = try reader.readUInt16()
        self.worldId = try reader.readUInt32()
        self.worldName = try reader.readNullTerminatedStringNoTrail()
        self.worldNameOffset = try reader.readUInt32()
        self.moonType = try reader.readUInt8()
        self.treeBackground = try reader.readUInt8()
        self.corruptionBackground = try reader.readUInt8()
        self.jungleBackground = try reader.readUInt8()
        self.snowBackground = try reader.readUInt8()
        self.hallowBackground = try reader.readUInt8()
        self.crimsonBackground = try reader.readUInt8()
        self.desertBackground = try reader.readUInt8()
        self.oceanBackground = try reader.readUInt8()
        self.iceBackStyle = try reader.readUInt8()
        self.jungleBackStyle = try reader.readUInt8()
        self.hellBackStyle = try reader.readUInt8()
        self.windSpeedSet = try reader.readFloat32()
        self.cloudNumber = try reader.readUInt8()
        self.tree1 = try reader.readUInt32()
        self.tree2 = try reader.readUInt32()
        self.tree3 = try reader.readUInt32()
        self.treeStyle1 = try reader.readUInt8()
        self.treeStyle2 = try reader.readUInt8()
        self.treeStyle3 = try reader.readUInt8()
        self.treeStyle4 = try reader.readUInt8()
        self.caveBack1 = try reader.readUInt32()
        self.caveBack2 = try reader.readUInt32()
        self.caveBack3 = try reader.readUInt32()
        self.caveBackStyle1 = try reader.readUInt8()
        self.caveBackStyle2 = try reader.readUInt8()
        self.caveBackStyle3 = try reader.readUInt8()
        self.caveBackStyle4 = try reader.readUInt8()
        self.rain = try reader.readFloat32()
        self.eventInfo1 = try reader.readUInt8()
        self.eventInfo2 = try reader.readUInt8()
        self.eventInfo3 = try reader.readUInt8()
        self.eventInfo4 = try reader.readUInt8()
        self.eventInfo5 = try reader.readUInt8()
        self.invasionType = try reader.readUInt8()
        self.lobby = try reader.readUInt64()
        self.sandstormSeverity = try reader.readUInt8()
    }
}
