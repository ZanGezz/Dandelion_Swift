//
//  LLJWeChatCycleModel+CoreDataProperties.swift
//  
//
//  Created by 刘帅 on 2021/7/21.
//
//

import Foundation
import CoreData


extension LLJWeChatCycleModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LLJWeChatCycleModel> {
        return NSFetchRequest<LLJWeChatCycleModel>(entityName: "LLJWeChatCycleModel")
    }

    @NSManaged public var headImageName: String?
    @NSManaged public var nickName: String?
    @NSManaged public var content: String?
    @NSManaged public var type: Int64
    @NSManaged public var webLinkModel: LLJCycleWebLinkModel?
    @NSManaged public var videoModel: LLJCycleVideoModel?
    @NSManaged public var imageModel: LLJCycleImageModel?
    @NSManaged public var zanModel: LLJCycleZanModel?

}
