//
//  BlockContainer.swift
//  KaiFangBao
//
//  Created by ysjjchh on 16/3/23.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import Foundation

class BlockContainer<BlockItem>: NSObject {
    var block: BlockItem?
    
    init(block: BlockItem?) {
        self.block = block
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return BlockContainer(block: self.block)
    }
}