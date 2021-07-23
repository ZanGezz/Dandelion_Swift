//
//  LLJCycleFrameModel.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/22.
//

import UIKit

class LLJCycleFrameModel: NSObject {
    
    var rowHeight: CGFloat = 0.0
    
    var headImageFrame: CGRect = CGRect.zero
    var nickNameFrame: CGRect = CGRect.zero
    var contentFrame: CGRect = CGRect.zero
    var timeIntevalFrame: CGRect = CGRect.zero
    var moreButtonFrame: CGRect = CGRect.zero
    var lineViewFrame: CGRect = CGRect.zero
    //图片
    var contentImageSize: CGSize = CGSize.zero
    var contentImageFrame: CGRect = CGRect.zero
    //视频
    var contentVideoFrame: CGRect = CGRect.zero
    //网址
    var contentLinkFrame: CGRect = CGRect.zero
}
