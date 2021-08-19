//
//  LLJAttributeModel.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/11.
//

import UIKit

class AttributeModel: NSObject {
    
    var content: String = ""
    
    var attributeContent: [String] = []
    var ranges: [NSRange] = []
    var attributeKeys: [AttributeKey] = []
    
    var action: Action?
    var bindObject: Any?
}
