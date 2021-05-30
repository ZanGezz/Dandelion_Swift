//
//  LLJSegmentModel.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/5/25.
//

import UIKit

class LLJSegmentModel: NSObject {
    
    var itemSize: CGSize = CGSize.zero
    var title: String = ""
    var titleWidth: CGFloat = 0.0
    var titleHeight: CGFloat = 0.0
    var isCurrentSelected: Bool = false

    var bottomLineStaticFrame: CGRect = CGRect.zero
    var cycleFrame: CGRect = CGRect.zero

    var lineWidth: CGFloat = 0.0
    var diameter: CGFloat = 0.0
}

