//
//  LLJAttributeString.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/9.
//

import UIKit

struct LJTextString {
    
    var textRanges: [LJTextRange] = []
    var text: NSAttributedString
    
    init(content: String) {
        
        self.text = NSMutableAttributedString(string: content)
    }
    
    init(content: NSAttributedString) {
        
        self.text = NSMutableAttributedString(attributedString: content)
    }
}

extension LJTextString {
    
    mutating func add(searchContent: String, attributeKeys: [LJTextKey]?) {
        add(searchContents: [searchContent], searchRanges: nil, attributeKeys: attributeKeys, highLightKeys: nil, action: nil, bindObject: nil)
    }
    
    mutating func add(searchRange: NSRange, attributeKeys: [LJTextKey]?) {
        add(searchContents: nil, searchRanges: [searchRange], attributeKeys: attributeKeys, highLightKeys: nil, action: nil, bindObject: nil)
    }
    
    mutating func add(searchRange: NSRange, attributeKeys: [LJTextKey]?, bindObject: Any?) {
        add(searchContents: nil, searchRanges: [searchRange], attributeKeys: attributeKeys, highLightKeys: nil, action: nil, bindObject: bindObject)
    }
    
    mutating func add(searchContent: String, attributeKeys: [LJTextKey]?, bindObject: Any?) {
        add(searchContents: [searchContent], searchRanges: nil, attributeKeys: attributeKeys, highLightKeys: nil, action: nil, bindObject: bindObject)
    }
    
    mutating func add(searchRange: NSRange, attributeKeys: [LJTextKey]?, highLightKeys: [LJTextKey]?, action: Action?, bindObject: Any?) {
        add(searchContents: nil, searchRanges: [searchRange], attributeKeys: attributeKeys, highLightKeys: highLightKeys, action: action, bindObject: bindObject)
    }
    
    mutating func add(searchContent: String, attributeKeys: [LJTextKey]?, highLightKeys: [LJTextKey]?, action: Action?, bindObject: Any?) {
        add(searchContents: [searchContent], searchRanges: nil, attributeKeys: attributeKeys, highLightKeys: highLightKeys, action: action, bindObject: bindObject)
    }
    
    mutating func add(searchContents: [String]?, attributeKeys: [LJTextKey]?, highLightKeys: [LJTextKey]?, action: Action?, bindObject: Any?) {
        add(searchContents: searchContents, searchRanges: nil, attributeKeys: attributeKeys, highLightKeys: highLightKeys, action: action, bindObject: bindObject)
    }
    
    mutating func add(searchRanges: [NSRange]?, attributeKeys: [LJTextKey]?, highLightKeys: [LJTextKey]?, action: Action?, bindObject: Any?) {
        add(searchContents: nil, searchRanges: searchRanges, attributeKeys: attributeKeys, highLightKeys: highLightKeys, action: action, bindObject: bindObject)
    }
    
    
    mutating func add(searchContents: [String]?, searchRanges: [NSRange]?, attributeKeys: [LJTextKey]?, highLightKeys: [LJTextKey]?, action: Action?, bindObject: Any?) {
        
        let content = NSMutableAttributedString(attributedString: self.text)

        searchContents?.forEach { (subString) in
            let array = self.text.string.ranges(of: subString)
            array.forEach { (result) in
                
                let textRange = LJTextRange()
                result.bindObject = bindObject
                textRange.action = action
                textRange.result = result
                textRange.attributeKeys = attributeKeys
                textRange.highLightKeys = highLightKeys
                
                attributeKeys?.forEach { (key) in
                    self.text = setAttributeString(content: content, attribute: key, range: result.range)
                }
                
                self.textRanges.append(textRange)
            }
        }
        
        searchRanges?.forEach { (range) in
            
            guard let result = self.text.string.ranges(of: range) else {
                return
            }
            
            let textRange = LJTextRange()
            result.bindObject = bindObject
            textRange.action = action
            textRange.result = result
            textRange.attributeKeys = attributeKeys
            textRange.highLightKeys = highLightKeys
            
            attributeKeys?.forEach { (key) in
                self.text = setAttributeString(content: content, attribute: key, range: range)
            }
            
            self.textRanges.append(textRange)
        }
    }
    
    func setAttributeString(content: NSMutableAttributedString, attribute: LJTextKey, range: NSRange) -> NSAttributedString {
        
        switch attribute {
        case .font(let font):
            content.addAttribute(.font, value: font, range: range)
        case .background(let color):
            content.addAttribute(.backgroundColor, value: color, range: range)
        case .foreground(let color):
            content.addAttribute(.foregroundColor, value: color, range: range)
        }
        return content
    }
}
