//
//  LLJCellFrameManage.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/22.
//

import UIKit

class LLJCellFrameManage: NSObject {
    
    //设置cell 子视图 frame
    class func setSubViewFrame(userModel: LLJCycleUserModel, sourceList: Array<Any>, value: [Action]) -> Array<Any> {
        
        var messageArray: Array<Any> = []
        for item in sourceList {
            
            let item = item as! LLJWeChatCycleModel
            let model = LLJCycleMessageModel()
            model.content = item.content ?? ""
            model.headImageName = item.headImageName ?? ""
            model.messageId = item.messageId
            model.userId = item.userId
            model.nickName = setNickNameAttrText(bindObject: item.userId, content: item.nickName ?? "", value: value.first!)
            model.type = item.type
            model.timeInteval = item.timeInteval
            model.webLinkModel = item.webLinkModel
            model.videoModel = item.videoModel
            model.imageModel = item.imageModel
            model.locationModel = item.locationModel
            model.userOwnMessage = item.userId == userModel.userId ? true : false
            //计算frame
            setCompnentsFrame(userModel: userModel, item: model, value: value)
            
            messageArray.append(model)
        }
        return messageArray
    }
    
    class func setCompnentsFrame(userModel: LLJCycleUserModel, item: LLJCycleMessageModel, value: [Action]) {
        
        let frameModel = LLJCycleFrameModel()
        
        var X: CGFloat = 0.0
        var Y: CGFloat = 0.0
        var W: CGFloat = 0.0
        var H: CGFloat = 0.0
        var dy: CGFloat = 0.0
        var temFrame: CGRect = CGRect.zero
        
        //头像frame
        dy = LLJDX(14)
        X = LLJDX(20)
        Y = dy
        W = LLJDX(44)
        H = LLJDX(44)
        frameModel.headImageFrame = CGRect(x: X, y: Y, width: W, height: H)
        
        //昵称frame
        dy = LLJDX(16)
        X = LLJDX(76)
        Y = dy
        W = SCREEN_WIDTH - LLJDX(76) - LLJDX(20)
        H = LLJDX(19)
        frameModel.nickNameFrame = CGRect(x: X, y: Y, width: W, height: H)
        temFrame = frameModel.nickNameFrame

        
        //文案内容frame
        var contentSize: CGSize = CGSize.zero
        if item.content.count > 0 {
            
            contentSize = LLJSHelper.getStringSize(subString: item.content, font: LLJFont(18, ""), width: SCREEN_WIDTH - LLJDX(76) - LLJDX(10))
            
            dy = LLJDX(5)
            X = LLJDX(76)
            Y = temFrame.origin.y + temFrame.height + dy
            W = SCREEN_WIDTH - LLJDX(76) - LLJDX(20)
            H = contentSize.height
            frameModel.contentFrame = CGRect(x: X, y: Y, width: W, height: H)
            temFrame = frameModel.contentFrame
        }
        
        //type: 10010 = 纯文本  10011 = 图片  10012 = 视频  10013 = 网址
        if item.type == 10011 {
            //图片frame
            let imageList = item.imageModel?.imageList?.components(separatedBy: ",")
            if imageList!.count > 1 && imageList!.count < 4 {
                
                dy = LLJDX(10)
                X = LLJDX(76)
                Y = temFrame.origin.y + temFrame.height + dy
                W = CGFloat(imageList!.count)*LLJDX(88) + CGFloat((imageList!.count - 1))*LLJDX(5)
                H = LLJDX(88)
                
                frameModel.contentImageFrame = CGRect(x: X, y: Y, width: W, height: H)
                frameModel.contentImageSize = CGSize(width: LLJDX(88), height: LLJDX(88))
                
            } else if imageList!.count == 4 {
                
                dy = LLJDX(10)
                X = LLJDX(76)
                Y = temFrame.origin.y + temFrame.height + dy
                W = LLJDX(88)*2 + LLJDX(5)
                H = LLJDX(88)*2 + LLJDX(5)
                
                frameModel.contentImageFrame = CGRect(x: X, y: Y, width: W, height: H)
                frameModel.contentImageSize = CGSize(width: LLJDX(88), height: LLJDX(88))
                
            } else if imageList!.count > 4 {
                
                dy = LLJDX(10)
                X = LLJDX(76)
                Y = temFrame.origin.y + temFrame.height + dy
                W = LLJDX(88)*3 + LLJDX(5)*2
                
                if imageList!.count > 6 {
                    H = LLJDX(88)*3 + LLJDX(5)*2
                } else {
                    H = LLJDX(88)*2 + LLJDX(5)
                }
                
                frameModel.contentImageFrame = CGRect(x: X, y: Y, width: W, height: H)
                frameModel.contentImageSize = CGSize(width: LLJDX(88), height: LLJDX(88))

                
            } else {
                
                dy = LLJDX(10)
                X = LLJDX(76)
                Y = temFrame.origin.y + temFrame.height + dy

                let image = UIImage(named: (imageList?.first)!)
                if image != nil {
                    
                    if image!.size.width > image!.size.height {
                        W = LLJDX(88)*2
                        H = W/image!.size.width*image!.size.height
                    } else if (image!.size.width < image!.size.height) {
                        H = LLJDX(88)*2
                        W = H/image!.size.height*image!.size.width
                    } else {
                        W = LLJDX(88)*2
                        H = LLJDX(88)*2
                    }
                }
                frameModel.contentImageFrame = CGRect(x: X, y: Y, width: W, height: H)
                frameModel.contentImageSize = CGSize(width: W, height: H)
            }
            temFrame = frameModel.contentImageFrame
            
        } else if (item.type == 10012) {
            //视频frame
            dy = LLJDX(10)
            X = LLJDX(76)
            Y = temFrame.origin.y + temFrame.height + dy

            let image = UIImage(named: (item.videoModel?.videoImage)!)

            if image!.size.width > image!.size.height {
                W = LLJDX(88)*2.5
                H = W/image!.size.width*image!.size.height
            } else if (image!.size.width < image!.size.height) {
                H = LLJDX(88)*2.5
                W = H/image!.size.height*image!.size.width
            } else {
                W = LLJDX(88)*2
                H = LLJDX(88)*2
            }
            
            frameModel.contentVideoFrame = CGRect(x: X, y: Y, width: W, height: H)
            temFrame = frameModel.contentVideoFrame

        } else if (item.type == 10013) {
            
            //分享frame
            dy = LLJDX(10)
            X = LLJDX(76)
            Y = temFrame.origin.y + temFrame.height + dy
            W = LLJDX(320)
            H = LLJDX(50)
            frameModel.contentLinkFrame = CGRect(x: X, y: Y, width: W, height: H)
            temFrame = frameModel.contentLinkFrame
        }
        
