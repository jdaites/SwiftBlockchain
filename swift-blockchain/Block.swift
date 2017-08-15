
//
//  Block.swift
//  SwiftBlockchain
//
//  Created by Josh Daiter on 2017-08-15.
//
//

import Foundation

open class Block
{
    
    var index: Int?
    var previousHash: String?
    var timestamp: Int?
    var data: String?
    var hash: String?
    
    init(index: Int, previousHash: String, timestamp: Int, data: String, hash: String)
    {
        self.index = index
        self.previousHash = previousHash
        self.timestamp = timestamp
        self.data = data
        self.hash = String(hash)
    }
    
    init() {}
    
    
    open func isEqual(_ object: Any?) -> Bool
    {
        guard let rhs = object as? Block else { return false }
        return self == rhs
    }

}

public func ==(lhs: Block, rhs: Block) -> Bool
{
    return (lhs.hash == rhs.hash)
}

public func !=(lhs: Block, rhs: Block) -> Bool
{
    return !(lhs == rhs)
}
