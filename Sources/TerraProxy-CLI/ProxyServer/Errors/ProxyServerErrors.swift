//
//  ProxyServerErrors.swift
//  
//
//  Created by Quentin Berry on 7/20/20.
//

import NIO

public protocol ProxyServerError: Equatable, Error { }

public enum ProxyServerErrors{
        
    /// Error indicating that after an operation some unused bytes are left.
    public struct LeftOverBytesError: ProxyServerError {
        public let leftOverBytes: ByteBuffer
    }
}
