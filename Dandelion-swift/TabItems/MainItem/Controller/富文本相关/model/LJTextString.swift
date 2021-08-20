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
    
    init?(model: LJTextModel) {
 
        self.text = NSMutableAttributedString(string: model.content)
        addAttribute(model: model)
    }
}

extension LJTextString {
    
    mutating func addAttribute(model: LJTextModel) {
        
        let content = NSMutableAttributedString(attributedString: self.text)
 
        setResults(model: model, content: content)
    }
    
    private mutating func setResults(model: LJTextModel, content: NSMutableAttributedString) {
                
        model.searchContent.forEach { (subString) in
            let array = self.text.string.ranges(of: subString)
            array.forEach { (result) in
                
                let textRange = LJTextRange()
                result.bindObject = model.bindObject
                textRange.action = model.action
                textRange.result = result
                
                model.attributeKeys.forEach { (key) in
                    self.text = setAttributeString(content: content, attribute: key, range: result.range)
                }
                
                self.textRanges.append(textRange)
            }
        }
        
        model.ranges.forEach { (range) in
            
            guard let result = self.text.string.ranges(of: range) else {
                return
            }
            
            let textRange = LJTextRange()
            result.bindObject = model.bindObject
            textRange.action = model.action
            textRange.result = result
            
            model.attributeKeys.forEach { (key) in
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