        //地理位置frame
        if item.locationModel?.name != nil {
            dy = LLJDX(10)
            X = LLJDX(76)
            Y = temFrame.origin.y + temFrame.height + dy
            W = LLJDX(300)
            H = LLJDX(15)
            frameModel.locationButtonFrame = CGRect(x: X, y: Y, width: W, height: H)
            temFrame = frameModel.locationButtonFrame
        }
            
        //时间frame
        dy = LLJDX(14)
        X = LLJDX(76)
        Y = temFrame.origin.y + temFrame.height + dy
        W = LLJDX(150)
        H = LLJDX(15)
        frameModel.timeIntevalFrame = CGRect(x: X, y: Y, width: W, height: H)
        temFrame = frameModel.timeIntevalFrame
        
        if item.webLinkModel?.webFromName != nil {
            //分享来自
            frameModel.linkLabel_dx = LLJDX(10)
        }
        
        //删除按钮
        frameModel.deleteButton_dx = LLJDX(10)
        
        //更多按钮frame
        X = SCREEN_WIDTH - LLJDX(20) - LLJDX(34)
        W = LLJDX(34)
        H = LLJDX(21)
        frameModel.moreButtonFrame = CGRect(x: X, y: Y, width: W, height: H)
        
        //计算评论高度
        let pingViewHeight = setZanList(userModel: userModel, item: item, value: value)
        
        if pingViewHeight > 0.0 {
            dy = LLJDX(15)
            X = LLJDX(76)
            Y = temFrame.origin.y + temFrame.height + dy
            W = LLJDX(322)
            H = pingViewHeight
            
            frameModel.zanBgViewFrame = CGRect(x: X, y: Y, width: W, height: H)
            temFrame = frameModel.zanBgViewFrame
        }

        //底线frame
        dy = LLJDX(15)
        X = 0
        Y = temFrame.origin.y + temFrame.height + dy
        W = SCREEN_WIDTH
        H = 0.5
        frameModel.lineViewFrame = CGRect(x: X, y: Y, width: W, height: H)
        temFrame = frameModel.lineViewFrame

        //行高
        frameModel.rowHeight = temFrame.origin.y + temFrame.height

        item.frameModel = frameModel
    }
    
    //计算评论数据
    private class func setZanList(userModel: LLJCycleUserModel, item: LLJCycleMessageModel, value: [Action]) -> CGFloat {
        
        //赞和评论 type = 10001010 赞 10001011 是评论 10001012 是回复
        let pre = String(format: "messageId = %ld", item.messageId)
        let totalList: [LLJCycleZanModel] = LLJSCoreDataHelper().getRosource(entityName: "LLJCycleZanModel", predicate: pre) as! [LLJCycleZanModel]
        
        var zanList: [LLJPingListModel] = []
        var pingList: [LLJPingListModel] = []
        
