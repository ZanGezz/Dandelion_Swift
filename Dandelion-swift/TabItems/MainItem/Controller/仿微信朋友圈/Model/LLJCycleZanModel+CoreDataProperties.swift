//
//  LLJCycleZanModel+CoreDataProperties.swift
//  
//
//  Created by 刘帅 on 2021/7/31.
//
//

import Foundation
import CoreData


extension LLJCycleZanModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LLJCycleZanModel> {
        return NSFetchRequest<LLJCycleZanModel>(entityName: "LLJCycleZanModel")
    }

    @NSManaged public var aUserId: Int64
    @NSManaged public var aUserName: String?
    @NSManaged public var bUserId: Int64
    @NSManaged public var bUserName: String?
    @NSManaged public var content: String?
    @NSManaged public var messageId: Int64
    @NSManaged public var timeInterval: Int64
    @NSManaged public var type: Int64
    @NSManaged public var userId: Int64

}
