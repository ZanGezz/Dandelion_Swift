//
//  LLJAttributeModel.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/11.
//

import UIKit

class AttributeModel: NSObject {
    
    private var _content: String = ""
    private var _attributeContent: [String] = []
    var _ranges: [NSRange] = []
    var AttributeRanges: [AttributeRange] = []
    var attributeKeys: [AttributeKey] = []
    var action: Action?
    var tag: Any?
}

extension AttributeModel {
    
    var content: String {
        set {
            _content = newValue
            getSubRanges()
        }
        get {
            return _content
        }
    }
    
    var attributeContent: [String] {
        set {
            _attributeContent = newValue
            getSubRanges()
        }
        get {
            return _attributeContent
        }
    }
    
    var ranges: [NSRange] {
        set {
            
            _ranges = newValue
            getSubRanges()
        }
        get {
            return _ranges
        }
    }
}

extension AttributeModel {
    
    private func getSubRanges() {
        
        guard _attributeContent.count > 0 && _content.count > 0 else {
            return
        }
        self.AttributeRanges.removeAll()
        
        let content: NSString = NSString(string: self.content)
        self.attributeContent.forEach { (subString) in
            let array = content.ranges(of: subString)
            array.forEach { (range) in
                self.AttributeRanges.append(range)
            }
        }
        
        self.ranges.forEach { (range) in
            guard let attributeRange = content.ranges(of: range) else {
                return
            }
            self.AttributeRanges.append(attributeRange)
        }
    }
}