        //处理 赞和评论
        var pingViewHeight: CGFloat = 0.0
        var zanHeight: CGFloat = 0.0
        var zanContentString: String = "     "
        for i in stride(from: 0, to: totalList.count, by: 1) {
            
            let zanItem = totalList[i]
            let ping = LLJPingListModel()
            ping.aUserId = zanItem.aUserId
            ping.aUserName = zanItem.aUserName ?? ""
            ping.bUserId = zanItem.bUserId
            ping.bUserName = zanItem.bUserName ?? ""
            ping.content = zanItem.content ?? ""
            ping.messageId = zanItem.messageId
            ping.timeInterval = zanItem.timeInterval
            ping.type = zanItem.type
            ping.userId = zanItem.userId
            if zanItem.aUserId == userModel.userId && zanItem.type == 10001010{
                item.hasZaned = true
            }
            
            if ping.type == 10001010 {
                
                let location = zanContentString.count
                let lenth = ping.aUserName.count
                ping.aUserNameRange = NSRange(location: location, length: lenth)
                zanContentString += ping.aUserName + "，"
                zanList.append(ping)
                
            } else {
                
                ping.rowHeight = LLJSHelper.getStringSize(subString: ping.content, font: LLJBoldFont(15), width: LLJDX(300), lineSpace: 0).height + LLJDX(6)
                ping.rowHeight += ping.rowHeight/17.9
                pingViewHeight += ping.rowHeight
                let lenth = ping.aUserName.count
                ping.aUserNameRange = NSRange(location: 0, length: lenth )
                let lenth1 = ping.bUserName.count
                ping.bUserNameRange = NSRange(location: lenth + 2, length: lenth1)
                pingList.append(ping)
            }
        }
        
        //赞高度
        if zanContentString.count > 5 {
            
            zanContentString = String(zanContentString.prefix(zanContentString.count - 1))
            var labelHeight: CGFloat = 0.0
            labelHeight = LLJSHelper.getStringSize(subString: zanContentString, font: LLJBoldFont(15), width: LLJDX(300), lineSpace:0).height
            labelHeight += labelHeight/17.9
            zanHeight = labelHeight + LLJDX(8)

            item.zanHeight = zanHeight;
        }
        
        //设置赞富文本
        item.zanList = zanList
        item.attrContent = setZanAttrText(item: item, content: zanContentString, value: value.first!)
        //设置评论富文本
        item.pingList = pingList
        setPingAttrText(item: item, value: value.first!)
        
        return zanHeight + pingViewHeight
    }
    
    //创建Zan富文本
    private class func setZanAttrText(item: LLJCycleMessageModel, content: String, value: Action) -> LLJAttributeString {
        var attr = LLJAttributeString(content: content)
        let model = AttributeModel()
        model.ranges = [NSRange(location: 0, length: content.count)]
        model.attributeKeys = [.font(LLJFont(13, "")),.foregroundColor(LLJColor(10, 10, 10, 1.0))]
        attr.addAttribute(model: model)

        for zanModel in item.zanList {
            let subModel = AttributeModel()
            subModel.ranges = [zanModel.aUserNameRange]
            subModel.action = value
            subModel.bindObject = zanModel.aUserId
            subModel.attributeKeys = [.font(LLJBoldFont(15)),.foregroundColor(LLJColor(68, 86, 130, 1.0))]
            attr.addAttribute(model: subModel)
        }
        return attr
    }
    //创建Ping富文本
    private class func setPingAttrText(item: LLJCycleMessageModel, value: Action) {
        
        for ping in item.pingList {

            var attr = LLJAttributeString(content: ping.content)
            
            if ping.type == 10001011 {
                
                let model = AttributeModel()
                model.ranges = [ping.aUserNameRange]
                model.action = value
                model.bindObject = ping.aUserId
                model.attributeKeys = [.font(LLJFont(15, "PingFangSC-Medium")),.foregroundColor(LLJColor(68, 86, 130, 1.0))]
                attr.addAttribute(model: model)
                
            } else if ping.type == 10001012 {
                
                let model = AttributeModel()
                model.ranges = [ping.aUserNameRange]
                model.action = value
                model.bindObject = ping.aUserId
                model.attributeKeys = [.font(LLJFont(15, "PingFangSC-Medium")),.foregroundColor(LLJColor(68, 86, 130, 1.0))]
                attr.addAttribute(model: model)

                let model1 = AttributeModel()
                model1.ranges = [ping.bUserNameRange]
                model1.action = value
                model1.bindObject = ping.bUserId
                model1.attributeKeys = [.font(LLJFont(15, "PingFangSC-Medium")),.foregroundColor(LLJColor(68, 86, 130, 1.0))]
                attr.addAttribute(model: model1)
            }
            ping.attrContent = attr
        }
    }
    //创建昵称富文本
    private class func setNickNameAttrText(bindObject: Any, content: String, value: Action) -> LLJAttributeString {
        
        var attr = LLJAttributeString(content: content)
        let model = AttributeModel()
        model.ranges = [NSRange(location: 0, length: content.count)]
        //model.attributeKeys = [.foregroundColor(LLJColor(68, 86, 130, 1.0))]
        model.action = value
        model.bindObject = bindObject
        attr.addAttribute(model: model)
        return attr
    }
}
