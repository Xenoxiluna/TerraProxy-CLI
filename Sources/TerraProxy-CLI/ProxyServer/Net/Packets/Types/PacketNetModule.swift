//
//  PacketNetModule.swift
//  
//
//  Created by Quentin Berry on 5/5/20.
//

import Foundation
import SwiftyBytes

class PacketNetModule: Packet{
    private let HEADER_SIZE = 5
    private var Ids: UInt16
    private var Buffer: [UInt8]
    
    override init(packet: Data) throws {
        self.Ids = 0
        self.Buffer = []
        try super.init(packet: packet)
    }
    
    override init(packet: Packet) throws {
        self.Ids = 0
        self.Buffer = []
        try super.init(packet: packet)
    }
    
    public func encode() throws -> Data{
        return Data()
    }
}
