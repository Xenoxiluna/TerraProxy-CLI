//
//  Packet.swift
//  TerrariaProxyServer
//
//  Created by Quentin Berry on 4/14/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation
import NIO
import NIOHTTP1

public class Packet {
    var length: Int
    var packetBytes: [UInt8]
    
    var type: PacketType = .Other

    init(packet: InboundIn) {
        let bytes: [UInt8]? = packet.getBytes(at: packet.readerIndex, length: packet.readableBytes)
        self.packetBytes = bytes!
        self.length = packet.readableBytes
        if let bytesCheck = bytes{
            if bytesCheck.count > 1 {
                if let ptype = PacketType(rawValue: bytesCheck[2]){
                    self.type = ptype
                }
            }else{
                self.type = PacketType.Other
            }
        }
    }

    func getType() -> PacketType {
        return self.type
    }
}
