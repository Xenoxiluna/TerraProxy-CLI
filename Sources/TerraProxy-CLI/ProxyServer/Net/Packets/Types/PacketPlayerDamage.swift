//
//  PacketPlayerDamage.swift
//  
//
//  Created by Quentin Berry on 5/10/20.
//

import Foundation
import SwiftyBytes

class PacketPlayerDamage: Packet{
    
    override init(packet: Data) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
    }
    
    override init(packet: Packet) throws{
        try super.init(packet: packet)
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
    }
}
