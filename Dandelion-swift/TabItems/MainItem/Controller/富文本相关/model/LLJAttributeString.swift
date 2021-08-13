//
//  LLJAttributeString.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/9.
//

import UIKit

struct LLJAttributeString {
    
    var model: AttributeModel
    var text: NSAttributedString
    
    init(model: AttributeModel) {
        self.model = model
        self.text = NSMutableAttributedString(string: model.content)
        addAttribute(model: model)
    }
}

extension LLJAttributeString {
    
    private mutating func addAttribute(model: AttributeModel) {
        
        let content = NSMutableAttributedString(string: model.content)
        model.AttributeRanges.forEach { (range) in
            model.attributeKeys.forEach { (key) in
                self.text = setAttributeString(content: content, attribute: key, range: range)
            }
        }
    }
    
    func setAttributeString(content: NSMutableAttributedString, attribute: AttributeKey, range: AttributeRange) -> NSAttributedString {
        
        switch attribute {
        case .font(let font):
            content.addAttribute(.font, value: font, range: range.range)
        case .backgroundColor(let color):
            content.addAttribute(.backgroundColor, value: color, range: range.range)
        case .foregroundColor(let color):
            content.addAttribute(.foregroundColor, value: color, range: range.range)
        }
        return content
    }
}
