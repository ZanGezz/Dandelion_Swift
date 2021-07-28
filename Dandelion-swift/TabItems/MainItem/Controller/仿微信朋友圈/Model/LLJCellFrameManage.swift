//
//  LLJCellFrameManage.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/22.
//

import UIKit

class LLJCellFrameManage: NSObject {
    
    //设置cell 子视图 frame
    class func setSubViewFrame(sourceList: Array<Any>) -> Array<Any> {
        
        var messageArray: Array<Any> = []
        for item in sourceList {
            
            let item = item as! LLJWeChatCycleModel
            let model = LLJCycleMessageModel()
            model.content = item.content
            model.headImageName = item.headImageName
            model.messageId = item.messageId
            model.userId = item.userId
            model.nickName = item.nickName
            model.type = item.type
            model.timeInteval = item.timeInteval
            model.webLinkModel = item.webLinkModel
            model.videoModel = item.videoModel
            model.imageModel = item.imageModel
            //计算frame
            setCompnentsFrame(item: model)
            //计算评论
            setZanList(item: model)
            
            messageArray.append(model)
        }
        return messageArray
    }
    
    private class func setCompnentsFrame(item: LLJCycleMessageModel) {
        
        let sourceModel = item
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
        if sourceModel.content != nil {
            
            contentSize = LLJSHelper.getStringSize(subString: sourceModel.content ?? "", font: LLJFont(18, ""), width: SCREEN_WIDTH - LLJDX(76) - LLJDX(20))
            
            dy = LLJDX(6)
            X = LLJDX(76)
            Y = temFrame.origin.y + temFrame.height + dy
            W = SCREEN_WIDTH - LLJDX(76) - LLJDX(20)
            H = contentSize.height
            frameModel.contentFrame = CGRect(x: X, y: Y, width: W, height: H)
            temFrame = frameModel.contentFrame
        }
        
        //type: 10010 = 纯文本  10011 = 图片  10012 = 视频  10013 = 网址
        if sourceModel.type == 10011 {
            //时间frame
            let imageList = sourceModel.imageModel?.imageList?.components(separatedBy: ",")
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
            
        } else if (sourceModel.type == 10012) {
            
            dy = LLJDX(10)
            X = LLJDX(76)
            Y = temFrame.origin.y + temFrame.height + dy

            let image = UIImage(named: (sourceModel.videoModel?.videoImage)!)

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

        } else if (sourceModel.type == 10013) {
            
            //网址frame
            dy = LLJDX(10)
            X = LLJDX(76)
            Y = temFrame.origin.y + temFrame.height + dy
            W = LLJDX(320)
            H = LLJDX(50)
            frameModel.contentLinkFrame = CGRect(x: X, y: Y, width: W, height: H)
            temFrame = frameModel.contentLinkFrame
        }
            
        //时间frame
        dy = LLJDX(14)
        X = LLJDX(76)
        Y = temFrame.origin.y + temFrame.height + dy
        W = LLJDX(150)
        H = LLJDX(15)
        frameModel.timeIntevalFrame = CGRect(x: X, y: Y, width: W, height: H)

        
        //更多按钮frame
        dy = LLJDX(12)
        X = SCREEN_WIDTH - LLJDX(20) - LLJDX(34)
        Y = temFrame.origin.y + temFrame.height + dy
        W = LLJDX(34)
        H = LLJDX(21)
        frameModel.moreButtonFrame = CGRect(x: X, y: Y, width: W, height: H)
        temFrame = frameModel.timeIntevalFrame

        //底线frame
        dy = LLJDX(17)
        X = 0
        Y = temFrame.origin.y + temFrame.height + dy
        W = SCREEN_WIDTH
        H = 0.5
        frameModel.lineViewFrame = CGRect(x: X, y: Y, width: W, height: H)
        temFrame = frameModel.lineViewFrame

        //行高
        frameModel.rowHeight = temFrame.origin.y + temFrame.height
    }
    
    //计算评论数据
    private class func setZanList(item: LLJCycleMessageModel) {
        let pre = String(format: "messageId = %@", item.messageId)
        let zanList: [LLJCycleZanModel] = LLJSCoreDataHelper().getRosource(entityName: "LLJCycleZanModel", predicate: pre) as! [LLJCycleZanModel]
    }
}
