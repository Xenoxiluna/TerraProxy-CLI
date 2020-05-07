//
//  PacketWorldInfo.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

/// Payload Structure
/// Offset  |  Type  |  Description
///   empty packet [3, 0, 6]
///
/// ----------------------------------
class PacketWorldInfo: Packet{
    
    override init(packet: Data) throws{
        try super.init(packet: packet)
    }
    
    override init(packet: Packet) throws{
        try super.init(packet: packet)
    }
}
