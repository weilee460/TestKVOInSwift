//
//  Address.swift
//  TestKVOInSwift
//
//  Created by ying on 16/6/13.
//  Copyright © 2016年 ying. All rights reserved.
//

import Foundation

class Address: NSObject {
    
    var firstLine: String
    var secondLine: String
    
    init(firstLine: String, secondLine: String) {
        self.firstLine = firstLine
        self.secondLine = secondLine
    }
    
}