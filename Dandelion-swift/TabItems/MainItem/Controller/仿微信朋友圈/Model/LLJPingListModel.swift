//
//  LLJNewZanListModel.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/27.
//

import UIKit

class LLJPingListModel: NSObject {
     
    var aUserId: Int64 = 0
    var aUserName: String?
    var bUserId: Int64 = 0
    var bUserName: String?
    var content: String?
    var messageId: Int64 = 0
    var timeInterval: Int64 = 0
    var type: Int64 = 0
    var userId: Int64 = 0
    var rowHeight: CGFloat = 0.0
    var attrContent: ASAttributedString = ASAttributedString(string: "")
    var aUserNameRange: NSRange = NSRange(location: 0,length: 0)
    var bUserNameRange: NSRange = NSRange(location: 0,length: 0)
}
