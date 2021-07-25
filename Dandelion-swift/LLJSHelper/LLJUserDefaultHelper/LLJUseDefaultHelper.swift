//
//  LLJUseDefaultHelper.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/23.
//

import UIKit

class LLJUseDefaultHelper: NSObject {
    
    class func setMessage(object: Int64, key: String) {
        setObject(object: object, key: key)
    }
    
    class func getMessage(key: String) -> Int64 {
       
        return getObject(key: key) as? Int64 ?? 0
    }
    
    class func setObject(object: Any, key: String) {
        UserDefaults.standard.setValue(object, forKey: key)
    }
    
    class func getObject(key: String) -> Any {
       
        return UserDefaults.standard.object(forKey: key) as Any
    }
}
