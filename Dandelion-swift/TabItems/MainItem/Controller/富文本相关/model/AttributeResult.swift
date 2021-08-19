//
//  AttributeResult.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/13.
//

import UIKit

class AttributeResult: NSObject {

    var range: NSRange = NSRange()
    var content: String = ""
    var bindObject: Any?
    
    var action: Action?
}
