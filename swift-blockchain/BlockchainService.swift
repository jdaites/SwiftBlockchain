//
//  BlockchainService.swift
//  SwiftBlockchain
//
//  Created by Josh Daiter on 2017-08-15.
//
//

import Foundation

open class BlockchainService
{
    
    var blockchain: [Block]?
    
    init()
    {
        self.blockchain = [getGenesisBlock()]
    }
    
    
    func calculateHash(index: Int, previousHash: String, timestamp: Int, data: String) -> String
    {
        return ""
    }
    
    func calculateHashForBlock(block: Block) -> String
    {
        guard let index = block.index,
              let previousHash = block.previousHash,
              let timestamp = block.timestamp,
              let data = block.data else
        {
            return ""
        }
        
        return calculateHash(index: index, previousHash: previousHash, timestamp: timestamp, data: data)
    }
    
    func addBlock(newBlock: Block)
    {
        if isValidNewBlock(newBlock: newBlock, previousBlock: getLatestBlock())
        {
            self.blockchain?.append(newBlock)
        }
    }
    
    func getLatestBlock() -> Block
    {
        guard let chainLength = self.blockchain?.count else { return Block() }
        return self.blockchain?[chainLength-1] ?? Block()
    }

    func generateNextBlock(blockData: String) -> Block
    {
        let previousBlock = getLatestBlock()
        guard let previousBlockIndex = previousBlock.index,
              let previousBlockHash = previousBlock.hash else
        {
            return Block()
        }
        
        let nextIndex = previousBlockIndex + 1
        let nextTimestamp = Date().timeIntervalSince1970
        let nextHash = calculateHash(index: nextIndex, previousHash: previousBlockHash, timestamp: Int(nextTimestamp), data: blockData)
        
        return Block(index: nextIndex, previousHash: previousBlockHash, timestamp: Int(nextTimestamp), data: blockData, hash: nextHash)
    }
    
    func getGenesisBlock() -> Block
    {
        return Block(index: 0, previousHash: "0", timestamp: 1465154705, data: "Genesis Block",hash: "816534932c2b7154836da6afc367695e6337db8a921823784c14378abed4f7d7")
    }
    
    func isValidNewBlock(newBlock: Block, previousBlock: Block) -> Bool
    {
        guard let newBlockIndex = newBlock.index,
              let previousBlockIndex = previousBlock.index else
        {
            return false
        }
        
        if previousBlockIndex+1 != newBlockIndex
        {
            print("invalid index")
            return false
        }
        else if previousBlock.hash != newBlock.previousHash
        {
            print("invalid previoushash")
            return false
        }
        else if calculateHashForBlock(block: newBlock) != newBlock.hash
        {
            print("invalid hash: \(calculateHashForBlock(block: newBlock)) \(String(describing: newBlock.hash))")
            return false
        }
        
        return true
    }
    
    func isValidChain(blockchainToValidate: [Block]) -> Bool
    {
        guard let blockchainToValidateFirstBlock = blockchainToValidate.first else { return false }
        
        if blockchainToValidateFirstBlock != getGenesisBlock()
        {
            return false
        }
        
        var tempBlocks = [blockchainToValidate.first]
        var isValid = true

        for (index, block) in blockchainToValidate.enumerated()
        {
            if let previousBlock = tempBlocks[index-1], isValidNewBlock(newBlock: block, previousBlock: previousBlock)
            {
                tempBlocks.append(block)
            }
            else
            {
                isValid = false
            }
        }
        return isValid
    }

    
    func replaceChain(newBlocks: [Block])
    {
        guard let blockChainLength = self.blockchain?.count else { return }
        
        if isValidChain(blockchainToValidate: newBlocks) && newBlocks.count > blockChainLength
        {
            print("Received blockchain is valid, replacing current blockchain with recieved blockchain")
            self.blockchain = newBlocks
        }
        else
        {
            print("Received blockchain is invalid")
        }
    }
}
