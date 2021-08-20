//
//  LLJAttributeModel.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/11.
//

import UIKit

class LJTextModel: NSObject {
    
    var content: String = ""
    var searchContent: [String] = []
    var ranges: [NSRange] = []
    var attributeKeys: [LJTextKey] = []
    var action: Action?
    var bindObject: Any?
}
