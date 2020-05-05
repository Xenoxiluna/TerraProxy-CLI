//
//  HostInfo.swift
//  TerrariaProxyServer
//
//  Created by Quentin Berry on 5/4/20.
//  Copyright © 2020 Quentin Berry. All rights reserved.
//

import Foundation
import NIO

public enum HostInfo {
    case ip(host: String, port: Int)
    case unixDomainSocket(path: String)
}
