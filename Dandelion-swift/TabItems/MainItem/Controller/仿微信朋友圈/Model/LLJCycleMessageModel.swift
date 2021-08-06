//
//  LLJCycleMessageModel.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/27.
//

import UIKit

class LLJCycleMessageModel: NSObject {
    
    var content: String = ""                    //文案
    var headImageName: String = ""              //朋友圈头像
    var messageId: Int64 = 0                    //该朋友圈的id
    var nickName: ASAttributedString = ASAttributedString(string: "")  //昵称
    var timeInteval: Int64 = 0                  //时间戳
    var type: Int64 = 0                         //10010 = 纯文本  10011 = 图片  10012 = 视频  10013 = 网址 10014 = 加载更多
    var userId: Int64 = 0                       //用户id
    var userOwnMessage: Bool = false            //是否为当前用户发布的朋友圈
    var locationModel: LLJCycleLocationModel?   //发布位置model
    var imageModel: LLJCycleImageModel?         //发布图片model
    var videoModel: LLJCycleVideoModel?         //发布视频model
    var webLinkModel: LLJCycleWebLinkModel?     //发布链接model
    var attrContent: ASAttributedString = ASAttributedString(string: "") //富文本
    var zanHeight: CGFloat = 0.0                //赞高度
    var pingList: [LLJPingListModel] = []       //评论列表
    var zanList: [LLJPingListModel] = []        //赞列表
    var frameModel: LLJCycleFrameModel = LLJCycleFrameModel()  //framemodel
    var hasZaned: Bool = false                  //是否已经赞过
}
