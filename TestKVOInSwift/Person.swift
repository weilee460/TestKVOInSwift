//
//  Person.swift
//  TestKVOInSwift
//
//  Created by ying on 16/6/12.
//  Copyright © 2016年 ying. All rights reserved.
//

import Foundation

class Person: NSObject {
    //dynamic表明支持 OC Runtime 动态分发机制
    dynamic var firstName: String
    dynamic var lastName: String
    
    var fullName: String {
        get {
            return "\(lastName) \(firstName)"
        }
    }
    
    var address: Address
    
    init(firstName:String, lastName: String, address: Address) {
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
    }
    
    //KVC无法找到属性时，这时候 KVC 协议其实会调用 valueForUndefinedKey 方法
    override func valueForUndefinedKey(key: String) -> AnyObject? {
        return "No Find Key"
    }
    
    //实现 keyPathsForValuesAffectingValueForKey 方法在实体类中声明属性依赖
    override class func keyPathsForValuesAffectingValueForKey(key: String) -> Set<String>
    {
        if key == "fullName" {
            return Set<String>(arrayLiteral: "firstName","lastName")
        } else {
            return super.keyPathsForValuesAffectingValueForKey(key)
        }
    }
    
    //KVO 在默认情况下，只要为某个属性添加了监听对象，在这个属性值改变的时候，就会自动的通知监听者。也有一些情况下，可能我们想手动的处理这些通知的发送
    //覆盖 automaticallyNotifiesObserversForKey 方法来告诉 KVO，那些属性是我们想手动处理的
    override class func automaticallyNotifiesObserversForKey(key: String) -> Bool
    {
        if key == "firstName" {
            //取消 firstName 这个属性KVO的自动通知，改为手动通知
            return false
        }
        else {
            return true
        }
    }
    
}