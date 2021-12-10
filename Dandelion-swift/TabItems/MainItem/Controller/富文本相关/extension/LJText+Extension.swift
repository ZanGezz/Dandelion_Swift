//
//  LLJAttributeExtension.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/11.
//

import UIKit

extension String {

    func reversedBase64Decode() -> String? {
        guard let data = Data(base64Encoded: .init(self.reversed())) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension NSString {
    
    //获取字符串中所有的指定子字符串range
    func ranges(of searchString: String) -> [LJTextResult] {
        var ranges: [LJTextResult] = []
        var content: NSString = self
        var location: Int = 0
        for _ in stride(from: 0, to: self.length, by: 1) {
            
            let model: LJTextResult = LJTextResult()
            let range: NSRange = content.range(of: searchString)
            guard range.length > 0 else {
                break
            }
            let newRange = NSRange(location: location + range.location, length: searchString.count)
            model.range = newRange
            model.content = searchString
            ranges.append(model)

            location = newRange.location + newRange.length
            guard location < self.length else {
                break
            }
            content = content.substring(from: range.location + range.length) as NSString
        }
        return ranges
    }
    
    //获取字符串中所有的指定子字符串range
    func ranges(of searchRange: NSRange) -> LJTextResult? {
        
        guard
            searchRange.location >= 0,
            searchRange.location + searchRange.length <= self.length else {
            return nil
        }
        let ranges: LJTextResult = LJTextResult()
        let content = self.substring(with: searchRange)
        ranges.content = content
        ranges.range = searchRange
        return ranges
    }
}

