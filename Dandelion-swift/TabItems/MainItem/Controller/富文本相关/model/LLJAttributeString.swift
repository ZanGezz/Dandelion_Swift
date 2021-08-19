//
//  LLJAttributeString.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/9.
//

import UIKit

struct LLJAttributeString {
    
    var attributeResults: [AttributeResult] = []
    var text: NSAttributedString
    
    init(content: String) {
        
        self.text = NSMutableAttributedString(string: content)
    }
    
    init?(model: AttributeModel) {
 
        self.text = NSMutableAttributedString(string: model.content)
        addAttribute(model: model)
    }
}

extension LLJAttributeString {
    
    mutating func addAttribute(model: AttributeModel) {
        
        let content = NSMutableAttributedString(attributedString: self.text)
 
        setResults(model: model, content: content)
    }
    
    private mutating func setResults(model: AttributeModel, content: NSMutableAttributedString) {
                
        model.attributeContent.forEach { (subString) in
            let array = self.text.string.ranges(of: subString)
            array.forEach { (result) in
                result.action = model.action
                result.bindObject = model.bindObject
                
                model.attributeKeys.forEach { (key) in
                    self.text = setAttributeString(content: content, attribute: key, range: result.range)
                }
                
                self.attributeResults.append(result)
            }
        }
        
        model.ranges.forEach { (range) in
            guard let attributeRange = self.text.string.ranges(of: range) else {
                return
            }
            attributeRange.action = model.action
            attributeRange.bindObject = model.bindObject
            
            model.attributeKeys.forEach { (key) in
                self.text = setAttributeString(content: content, attribute: key, range: range)
            }
            
            self.attributeResults.append(attributeRange)
        }
    }
    
    func setAttributeString(content: NSMutableAttributedString, attribute: AttributeKey, range: NSRange) -> NSAttributedString {
        
        switch attribute {
        case .font(let font):
            content.addAttribute(.font, value: font, range: range)
        case .backgroundColor(let color):
            content.addAttribute(.backgroundColor, value: color, range: range)
        case .foregroundColor(let color):
            content.addAttribute(.foregroundColor, value: color, range: range)
        }
        return content
    }
}
