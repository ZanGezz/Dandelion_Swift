//
//  LJTextRange.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/8/20.
//

import UIKit

class LJTextRange: NSObject {

    var attributeKeys: [LJTextKey]?
    var highLightKeys: [LJTextKey]?
    var result: LJTextResult = LJTextResult()
    var action: Action?
}

extension LJTextRange {
    
    func callBack() {
        self.action?.callBack(self.result)
    }
}
