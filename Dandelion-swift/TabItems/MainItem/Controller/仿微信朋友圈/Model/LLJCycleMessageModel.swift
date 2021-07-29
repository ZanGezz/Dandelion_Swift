//
//  LLJCycleMessageModel.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/27.
//

import UIKit

class LLJCycleMessageModel: NSObject {
    
    var content: String?
    var headImageName: String?
    var messageId: Int64?
    var nickName: String?
    var timeInteval: Int64?
    var type: Int64?
    var userId: Int64?
    var imageModel: LLJCycleImageModel?
    var videoModel: LLJCycleVideoModel?
    var webLinkModel: LLJCycleWebLinkModel?
    var zanContent: String = ""
    var zanHeight: CGFloat = 0.0
    var pingList: [LLJPingListModel] = []
    var frameModel: LLJCycleFrameModel = LLJCycleFrameModel()
}
