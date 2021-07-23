//
//  LLJUseDefaultHelper.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/23.
//

import UIKit

class LLJUseDefaultHelper: NSObject {
    
    class func setObject(object: String, key: String) {
        UserDefaults.setValue(object, forKey: key)
    }
    
    class func getObject(key: String) -> String {
        UserDefaults.value(forKey: key) as! String
    }
}
