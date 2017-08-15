//
//  Application.swift
//  swift-blockchain
//
//  Created by Josh Daiter on 2017-08-15.
//  Copyright © 2017 Josh Daiter. All rights reserved.
//

import Foundation

open class Application
{

    fileprivate static let _sharedApplication = Application()
    
    
    fileprivate(set) open var blockchain: BlockchainService?


    
    open class func shared() -> Application
    {
        return Application._sharedApplication
    }
   
}
