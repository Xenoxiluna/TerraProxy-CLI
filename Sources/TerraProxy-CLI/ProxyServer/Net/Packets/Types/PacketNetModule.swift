//
//  PacketNetModule.swift
//  
//
//  Created by Quentin Berry on 5/5/20.
//

import Foundation
import BinarySwift

class PacketNetModule: Packet{
    private let HEADER_SIZE = 5
    private var Id: UInt16
    private var Buffer: [UInt8]
    
    override init(packet: InboundIn) {
        self.Id = 0
        self.Buffer = []
        super.init(packet: packet)
    }
}
